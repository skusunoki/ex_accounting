defmodule ExAccounting.DataItemDictionary.AccountingArea do
  @moduledoc """
  AccountingArea is an organization unit for aggregation (consolidation) of multiple entities.
  """
  use Ecto.Type
  defstruct accounting_area: nil
  @typedoc "_Accounting Area_"
  @type t :: %__MODULE__{accounting_area: charlist}

  def type, do: :string

  def cast(%__MODULE__{} = accounting_area) do
    with %__MODULE__{accounting_area: code} <- accounting_area,
         {:ok, _} <- validate(code) do
      {:ok, accounting_area}
    else
      {:error, _reason} -> {:error, accounting_area}
      _ -> :error
    end
  end

  def cast(accounting_area) do
    with true <- is_list(accounting_area) or is_binary(accounting_area),
         {:ok, _} <- validate(ExAccounting.Utility.to_c(accounting_area)) do
      {:ok, create(accounting_area)}
    else
      _ -> {:error, accounting_area}
    end
  end

  def load(data) when is_binary(data) do
    with stdata = %{accounting_area: to_charlist(data)}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  def dump(accounting_area) do
    with %__MODULE__{accounting_area: code} <- accounting_area,
         {:ok, _validated} <- validate(code),
         dump = code |> to_string() do
      {:ok, dump}
    else
      _ -> :error
    end
  end

  @doc """
  Generate valid AccountingArea.

  ## Examples
      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.create(~C[0001])
      %AccountingArea{ accounting_area: ~C[0001]}
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

  @doc """
  Cast charlist or strings into the AccountingArea struct.

  ## Examples
      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast(~C[0001])
      {:ok, %AccountingArea{ accounting_area: ~C[0001] }}

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast("0001")
      {:ok, %AccountingArea{ accounting_area: ~C[0001] }}

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast(0001)
      {:error, 0001 }

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast(%ExAccounting.DataItemDictionary.AccountingArea{accounting_area: ~c[x1]})
      {:error, %ExAccounting.DataItemDictionary.AccountingArea{accounting_area: ~c[x1]} }

  """
  def validate(code) do
    with true <- code != nil,
         true <- is_list(code),
         true <- ExAccounting.Utility.len(code) == 4,
         {:ok, _validated} <- ExAccounting.Utility.validate(code) do
      {:ok, code}
    else
      false -> {:error, code}
      {:error, reason} -> {:error, reason}
    end
  end
end
