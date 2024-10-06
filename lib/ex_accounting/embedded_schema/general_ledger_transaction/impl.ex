defmodule ExAccounting.EmbeddedSchema.GeneralLedgerTransaction.Impl do
  @moduledoc false

  import Ecto.Changeset

  def changeset(general_ledger_transaction, params) do
    general_ledger_transaction
    |> cast(params, [
      :accounting_area,
      :accounting_unit,
      :profit_center,
      :fiscal_year,
      :accounting_period,
      :posting_date,
      :general_ledger_account,
      :general_ledger_account_transaction_type,
      :debit_credit,
      :accounting_document_number,
      :accounting_document_item_number
    ])
    |> validate_inclusion(:general_ledger_account_transaction_type, enum_general_ledger_account_transaction_type([
      "100",
      "200",
      "300",
      "400",
      "500",
      "600",
      "700",
      "800",
      "900"
    ]))
    |> validate_inclusion(:debit_credit, enum_debit_credit([:debit, :credit]))
    |> cast_embed(:transaction_value, with: &ExAccounting.EmbeddedSchema.Money.changeset/2)
    |> cast_embed(:accounting_area_value, with: &ExAccounting.EmbeddedSchema.Money.changeset/2)
    |> cast_embed(:accounting_unit_value, with: &ExAccounting.EmbeddedSchema.Money.changeset/2)
  end

  def enum_debit_credit(list) when is_list(list) do
    list
    |> Enum.map( fn x -> with {:ok, code} <- ExAccounting.Elem.DebitCredit.cast(x), do: code end)
  end

  def enum_general_ledger_account_transaction_type(list) when is_list(list) do
    list
    |> Enum.map( fn x -> with {:ok, code} <- ExAccounting.Elem.GeneralLedgerAccountTransactionType.cast(x), do: code end)
  end
end
