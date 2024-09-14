defmodule ExAccounting.Elem.VatAmountOfAccountingUnitCurrency do
  @moduledoc """
  _VAT Amount of Accounting Unit Currency is the amount in the transaction currency.
  """

  use Ecto.Type

  @typedoc "_VAT Amount of Accounting Unit Currency"
  @type t :: %__MODULE__{vat_amount_of_accounting_unit_currency: Decimal.t()}

  defstruct vat_amount_of_accounting_unit_currency: nil

  @doc """
  Defines the type of _VAT Amount of Accounting Unit Currency in database as Decimal.t

  ## Examples

      iex> type()
      :decimal
  """
  @spec type() :: :decimal
  def type, do: :decimal

  @doc """
  Casts the given decimal type value to valid internal form of _VAT Amount of Accounting Unit Currency.

  ## Examples

      iex> cast(Decimal.new("100"))
      {:ok, %AmountInAccountingUnitCurrency{vat_amount_of_accounting_unit_currency: Decimal.new("100")}}

      iex> cast(ExAccounting.EmbeddedSchema.Money.new(100, "USD"))
      {:ok, %AmountInAccountingUnitCurrency{vat_amount_of_accounting_unit_currency: Decimal.new("100")}}
  """
  @spec cast(Decimal.t() | t | integer) :: {:ok, t} | :error
  def cast(%__MODULE__{} = amount) do
    with %__MODULE__{vat_amount_of_accounting_unit_currency: value} <- amount,
         %Decimal{} <- value do
      {:ok, amount}
    else
      _ -> :error
    end
  end

  def cast(%Decimal{} = amount) do
    with %Decimal{} <- amount do
      {:ok, %__MODULE__{vat_amount_of_accounting_unit_currency: amount}}
    else
      _ -> :error
    end
  end

  def cast(amount) when is_integer(amount) do
    with {:ok, value} <- Decimal.cast(amount) do
      {:ok, %__MODULE__{vat_amount_of_accounting_unit_currency: value}}
    else
      _ -> :error
    end
  end

  def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
    with {:ok, value} <- Decimal.cast(money.amount) do
      {:ok, %__MODULE__{vat_amount_of_accounting_unit_currency: value}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps _Amount in Accounting Unit Currency to decimal.

  ## Examples

      iex> dump(%AmountInAccountingUnitCurrency{vat_amount_of_accounting_unit_currency: Decimal.new("100")})
      {:ok, Decimal.new("100")}

  """
  @spec dump(t) :: Decimal.t() | :error
  def dump(%__MODULE__{} = amount) do
    with %__MODULE__{vat_amount_of_accounting_unit_currency: value} <- amount,
         %Decimal{} <- value do
      {:ok, value}
    else
      _ -> :error
    end
  end

  @doc """
  Loads _Amount in Accounting Unit Currency from the given database form.

  ## Examples

      iex> load(Decimal.new("100"))
      {:ok, %AmountInAccountingUnitCurrency{vat_amount_of_accounting_unit_currency: Decimal.new("100")}}

  """
  @spec load(Decimal.t()) :: t | :error
  def load(data) do
    with %Decimal{} <- data do
      {:ok, %__MODULE__{vat_amount_of_accounting_unit_currency: data}}
    else
      _ -> :error
    end
  end
end
