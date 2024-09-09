defmodule ExAccounting.Elem.AccountingUnitCurrency do
  @moduledoc """
  _Accounting Unit Currency_ is the currency of transaction.
  """

  use Ecto.Type

  @typedoc "_Accounting Unit Currency_"
  @type t :: %__MODULE__{accounting_unit_currency: atom}

  defstruct accounting_unit_currency: nil

  @doc """
  Defines the type of _Accounting Unit Currency_ in database as string

  ## Examples

      iex> type()
      :string
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given _Money_ type value to valid journal entry form of _Accounting Unit Currency_.

  ## Examples

      iex> cast(ExAccounting.EmbeddedSchema.Money.new(100, "USD"))
      {:ok, %AccountingUnitCurrency{accounting_unit_currency: :USD}}
  """
  def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
    with {:ok, value} <- ExAccounting.Elem.Currency.cast(money.currency) do
      {:ok, %__MODULE__{accounting_unit_currency: value.currency}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps _Accounting Unit Currency to string.

  ## Examples

      iex> dump(%AccountingUnitCurrency{accounting_unit_currency: :USD})
      {:ok, "USD"}

  """
  @spec dump(t) :: String.t() | :error
  def dump(%__MODULE__{} = amount) do
    with %__MODULE__{accounting_unit_currency: value} <- amount,
         true <- is_atom(value) do
      {:ok, to_string(value)}
    else
      _ -> :error
    end
  end

  @doc """
  Loads _Accounting Unit Currency from the given database form.

  ## Examples

      iex> load("USD")
      {:ok, %AccountingUnitCurrency{accounting_unit_currency: :USD}}

  """
  @spec load(String.t()) :: t | :error
  def load(data) do
    with true <- is_binary(data) do
      {:ok, %__MODULE__{accounting_unit_currency: String.to_atom(data)}}
    else
      _ -> :error
    end
  end
end
