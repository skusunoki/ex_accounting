defmodule ExAccounting.TypeTest do
  use ExUnit.Case
  doctest ExAccounting.Type, import: true

  # Internal module for testing
  defmodule Employee do
    use ExAccounting.Type
    entity(:employee, length: 10, description: "Employee")
  end

  defmodule PostingDate do
    use ExAccounting.Type
    date(:posting_date, description: "Posting Date")
  end

  defmodule PostedBy do
    use ExAccounting.Type
    username(:user_name, description: "Posted By")
  end

  defmodule PriceCurrency do
    use ExAccounting.Type
    currency(:price_currency, description: "Price Currency")
  end

  defmodule Default do
    use ExAccounting.Type
    indicator(:is_default, description: "Default")
  end

  defmodule YearOfActivatedFrom do
    use ExAccounting.Type
    year(:year, description: "Year of Activated From")
  end

  defmodule UnitPrice do
    use ExAccounting.Type
    amount(:unit_price, description: "Unit Price")
  end

  defmodule Language do
    use ExAccounting.Type
    code(:language, length: 2, description: "Language")
  end

  defmodule PurchaseRequisition do
    use Ecto.Schema
    import Ecto.Changeset

    schema "purchase_requisitions" do
      field(:posting_date, ExAccounting.TypeTest.PostingDate)
      field(:posted_by, ExAccounting.TypeTest.PostedBy)

      embeds_one :communication, Communication do
        field(:employee, ExAccounting.TypeTest.Employee)
        field(:field_lang, ExAccounting.TypeTest.Language)
        field(:default, ExAccounting.TypeTest.Default)
      end

      embeds_many :item, Item, primary_key: false do
        field(:unit_price, ExAccounting.TypeTest.UnitPrice)
        field(:price_currency, ExAccounting.TypeTest.PriceCurrency)
      end
    end

    def changeset_communication(struct, params \\ %{}) do
      struct
      |> cast(params, [:field_lang, :default, :employee])
    end

    def changeset_item(struct, params \\ %{}) do
      struct
      |> cast(params, [:unit_price, :price_currency])
    end
  end

  # Tests
  alias ExAccounting.TypeTest.{
    Employee,
    PostingDate,
    PostedBy,
    PriceCurrency,
    Default,
    YearOfActivatedFrom,
    UnitPrice,
    PurchaseRequisition
  }

  alias ExAccounting.TypeTest.PurchaseRequisition.{
    Communication,
    Item
  }

  test "Posting Date" do
    assert PostingDate.cast(~D[2021-01-01]) == {:ok, %PostingDate{posting_date: ~D[2021-01-01]}}
  end

  test "Posted By" do
    assert PostedBy.cast("john_doe") == {:ok, %PostedBy{user_name: ~c"john_doe"}}
  end

  test "Price Currency" do
    with {:ok, curr} <- ExAccounting.EmbeddedSchema.Money.new(100, "USD") do
      assert PriceCurrency.cast(curr) ==
               {:ok, %PriceCurrency{price_currency: "USD"}}
    end
  end

  test "Employee" do
    assert Employee.cast("0001001") == {:ok, %Employee{employee: ~c"0001001"}}
  end

  test "Default" do
    assert Default.cast(true) == {:ok, %Default{is_default: true}}
  end

  test "Year of Activated from" do
    assert YearOfActivatedFrom.cast(2021) == {:ok, %YearOfActivatedFrom{year: 2021}}
  end

  test "Unit Price" do
    with {:ok, price} <- ExAccounting.EmbeddedSchema.Money.new(100, "USD") do
      assert UnitPrice.cast(price) ==
               {:ok, %UnitPrice{unit_price: price}}
    end
  end

  test "Changeset of Embedded Schema" do
    with expected = %PurchaseRequisition{
           posting_date: %PostingDate{posting_date: ~D[2024-10-01]},
           posted_by: %PostedBy{user_name: ~c"johndoe"},
           communication: %Communication{
             employee: %Employee{employee: ~c"0001001"},
             field_lang: %Language{language: ~c"EN"},
             default: %Default{is_default: true}
           },
           item: [
             %Item{
               unit_price: %UnitPrice{unit_price: Decimal.new("100")},
               price_currency: %PriceCurrency{price_currency: :USD}
             },
             %Item{
               unit_price: %UnitPrice{unit_price: Decimal.new("200")},
               price_currency: %PriceCurrency{price_currency: :USD}
             }
           ]
         },
         parameter = %{
           posting_date: ~D[2024-10-01],
           posted_by: "johndoe",
           communication: %{employee: "0001001", field_lang: "EN", default: true},
           item: [
             %{unit_price: 100, price_currency: "USD"},
             %{unit_price: 200, price_currency: "USD"}
           ]
         },
         result =
           %PurchaseRequisition{}
           |> Ecto.Changeset.cast(parameter, [:posting_date, :posted_by])
           |> Ecto.Changeset.cast_embed(:communication,
             with: &PurchaseRequisition.changeset_communication/2
           )
           |> Ecto.Changeset.cast_embed(:item, with: &PurchaseRequisition.changeset_item/2)
           |> Ecto.Changeset.apply_changes() do
      assert result == expected
    end
  end
end
