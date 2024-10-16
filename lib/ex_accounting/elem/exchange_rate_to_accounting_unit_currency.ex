defmodule ExAccounting.Elem.ExchangeRateToAccountingUnitCurrency do
  @moduledoc """
  _Exchange Rate to Accounting Unit Currency_ is the amount in the transaction currency.
  """

  use Ecto.Type

  @typedoc "_Exchange Rate to Accounting Unit Currency_"
  @type t :: %__MODULE__{excahnge_rate_to_accounting_unit_currency: Decimal.t()}

  defstruct excahnge_rate_to_accounting_unit_currency: nil

  @doc """
  Defines the type of _Exchange Rate to Accounting Unit Currency_ in database as Decimal.t

  ## Examples

      iex> type()
      :decimal
  """
  @spec type() :: :decimal
  def type, do: :decimal

  @doc """
  Casts the given decimal type value to valid internal form of _Exchange Rate to Accounting Unit Currency_.

  ## Examples

      iex> cast(Decimal.new("100"))
      {:ok, %ExchangeRateToAccountingUnitCurrency{excahnge_rate_to_accounting_unit_currency: Decimal.new("100")}}

      iex> cast(ExAccounting.EmbeddedSchema.Money.new(100, "USD"))
      {:ok, %ExchangeRateToAccountingUnitCurrency{excahnge_rate_to_accounting_unit_currency: Decimal.new("100")}}
  """
  @spec cast(Decimal.t() | t | integer) :: {:ok, t} | :error
  def cast(%__MODULE__{} = amount) do
    with %__MODULE__{excahnge_rate_to_accounting_unit_currency: value} <- amount,
         %Decimal{} <- value do
      {:ok, amount}
    else
      _ -> :error
    end
  end

  def cast(%Decimal{} = amount) do
    with %Decimal{} <- amount do
      {:ok, %__MODULE__{excahnge_rate_to_accounting_unit_currency: amount}}
    else
      _ -> :error
    end
  end

  def cast(amount) when is_integer(amount) do
    with {:ok, value} <- Decimal.cast(amount) do
      {:ok, %__MODULE__{excahnge_rate_to_accounting_unit_currency: value}}
    else
      _ -> :error
    end
  end

  def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
    with {:ok, value} <- Decimal.cast(money.amount) do
      {:ok, %__MODULE__{excahnge_rate_to_accounting_unit_currency: value}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps _Exchange Rate to Accounting Unit Currency to decimal.

  ## Examples

      iex> dump(%ExchangeRateToAccountingUnitCurrency{excahnge_rate_to_accounting_unit_currency: Decimal.new("100")})
      {:ok, Decimal.new("100")}

  """
  @spec dump(t) :: Decimal.t() | :error
  def dump(%__MODULE__{} = amount) do
    with %__MODULE__{excahnge_rate_to_accounting_unit_currency: value} <- amount,
         %Decimal{} <- value do
      {:ok, value}
    else
      _ -> :error
    end
  end

  @doc """
  Loads _Exchange Rate to Accounting Unit Currency_ from the given database form.

  ## Examples

      iex> load(Decimal.new("100"))
      {:ok, %ExchangeRateToAccountingUnitCurrency{excahnge_rate_to_accounting_unit_currency: Decimal.new("100")}}

  """
  @spec load(Decimal.t()) :: t | :error
  def load(data) do
    with %Decimal{} <- data do
      {:ok, %__MODULE__{excahnge_rate_to_accounting_unit_currency: data}}
    else
      _ -> :error
    end
  end
end
