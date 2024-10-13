defmodule ExAccounting.Configuration.AccountingArea.DbGateway do
  import Ecto.Query
  alias ExAccounting.Configuration.AccountingArea

  @spec read() :: [AccountingArea.t()]
  @spec read(ExAccounting.Elem.AccountingArea.t()) ::
          ExAccounting.Configuration.AccountingArea.t()
  def read() do
    AccountingArea
    |> ExAccounting.Repo.all()
    |> ExAccounting.Repo.preload(:accounting_units)
    |> ExAccounting.Repo.preload(:accounting_document_number_ranges)
  end

  def read(accounting_area) do
    from(p in ExAccounting.Configuration.AccountingArea,
      where: p.accounting_area == ^accounting_area
    )
    |> ExAccounting.Repo.one()
    |> ExAccounting.Repo.preload(:accounting_units)
    |> ExAccounting.Repo.preload(:accounting_document_number_ranges)
  end

  def save(changeset) do
    ExAccounting.Repo.insert_or_update(changeset)
  end
end
