defmodule ExAccounting.Money do
  @moduledoc """
  _Money_ is a representation of a monetary value in a specific currency.
  """
  use Ecto.Schema
  alias ExAccounting.Money.Impl

  @typedoc "_Money_"
  @type t :: %__MODULE__{
          amount: Decimal.t(),
          currency: ExAccounting.Money.Currency.t()
        }

  @typedoc "_Currency_"
  @type currency :: ExAccounting.Money.Currency.t()
  #  defstruct amount: nil, currency: nil

  @primary_key false
  embedded_schema do
    field(:amount, :decimal)
    field(:currency, ExAccounting.Money.Currency)
  end

  @doc """
  Converts to _Money_ with the arithmetical absolute of the amount

  ## Examples

      iex> Money.abs(%Money{amount: Decimal.new("-100"), currency: %Currency{currency: :usd}})
      %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}
  """
  @spec abs(t) :: t | :error
  defdelegate abs(money), to: Impl

  @doc """
  Adds two _Money_ values together.

  ## Examples

      iex> add(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      %Money{amount: Decimal.new("300"), currency: %Currency{currency: :usd}}
  """
  @spec add(t, t) :: t | :error
  defdelegate add(money, addend), to: Impl

  @doc """
  Compares two _Money_ values and returns true if the first is less than the second.

  ## Examples

      iex> is_less_than?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      true

      iex> is_less_than?(%Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_less_than?(t, t) :: :error | false | true
  defdelegate is_less_than?(money, addend), to: Impl

  @doc """
  Compares two _Money_ values and returns true if the first is greater than the second.

  ## Examples

      iex> is_greater_than?(%Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      true

      iex> is_greater_than?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_greater_than?(t, t) :: :error | false | true
  defdelegate is_greater_than?(money, addend), to: Impl

  @doc """
  Compares two _Money_ values and returns true if the first is equal to the second.

  ## Examples

      iex> is_equal?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      true

      iex> is_equal?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_equal?(t, t) :: :error | false | true
  defdelegate is_equal?(money, addend), to: Impl

  @doc """
  multiplies _Money_ by a given factor.

  ## Examples

      iex> multiply(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, 2)
      %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}
  """
  @spec multiply(t, factor :: number) :: :error | t
  defdelegate multiply(money, factor), to: Impl

  @doc """
  Returns the negative of the _Money_.

  ## Examples

      iex> negate(%Money{amount: Decimal.new("-100"), currency: %Currency{currency: :usd}})
      %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}
  """
  @spec negate(t) :: :error | t
  defdelegate negate(money), to: Impl

  @doc """
  Check if the _Money_ is negative.

  ## Examples

      iex> is_negative?(%Money{amount: Decimal.new("-100"), currency: %Currency{currency: :usd}})
      true
  """
  @spec is_negative?(t) :: :error | t
  defdelegate is_negative?(money), to: Impl

  @doc """
  Generates a new _Money_ from the given amount and currency

  ## Examples

      iex> new(1000, :USD)
      %Money{amount: Decimal.new("1000"), currency: %Currency{currency: :USD}}

      iex> new(Decimal.new("1000"), :USD)
      %Money{amount: Decimal.new("1000"), currency: %Currency{currency: :USD}}
  """
  @spec new(integer | Decimal.t(), currency) :: t
  defdelegate new(amount, currency), to: Impl

  @spec new(%{amount: integer | Decimal.t(), currency: currency}) :: t
  def new(%{amount: amount, currency: currency}) do
    new(amount, currency)
  end
end
