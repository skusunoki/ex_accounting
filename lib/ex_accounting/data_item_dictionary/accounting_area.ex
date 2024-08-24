defmodule ExAccounting.DataItemDictionary.AccountingArea do
  @moduledoc """
  AccountingArea is an organization unit for aggregation (consolidation) of multiple entities.
  """
  use Ecto.Type
  defstruct accounting_area: nil
  @typedoc "_Accounting Area_ : an organization unit for aggregation (consolidation) of multiple entities."
  @type t :: %__MODULE__{accounting_area: charlist}

  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given charlist or strings to the _Accounting Area_.
  The argument must be alphanumeric 4 letters. Lower case letters are not allowed.

  ## Examples
      iex> AccountingArea.cast(~C[0001])
      {:ok, %AccountingArea{accounting_area: ~C[0001] }}

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast("0001")
      {:ok, %AccountingArea{accounting_area: ~C[0001] }}

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast(0001)
      {:error, 0001}

      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.cast(%ExAccounting.DataItemDictionary.AccountingArea{accounting_area: ~c[x1]})
      {:error, %ExAccounting.DataItemDictionary.AccountingArea{accounting_area: ~c[x1]}}

  """

  def cast(%__MODULE__{} = term) do
    with %__MODULE__{accounting_area: code} <- term,
         {:ok, _} <- validate(code) do
      {:ok, term}
    else
      {:error, _reason} -> {:error, term}
      _ -> :error
    end
  end

  def cast(term) do
    with true <- is_list(term) or is_binary(term),
         {:ok, _} <- validate(ExAccounting.Utility.to_c(term)) do
      {:ok, create(term)}
    else
      _ -> {:error, term}
    end
  end

  def load(data) when is_binary(data) do
    with stdata = %{accounting_area: to_charlist(data)}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  def dump(term) do
    with %__MODULE__{accounting_area: code} <- term,
         {:ok, _validated} <- validate(code),
         dump = code |> to_string() do
      {:ok, dump}
    else
      _ -> :error
    end
  end

  @doc """
  Generates the valid _Accounting Area_ from the given charlist or strings.

  ## Examples
      iex> alias ExAccounting.DataItemDictionary.AccountingArea
      iex> AccountingArea.create(~C[0001])
      %AccountingArea{accounting_area: ~C[0001]}
  """
  @spec create(charlist) :: t()
  def create(term)
      when term != nil and is_list(term) and length(term) == 4 do
    %__MODULE__{accounting_area: term}
  end

  @spec create(binary) :: t()
  def create(term) when is_binary(term) and term != nil do
    term
    |> to_charlist()
    |> create()
  end

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
