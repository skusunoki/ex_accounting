defmodule ExAccounting.Elem.AccountingAreaCurrency do
  @moduledoc """
  _Accounting Area Currency_ is the currency of transaction.
  """

  use Ecto.Type

  @typedoc "_Accounting Area Currency_"
  @type t :: %__MODULE__{accounting_area_currency: atom}

  defstruct accounting_area_currency: nil

  @doc """
  Defines the type of _Accounting Area Currency_ in database as string

  ## Examples

      iex> type()
      :string
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given _Money_ type value to valid journal entry form of _Accounting Area Currency_.

  ## Examples

      iex> cast(ExAccounting.Money.new(100, "USD"))
      {:ok, %AccountingAreaCurrency{accounting_area_currency: :USD}}
  """
  def cast(%ExAccounting.Money{} = money) do
    with {:ok, value} <- ExAccounting.Money.Currency.cast(money.currency) do
      {:ok, %__MODULE__{accounting_area_currency: value.currency}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps _Accounting Area Currency to string.

  ## Examples

      iex> dump(%AccountingAreaCurrency{accounting_area_currency: :USD})
      {:ok, "USD"}

  """
  @spec dump(t) :: String.t() | :error
  def dump(%__MODULE__{} = amount) do
    with %__MODULE__{accounting_area_currency: value} <- amount,
         true <- is_atom(value) do
      {:ok, to_string(value)}
    else
      _ -> :error
    end
  end

  @doc """
  Loads _Accounting Area Currency from the given database form.

  ## Examples

      iex> load("USD")
      {:ok, %AccountingAreaCurrency{accounting_area_currency: :USD}}

  """
  @spec load(String.t()) :: t | :error
  def load(data) do
    with true <- is_binary(data) do
      {:ok, %__MODULE__{accounting_area_currency: String.to_atom(data)}}
    else
      _ -> :error
    end
  end
end
