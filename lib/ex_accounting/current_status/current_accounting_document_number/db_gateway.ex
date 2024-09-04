defmodule ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.DbGateway do
  import Ecto.Query
  alias ExAccounting.Elem.AccountingDocumentNumberRangeCode
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber
  alias ExAccounting.CurrentStatus.CurrentAccountingDocumentNumber.Changeset

  @typedoc "_Accounting Document Number Range Code_"
  @type number_range_code :: AccountingDocumentNumberRangeCode.t()

  @spec read(number_range_code) :: CurrentAccountingDocumentNumber.t()
  def read(
        %AccountingDocumentNumberRangeCode{
          accounting_document_number_range_code: code
        } = _number_range_code
      ) do
    from(p in CurrentAccountingDocumentNumber, where: p.number_range_code == ^code)
    |> ExAccounting.Repo.one()
  end

  @doc """
  Reads the current accounting document number from the database.
  """
  @spec read() :: [CurrentAccountingDocumentNumber.t()]
  def read() do
    CurrentAccountingDocumentNumber
    |> ExAccounting.Repo.all()
  end

  @spec save([CurrentAccountingDocumentNumber.t()]) ::
          {:ok, [Ecto.Changeset.t()]} | {:error, [Ecto.Changeset.t()]}
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

  defp accumulate_result({acc_result, acc_changeset}, {result, changeset}) do
    case result do
      :ok -> {acc_result, acc_changeset ++ [changeset]}
      _ -> {:error, acc_changeset ++ [changeset]}
    end
  end

  @spec insert(ExAccounting.Configuration.AccountingDocumentNumberRange.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp insert(accounting_document_number_range) do
    create()
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      current_document_number: accounting_document_number_range.current_document_number
    })
    |> ExAccounting.Repo.insert()
  end

  @spec update(ExAccounting.Configuration.AccountingDocumentNumberRange.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp update(accounting_document_number_range) do
    read(accounting_document_number_range.number_range_code)
    |> Changeset.changeset(%{
      number_range_code: accounting_document_number_range.number_range_code,
      current_document_number: accounting_document_number_range.current_document_number
    })
    |> ExAccounting.Repo.update()
  end

  defp create() do
    %CurrentAccountingDocumentNumber{}
  end
end
