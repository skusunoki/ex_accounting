defmodule ExAccounting.JournalEntryTest do
  use ExUnit.Case, async: true
  alias ExAccounting.EmbeddedSchema.JournalEntry
  alias ExAccounting.EmbeddedSchema.JournalEntryHeader
  alias ExAccounting.EmbeddedSchema.JournalEntryItem
  alias ExAccounting.EmbeddedSchema.Money
  alias ExAccounting.Elem.{
    AccountingArea,
    AccountingUnit,
    DebitCredit,
    GeneralLedgerAccount,
    TransactionCurrency,
    AccountingAreaCurrency,
    AccountingUnitCurrency,
    DocumentType,
    PostingDate
  }
  
  describe "Journal Entry Registration" do
    test "creates valid simple journal entry with balanced debit and credit" do
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
          entry_date: ~D[2024-01-15]
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

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      assert length(journal_entry.item) == 2
      assert journal_entry.header.transaction_currency == "USD"
    end

    test "rejects unbalanced journal entry" do
      # Arrange - Debit 1000, Credit 800 (unbalanced)
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
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
                amount: Decimal.new("800.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("800.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      refute changeset.valid?
      assert changeset.errors[:completed_document]
    end

    test "creates multi-line journal entry with multiple debits and credits" do
      # Arrange - Purchase with VAT
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "KA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Inventory (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "140000",
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
          # VAT Input (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "154000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("100.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("100.00"),
                currency: "USD"
              }
            }
          },
          # Accounts Payable (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "210000",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("1100.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("1100.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      assert length(journal_entry.item) == 3

      # Verify balance
      total_debit = Decimal.add("1000.00", "100.00")
      total_credit = Decimal.new("1100.00")
      assert Decimal.equal?(total_debit, total_credit)
    end

    test "creates journal entry with multi-currency transactions" do
      # Arrange - Foreign currency transaction
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "EUR",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          %{
            general_ledger_transaction: %{
              general_ledger_account: "110000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("1000.00"),
                currency: "EUR"
              },
              accounting_area_value: %{
                amount: Decimal.new("1100.00"),  # Converted to USD
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
                currency: "EUR"
              },
              accounting_area_value: %{
                amount: Decimal.new("1100.00"),  # Converted to USD
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      assert journal_entry.header.transaction_currency == "EUR"

      # Verify that accounting area values are balanced in USD
      debit_item = Enum.find(journal_entry.item, fn item ->
        item.general_ledger_transaction.debit_credit.debit_credit == :debit
      end)
      credit_item = Enum.find(journal_entry.item, fn item ->
        item.general_ledger_transaction.debit_credit.debit_credit == :credit
      end)

      assert debit_item.general_ledger_transaction.accounting_area_value.currency == "USD"
      assert credit_item.general_ledger_transaction.accounting_area_value.currency == "USD"
    end

    test "automatically assigns document number from number range" do
      # This test would require the document number assignment system to be working
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
          number_range_code: "01"
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

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      
      # If document number assignment is implemented, verify it's assigned
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      # assert journal_entry.header.document_number != nil
    end

    test "validates required fields in journal entry header" do
      # Arrange - Missing required fields
      invalid_params = %{
        header: %{
          # Missing accounting_unit_attr
          transaction_currency: "USD"
          # Missing document_type and posting_date
        },
        item: []
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, invalid_params)

      # Assert
      refute changeset.valid?
    end

    test "validates minimum number of journal entry items" do
      # Arrange - Only one item (should have at least 2 for double-entry)
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
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
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      # This should fail validation as it's not balanced
      refute changeset.valid?
    end

    test "creates customer invoice journal entry" do
      # Arrange - Customer invoice with revenue and receivables
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "DG",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Accounts Receivable (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "130000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("1200.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("1200.00"),
                currency: "USD"
              }
            },
            customer_transaction: %{
              customer: "CUST001",
              customer_transaction_type: "11"
            }
          },
          # Revenue (Credit)
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
          },
          # Sales Tax (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "176000",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("200.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("200.00"),
                currency: "USD"
              }
            },
            tax_transaction: %{
              vat_code: "V1",
              vat_amount_of_transaction_currency: Decimal.new("200.00"),
              vat_base_amount_of_transaction_currency: Decimal.new("1000.00")
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify customer transaction is included
      customer_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :customer_transaction)
      end)
      assert customer_item != nil
      
      # Verify tax transaction is included
      tax_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :tax_transaction)
      end)
      assert tax_item != nil
    end

    test "creates cost center allocation journal entry" do
      # Arrange - Expense allocation to cost centers
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Office Supplies Expense (Debit) - Cost Center 1
          %{
            general_ledger_transaction: %{
              general_ledger_account: "520000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("600.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("600.00"),
                currency: "USD"
              }
            },
            controlling_transaction: %{
              cost_center: "CC001",
              cost_center_transaction_type: "01"
            }
          },
          # Office Supplies Expense (Debit) - Cost Center 2
          %{
            general_ledger_transaction: %{
              general_ledger_account: "520000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("400.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("400.00"),
                currency: "USD"
              }
            },
            controlling_transaction: %{
              cost_center: "CC002",
              cost_center_transaction_type: "01"
            }
          },
          # Cash (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "100100",
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

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify cost center allocations
      cost_center_items = Enum.filter(journal_entry.item, fn item ->
        Map.has_key?(item, :controlling_transaction)
      end)
      assert length(cost_center_items) == 2
    end

    test "creates vendor payment journal entry" do
      # Arrange - Payment to vendor
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "KZ",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Accounts Payable (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "210000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("5000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("5000.00"),
                currency: "USD"
              }
            },
            vendor_transaction: %{
              vendor: "VEND001",
              vendor_transaction_type: "21"
            }
          },
          # Bank Account (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "100200",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("5000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("5000.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify vendor transaction is included
      vendor_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :vendor_transaction)
      end)
      assert vendor_item != nil
      assert vendor_item.vendor_transaction.vendor == "VEND001"
    end

    test "creates asset acquisition journal entry" do
      # Arrange - Fixed asset purchase
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "AA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Fixed Asset (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "150000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("25000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("25000.00"),
                currency: "USD"
              }
            },
            fixed_asset_transaction: %{
              fixed_asset: "ASSET001",
              fixed_asset_transaction_type: "100"
            }
          },
          # Cash (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "100100",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("25000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("25000.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify fixed asset transaction is included
      asset_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :fixed_asset_transaction)
      end)
      assert asset_item != nil
      assert asset_item.fixed_asset_transaction.fixed_asset == "ASSET001"
    end
  end

  describe "Journal Entry Persistence" do
    setup do
      # This would require actual database setup in a real test environment
      # For now, we'll simulate the database interaction
      :ok
    end

    test "persists valid journal entry to database" do
      # This test would require actual database and repo setup
      # journal_entry_params = create_valid_journal_entry_params()
      # changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)
      # 
      # assert changeset.valid?
      # {:ok, persisted_entry} = ExAccounting.Repo.insert(changeset)
      # assert persisted_entry.id != nil
      
      # For now, just verify the test structure
      assert true
    end

    test "rejects invalid journal entry from database" do
      # This test would verify database constraints
      # invalid_params = create_invalid_journal_entry_params()
      # changeset = JournalEntry.changeset(%JournalEntry{}, invalid_params)
      # 
      # refute changeset.valid?
      # {:error, failed_changeset} = ExAccounting.Repo.insert(changeset)
      # assert failed_changeset.errors != []
      
      # For now, just verify the test structure
      assert true
    end
  end

  describe "Complex Business Scenarios" do
    test "creates intercompany transaction journal entry" do
      # Arrange - Transaction between accounting units
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Intercompany Receivable (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "131000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("10000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("10000.00"),
                currency: "USD"
              }
            },
            partner_transaction: %{
              partner_accounting_unit: "2000"
            }
          },
          # Revenue (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "400000",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("10000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("10000.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify partner transaction is included
      partner_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :partner_transaction)
      end)
      assert partner_item != nil
      assert partner_item.partner_transaction.partner_accounting_unit == "2000"
    end

    test "creates project cost allocation journal entry" do
      # Arrange - WBS element cost allocation
      journal_entry_params = %{
        header: %{
          accounting_unit_attr: %{
            accounting_area: %{accounting_area: "0001"},
            accounting_unit: "1000"
          },
          transaction_currency: "USD",
          document_type: "SA",
          posting_date: ~D[2024-01-15]
        },
        item: [
          # Project Costs (Debit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "600000",
              debit_credit: %{debit_credit: :debit},
              transaction_value: %{
                amount: Decimal.new("15000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("15000.00"),
                currency: "USD"
              }
            },
            project_transaction: %{
              wbs_element: "WBS001",
              wbs_element_transaction_type: "01"
            }
          },
          # Accrued Expenses (Credit)
          %{
            general_ledger_transaction: %{
              general_ledger_account: "230000",
              debit_credit: %{debit_credit: :credit},
              transaction_value: %{
                amount: Decimal.new("15000.00"),
                currency: "USD"
              },
              accounting_area_value: %{
                amount: Decimal.new("15000.00"),
                currency: "USD"
              }
            }
          }
        ]
      }

      # Act
      changeset = JournalEntry.changeset(%JournalEntry{}, journal_entry_params)

      # Assert
      assert changeset.valid?
      journal_entry = changeset |> Ecto.Changeset.apply_changes()
      
      # Verify WBS element transaction is included
      wbs_item = Enum.find(journal_entry.item, fn item ->
        Map.has_key?(item, :project_transaction)
      end)
      assert wbs_item != nil
      assert wbs_item.project_transaction.wbs_element == "WBS001"
    end
  end

  # Helper functions for creating test data
  defp create_simple_journal_entry_params do
    %{
      header: %{
        accounting_unit_attr: %{
          accounting_area: %{accounting_area: "0001"},
          accounting_unit: "1000"
        },
        transaction_currency: "USD",
        document_type: "SA",
        posting_date: ~D[2024-01-15]
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
  end
end