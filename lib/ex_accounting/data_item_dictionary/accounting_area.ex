defmodule ExAccounting.DataItemDictionary.AccountingArea do
  use Ecto.Type
  def type, do: :string

  @moduledoc """
  AccountingArea is an organization unit for aggregation (consolidation) of multiple entities.
  """
  @type t :: %__MODULE__{accounting_area: charlist}
  defstruct accounting_area: nil

  @doc """
    [create] is function for generating valid AccountingArea.

  ## Examples

    iex> AccountingArea.create(~C[0001])
    %AccountingArea{ accounting_area: ~C[0001] }
  """
  @spec create(charlist) :: t()
  def create(accounting_area)
      when accounting_area != nil and is_list(accounting_area) and length(accounting_area) == 4 do
    %__MODULE__{accounting_area: accounting_area}
  end

  @spec create(binary) :: t()
  def create(accounting_area) when is_binary(accounting_area) and accounting_area != nil do
    accounting_area
    |> to_charlist()
    |> create()
  end

  def cast(%__MODULE__{} = accounting_area), do: {:ok, accounting_area}

  def cast(accounting_area) do
    with true <- is_list(accounting_area) or is_binary(accounting_area),
         true <- accounting_area != nil,
         true <- len(accounting_area) == 4,
         {:ok, validated} <- ExAccounting.Utility.validate(to_c(accounting_area)) do
      {:ok, create(validated)}
    else
      false -> {:error, accounting_area}
      {:error, keyword} -> {:error, keyword}
    end
  end

  def load(data) when is_binary(data) do
    stdata = %{accounting_area: to_charlist(data)}
    {:ok, struct!(__MODULE__, stdata)}
  end

  def dump(%__MODULE__{accounting_area: data} = _accounting_area) when is_list(data) do
    dump =
      data
      |> to_string()

    {:ok, dump}
  end

  def dump(_), do: :error

  def len(term) when is_list(term) do
    length(term)
  end

  def len(term) when is_binary(term) do
    String.length(term)
  end

  def to_c(term) when is_list(term) do
    term
  end

  def to_c(term) when is_binary(term) do
    to_charlist(term)
  end
end
