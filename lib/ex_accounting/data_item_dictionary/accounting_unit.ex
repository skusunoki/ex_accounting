defmodule ExAccounting.DataItemDictionary.AccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  @typedoc "_Accounting Unit_"
  @type t :: %__MODULE__{accounting_unit: charlist}
  defstruct accounting_unit: nil

  @doc """
    [create] is function for generating valid AccountingUnit

  ## Examples

    iex> AccountingUnit.create(~C[1000])
    %AccountingUnit{ accounting_unit: ~C[1000]}

  """

  @spec create(String.t()) :: t()
  def create(accounting_unit) when is_binary(accounting_unit) do
    accounting_unit
    |> to_charlist()
    |> create()
  end

  @spec create(charlist) :: t()
  def create(accounting_unit) when length(accounting_unit) == 4 do
    case ExAccounting.Utility.validate(accounting_unit) do
      {:ok, validated} -> %__MODULE__{accounting_unit: validated}
      {:error, input} -> {:error, to_string(input) <> " is not valid"}
    end
  end
end
