defmodule ExAccounting.Configuration.AccountingDocumentNumberRange.DbGateway do
  @moduledoc false

  import Ecto.Query
  alias ExAccounting.Configuration.AccountingDocumentNumberRange
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.Configuration.AccountingDocumentNumberRange.Changeset

  # TODO: organize the db_gateway module and changeset module

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

  def save(server) do
    with db <- read() do
      result =
        server
        |> Enum.filter(fn x ->
          Enum.any?(db, fn y -> x.number_range_code == y.number_range_code end)
        end)
        |> Enum.map(fn x -> update(x) end)
        |> Enum.reduce({:ok, []}, fn {ok_error, changeset}, acc ->
          accumulate_result(acc, {ok_error, changeset})
        end)

      server
      |> Enum.filter(fn x ->
        not Enum.any?(db, fn y -> x.number_range_code == y.number_range_code end)
      end)
      |> Enum.map(fn x -> insert(x) end)
      |> Enum.reduce(result, fn {ok_error, changeset}, acc ->
        accumulate_result(acc, {ok_error, changeset})
      end)
    end
  end

  @spec insert(ExAccounting.Configuration.AccountingDocumentNumberRange.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp insert(accounting_document_number_range) do
    create()
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      accounting_document_number_from:
        accounting_document_number_range.accounting_document_number_from,
      accounting_document_number_to:
        accounting_document_number_range.accounting_document_number_to
    })
    |> ExAccounting.Repo.insert()
  end

  @spec update(ExAccounting.Configuration.AccountingDocumentNumberRange.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp update(accounting_document_number_range) do
    read(accounting_document_number_range.number_range_code)
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      accounting_document_number_from:
        accounting_document_number_range.accounting_document_number_from,
      accounting_document_number_to:
        accounting_document_number_range.accounting_document_number_to
    })
    |> ExAccounting.Repo.update()
  end

  defp accumulate_result({acc_result, acc_changeset}, {result, changeset}) do
    case result do
      :ok -> {acc_result, acc_changeset ++ [changeset]}
      _ -> {:error, acc_changeset ++ [changeset]}
    end
  end
end
