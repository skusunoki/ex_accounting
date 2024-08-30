defmodule ExAccounting.Configuration.AccountingDocumentNumberRange.DbGateway do
  import Ecto.Query
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: AccountingDocumentNumberRangeCode.t()

  @spec read() :: [AccountingDocumentNumberRange.t()]
  def read() do
    AccountingDocumentNumberRange
    |> ExAccounting.Repo.all()
  end

  @spec read(number_range_code) :: AccountingDocumentNumberRange.t()
  def read(number_range_code) do
    from(p in AccountingDocumentNumberRange,
      where: p.number_range_code == ^number_range_code
    )
    |> ExAccounting.Repo.one()
  end

  @spec create() :: AccountingDocumentNumberRange.t()
  def create() do
    %AccountingDocumentNumberRange{}
  end
end
