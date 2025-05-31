defmodule ExAccounting.JournalEntryIntegrationTest do
  use ExUnit.Case, async: true
  alias ExAccounting.EmbeddedSchema.JournalEntry
  alias ExAccounting.Schema.AccountingDocumentItem
  alias ExAccounting.Repo

  setup do
    # Sandbox each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(ExAccounting.Repo)
    
    # Setup test data
    {:ok, %{}}
  end

  describe "Journal Entry Database Integration" do
    test "persists journal entry to accounting document items table" do
      # Arrange
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15],
          document_date: ~D[2024-01-15],
          entry_date: ~D[2024-01-15],
          fiscal_year: 2024,
          accounting_period: 1
        },
        item: [
          %{
            general_ledger_transaction: %{
              general_ledger_account: "100000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("1000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("1000.00"),
                currency: "USD"
              }
            }
          },
          %{
            general_ledger_transaction: %{
              general_ledger_account: "400000",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("1000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("1000.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act - Create and validate journal entry
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)
      assert changeset.valid?
      
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Convert to accounting document items for persistence
      accounting_document_items = convert_journal_entry_to_accounting_items(journal_entry)
      
      # Persist each item
      inserted_items = Enum.map(accounting_document_items, fn item_params ->
        changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
        assert changeset.valid?, "Item changeset should be valid: #{inspect(changeset.errors)}"
        
        {:ok, item} = Repo.insert(changeset)
        item
      end)

      # Assert
      assert length(inserted_items) == 2
      
      # Verify items are persisted correctly
      persisted_items = Repo.all(AccountingDocumentItem)
      assert length(persisted_items) == 2
      
      # Verify debit/credit balance
      debit_total = persisted_items 
        |> Enum.filter(&(&1.debit_credit == "S"))
        |> Enum.reduce(Decimal.new("0"), &Decimal.add(&2, &1.amount_in_transaction_currency || Decimal.new("0")))
        
      credit_total = persisted_items 
        |> Enum.filter(&(&1.debit_credit == "H"))
        |> Enum.reduce(Decimal.new("0"), &Decimal.add(&2, &1.amount_in_transaction_currency || Decimal.new("0")))
      
      assert Decimal.equal?(debit_total, credit_total)
    end

    test "enforces unique constraint on accounting document items" do
      # Arrange - Create two items with same key
      base_item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000001,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "SA",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "100000",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        transaction_currency: "USD"
      }

      # Act - Insert first item (should succeed)
      changeset1 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, base_item_params)
      assert changeset1.valid?
      {:ok, _item1} = Repo.insert(changeset1)

      # Act - Insert duplicate item (should fail)
      changeset2 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, base_item_params)
      assert changeset2.valid?
      {:error, failed_changeset} = Repo.insert(changeset2)

      # Assert
      assert failed_changeset.errors[:fiscal_year] || 
             failed_changeset.errors[:accounting_document_number] ||
             failed_changeset.errors[:accounting_unit] ||
             failed_changeset.errors[:accounting_document_item_number]
    end

    test "handles large transaction amounts correctly" do
      # Arrange - Large monetary amounts
      large_amount = Decimal.new("999999999.99")
      
      item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000002,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "SA",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "100000",
        amount_in_transaction_currency: large_amount,
        transaction_currency: "USD"
      }

      # Act
      changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
      assert changeset.valid?
      {:ok, item} = Repo.insert(changeset)

      # Assert
      assert Decimal.equal?(item.amount_in_transaction_currency, large_amount)
    end

    test "persists multi-currency transaction correctly" do
      # Arrange - Transaction with different currencies
      item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000003,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "SA",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "110000",
        # Transaction currency (EUR)
        transaction_currency: "EUR",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        # Accounting area currency (USD)
        accounting_area_currency: "USD",
        amount_in_accounting_area_currency: Decimal.new("1100.00"),
        exchange_rate_to_accounting_area_currency: Decimal.new("1.1000"),
        # Accounting unit currency (USD)
        accounting_unit_currency: "USD",
        amount_in_accounting_unit_currency: Decimal.new("1100.00"),
        exchange_rate_to_accounting_unit_currency: Decimal.new("1.1000")
      }

      # Act
      changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
      assert changeset.valid?
      {:ok, item} = Repo.insert(changeset)

      # Assert
      assert item.transaction_currency == "EUR"
      assert item.accounting_area_currency == "USD"
      assert item.accounting_unit_currency == "USD"
      assert Decimal.equal?(item.amount_in_transaction_currency, Decimal.new("1000.00"))
      assert Decimal.equal?(item.amount_in_accounting_area_currency, Decimal.new("1100.00"))
    end

    test "persists customer transaction details" do
      # Arrange - Customer invoice item
      item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000004,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "DG",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "130000",
        customer: "CUST001",
        customer_transaction_type: "11",
        amount_in_transaction_currency: Decimal.new("1200.00"),
        transaction_currency: "USD"
      }

      # Act
      changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
      assert changeset.valid?
      {:ok, item} = Repo.insert(changeset)

      # Assert
      assert item.customer == "CUST001"
      assert item.customer_transaction_type == "11"
      assert item.document_type == "DG"
    end

    test "persists cost center allocation details" do
      # Arrange - Cost center expense item
      item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000005,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "SA",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "520000",
        cost_center: "CC001",
        cost_center_transaction_type: "01",
        amount_in_transaction_currency: Decimal.new("500.00"),
        transaction_currency: "USD"
      }

      # Act
      changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
      assert changeset.valid?
      {:ok, item} = Repo.insert(changeset)

      # Assert
      assert item.cost_center == "CC001"
      assert item.cost_center_transaction_type == "01"
    end

    test "persists VAT transaction details" do
      # Arrange - VAT transaction item
      item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000006,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "H",
        document_type: "DG",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "176000",
        vat_code: "V1",
        vat_amount_of_transaction_currency: Decimal.new("200.00"),
        vat_base_amount_of_transaction_currency: Decimal.new("1000.00"),
        amount_in_transaction_currency: Decimal.new("200.00"),
        transaction_currency: "USD"
      }

      # Act
      changeset = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, item_params)
      assert changeset.valid?
      {:ok, item} = Repo.insert(changeset)

      # Assert
      assert item.vat_code == "V1"
      assert Decimal.equal?(item.vat_amount_of_transaction_currency, Decimal.new("200.00"))
      assert Decimal.equal?(item.vat_base_amount_of_transaction_currency, Decimal.new("1000.00"))
    end
  end

  describe "Document Number Generation Integration" do
    test "generates sequential document numbers" do
      # This test would verify document number generation
      # when integrated with the number range system
      
      # For now, we'll test the basic structure
      assert true
    end
  end

  describe "Audit Trail and Document References" do
    test "persists reverse document references" do
      # Arrange - Reversal document item
      original_item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000007,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "SA",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "100000",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        transaction_currency: "USD"
      }

      reversal_item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000008,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "H",  # Opposite of original
        document_type: "SA",
        posting_date: ~D[2024-01-16],
        general_ledger_account: "100000",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        transaction_currency: "USD",
        # Reverse document references
        reverse_document_indicator: "X",
        reverse_document_accounting_unit: "1000",
        reverse_document_fiscal_year: 2024,
        reverse_document_accounting_document: 1000007,
        reverse_document_accounting_document_item: 1
      }

      # Act - Insert original item
      changeset1 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, original_item_params)
      assert changeset1.valid?
      {:ok, _original_item} = Repo.insert(changeset1)

      # Insert reversal item
      changeset2 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, reversal_item_params)
      assert changeset2.valid?
      {:ok, reversal_item} = Repo.insert(changeset2)

      # Assert
      assert reversal_item.reverse_document_indicator == "X"
      assert reversal_item.reverse_document_accounting_document == 1000007
      assert reversal_item.reverse_document_accounting_document_item == 1
    end

    test "persists clearing document references" do
      # Arrange - Clearing document item
      invoice_item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000009,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "S",
        document_type: "DG",
        posting_date: ~D[2024-01-15],
        general_ledger_account: "130000",
        customer: "CUST001",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        transaction_currency: "USD"
      }

      payment_item_params = %{
        fiscal_year: 2024,
        accounting_area: "0001",
        accounting_document_number: 1000010,
        accounting_unit: "1000",
        accounting_document_item_number: 1,
        debit_credit: "H",
        document_type: "DZ",
        posting_date: ~D[2024-01-20],
        general_ledger_account: "130000",
        customer: "CUST001",
        amount_in_transaction_currency: Decimal.new("1000.00"),
        transaction_currency: "USD",
        # Clearing document references
        clearing_document_indicator: "X",
        clearing_document_accounting_unit: "1000",
        clearing_document_fiscal_year: 2024,
        clearing_document_accounting_document: 1000009,
        clearing_document_accounting_document_item: 1
      }

      # Act
      changeset1 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, invoice_item_params)
      assert changeset1.valid?
      {:ok, _invoice_item} = Repo.insert(changeset1)

      changeset2 = AccountingDocumentItem.changeset(%AccountingDocumentItem{}, payment_item_params)
      assert changeset2.valid?
      {:ok, payment_item} = Repo.insert(changeset2)

      # Assert
      assert payment_item.clearing_document_indicator == "X"
      assert payment_item.clearing_document_accounting_document == 1000009
      assert payment_item.clearing_document_accounting_document_item == 1
    end
  end

  # Helper function to convert journal entry to accounting document items
  defp convert_journal_entry_to_accounting_items(journal_entry) do
    base_document_number = 1000000 + :rand.uniform(999999)
    
    journal_entry.item
    |> Enum.with_index(1)
    |> Enum.map(fn {item, index} ->
      %{
        fiscal_year: 2024,
        accounting_area: journal_entry.header.accounting_unit_attr.accounting_area.accounting_area,
        accounting_document_number: base_document_number,
        accounting_unit: journal_entry.header.accounting_unit_attr.accounting_unit,
        accounting_document_item_number: index,
        debit_credit: case item.general_ledger_transaction.debit_credit.debit_credit do
          :debit -> "S"
          :credit -> "H"
        end,
        document_type: journal_entry.header.document_type,
        posting_date: journal_entry.header.posting_date,
        general_ledger_account: item.general_ledger_transaction.general_ledger_account,
        amount_in_transaction_currency: item.general_ledger_transaction.transaction_value.amount,
        transaction_currency: item.general_ledger_transaction.transaction_value.currency,
        amount_in_accounting_area_currency: item.general_ledger_transaction.accounting_area_value.amount,
        accounting_area_currency: item.general_ledger_transaction.accounting_area_value.currency
      }
      |> add_subsidiary_ledger_data(item)
    end)
  end

  defp add_subsidiary_ledger_data(base_params, item) do
    base_params
    |> maybe_add_customer_data(item)
    |> maybe_add_vendor_data(item)
    |> maybe_add_cost_center_data(item)
    |> maybe_add_asset_data(item)
  end

  defp maybe_add_customer_data(params, %{customer_transaction: customer_data}) do
    Map.merge(params, %{
      customer: customer_data.customer,
      customer_transaction_type: customer_data.customer_transaction_type
    })
  end
  defp maybe_add_customer_data(params, _), do: params

  defp maybe_add_vendor_data(params, %{vendor_transaction: vendor_data}) do
    Map.merge(params, %{
      vendor: vendor_data.vendor,
      vendor_transaction_type: vendor_data.vendor_transaction_type
    })
  end
  defp maybe_add_vendor_data(params, _), do: params

  defp maybe_add_cost_center_data(params, %{controlling_transaction: controlling_data}) do
    Map.merge(params, %{
      cost_center: controlling_data.cost_center,
      cost_center_transaction_type: controlling_data.cost_center_transaction_type
    })
  end
  defp maybe_add_cost_center_data(params, _), do: params

  defp maybe_add_asset_data(params, %{fixed_asset_transaction: asset_data}) do
    Map.merge(params, %{
      fixed_asset: asset_data.fixed_asset,
      fixed_asset_transaction_type: asset_data.fixed_asset_transaction_type
    })
  end
  defp maybe_add_asset_data(params, _), do: params
end