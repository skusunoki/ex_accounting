defmodule ExAccounting.Configuration.AccountingArea.DbGateway do
  import Ecto.Query
  alias ExAccounting.Configuration.AccountingArea

  @spec read() :: [AccountingArea.t()]
  @spec read(ExAccounting.Elem.AccountingArea.t()) ::
          ExAccounting.Configuration.AccountingArea.t()
  def read() do
    ExAccounting.Repo.all(
      from(p in AccountingArea,
        left_join: u in assoc(p, :accounting_units),
        left_join: _ in assoc(u, :accounting_document_number_range_determinations),
        left_join: _ in assoc(p, :accounting_document_number_ranges),
        preload: [
          :accounting_document_number_ranges,
          accounting_units: {u, :accounting_document_number_range_determinations}
        ]
      )
    )
  end

  def read(accounting_area) do
    ExAccounting.Repo.one(
      from(p in AccountingArea,
        left_join: u in assoc(p, :accounting_units),
        left_join: _ in assoc(u, :accounting_document_number_range_determinations),
        left_join: _ in assoc(p, :accounting_document_number_ranges),
        where: p.accounting_area == ^accounting_area
      )
    )
  end

  def save(changeset) do
    ExAccounting.Repo.insert_or_update(changeset)
  end
end
