defmodule ExAccounting.Configuration.AccountingUnit.DbGateway do
  @moduledoc false

  import Ecto.Query
  alias ExAccounting.Configuration.AccountingUnit
  alias ExAccounting.Configuration.AccountingUnit.Changeset

  @spec read() :: [AccountingUnit.t()]
  @spec read(ExAccounting.Elem.AccountingUnit.t()) ::
          ExAccounting.Configuration.AccountingUnit.t()
  def read() do
    AccountingUnit
    |> ExAccounting.Repo.all()
  end

  def read(accounting_unit) do
    from(p in ExAccounting.Configuration.AccountingUnit,
      where: p.accounting_unit == ^accounting_unit
    )
    |> ExAccounting.Repo.one()
  end

  @spec create() :: ExAccounting.Configuration.AccountingUnit.t()
  def create() do
    %ExAccounting.Configuration.AccountingUnit{}
  end

  @spec save(server :: [ExAccounting.Configuration.AccountingUnit.t()]) ::
          {:ok, [Ecto.Changeset.t()]} | {:error, [Ecto.Changeset.t()]}
  def save(server) do
    with db <- read() do
      result =
        server
        |> Enum.filter(fn x ->
          Enum.any?(db, fn y -> x.accounting_unit == y.accounting_unit end)
        end)
        |> Enum.map(fn x -> update(x) end)
        |> Enum.reduce({:ok, []}, fn {ok_error, changeset}, acc ->
          accumulate_result(acc, {ok_error, changeset})
        end)

      server
      |> Enum.filter(fn x ->
        not Enum.any?(db, fn y -> x.accounting_unit == y.accounting_unit end)
      end)
      |> Enum.map(fn x -> insert(x) end)
      |> Enum.reduce(result, fn {ok_error, changeset}, acc ->
        accumulate_result(acc, {ok_error, changeset})
      end)
    end
  end

  @spec insert(ExAccounting.Configuration.AccountingUnit.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp insert(accounting_unit) do
    create()
    |> Changeset.changeset(%{
      accounting_unit: accounting_unit.accounting_unit,
      accounting_unit_currency: accounting_unit.accounting_unit_currency,
      accounting_area: accounting_unit.accounting_area
    })
    |> ExAccounting.Repo.insert()
  end

  @spec update(ExAccounting.Configuration.AccountingUnit.t()) ::
          {:ok, Ecto.Changeset.t()} | {:error, Ecto.Changeset.t()}
  defp update(accounting_unit) do
    read(accounting_unit.accounting_unit)
    |> Changeset.changeset(%{
      accounting_unit: accounting_unit.accounting_unit,
      accounting_unit_currency: accounting_unit.accounting_unit_currency,
      accounting_area: accounting_unit.accounting_area
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
