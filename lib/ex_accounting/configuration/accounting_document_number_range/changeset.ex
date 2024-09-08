defmodule ExAccounting.Configuration.AccountingDocumentNumberRange.Changeset do
  @moduledoc false

  import Ecto.Changeset

  def changeset(accounting_document_number_range, params \\ %{}) do
    accounting_document_number_range
    |> cast(params, [
      :number_range_code,
      :accounting_document_number_from,
      :accounting_document_number_to
    ])
    |> unique_constraint([:number_range_code])
  end
end
