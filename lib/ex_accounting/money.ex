defmodule ExAccounting.Money do
  @moduledoc """
  _Money_ is a representation of a monetary value in a specific currency.
  """
  require Decimal
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Money.Currency

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
  @spec abs(t) :: t() | :error
  def abs(%__MODULE__{} = money) do
    with %__MODULE__{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      %__MODULE__{amount: Decimal.abs(amount), currency: currency}
    else
      _ -> :error
    end
  end

  @doc """
  Adds two _Money_ values together.

  ## Examples

      iex> add(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      %Money{amount: Decimal.new("300"), currency: %Currency{currency: :usd}}
  """
  @spec add(m :: t, addend :: t) :: t()
  def add(m, addend) do
    with %__MODULE__{amount: amount, currency: currency} <- m,
         %__MODULE__{amount: addend_amount, currency: addend_currency} <- addend,
         %Decimal{} <- amount,
         %Decimal{} <- addend_amount,
         true <- currency == addend_currency do
      %__MODULE__{amount: Decimal.add(amount, addend_amount), currency: currency}
    else
      _ -> :error
    end
  end

  @doc """
  Compares two _Money_ values and returns true if the first is less than the second.

  ## Examples

      iex> is_less_than?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      true

      iex> is_less_than?(%Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_less_than?(m :: t, n :: t) :: boolean | :error
  def is_less_than?(m, n) do
    with %__MODULE__{amount: amount, currency: currency} <- m,
         %__MODULE__{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.lt?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @doc """
  Compares two _Money_ values and returns true if the first is greater than the second.

  ## Examples

      iex> is_greater_than?(%Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      true

      iex> is_greater_than?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_greater_than?(m :: t, n :: t) :: boolean | :error
  def is_greater_than?(m, n) do
    with %__MODULE__{amount: amount, currency: currency} <- m,
         %__MODULE__{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.gt?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @doc """
  Compares two _Money_ values and returns true if the first is equal to the second.

  ## Examples

      iex> is_equal?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}})
      true

      iex> is_equal?(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}})
      false
  """
  @spec is_equal?(m :: t, n :: t) :: boolean | :error
  def is_equal?(m, n) do
    with %__MODULE__{amount: amount, currency: currency} <- m,
         %__MODULE__{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.eq?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @doc """
  multiplies _Money_ by a given factor.

  ## Examples

      iex> multiply(%Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}, 2)
      %Money{amount: Decimal.new("200"), currency: %Currency{currency: :usd}}
  """
  @spec multiply(t, multiplier :: integer | float | Decimal.t()) :: t
  def multiply(%__MODULE__{} = money, multiplier) do
    with %__MODULE__{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount,
         true <- is_number(multiplier) or Decimal.is_decimal(multiplier) do
      %__MODULE__{amount: Decimal.mult(amount, multiplier), currency: currency}
    else
      _ -> :error
    end
  end

  @doc """
  Returns the negative of the _Money_.

  ## Examples

      iex> negate(%Money{amount: Decimal.new("-100"), currency: %Currency{currency: :usd}})
      %Money{amount: Decimal.new("100"), currency: %Currency{currency: :usd}}
  """
  @spec negate(money :: t) :: t | :error
  def negate(%__MODULE__{} = money) do
    with %__MODULE__{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      %__MODULE__{amount: Decimal.negate(amount), currency: currency}
    else
      _ -> :error
    end
  end

  @doc """
  Check if the _Money_ is negative.

  ## Examples

      iex> is_negative?(%Money{amount: Decimal.new("-100"), currency: %Currency{currency: :usd}})
      true
  """
  @spec is_negative?(t) :: boolean | :error
  def is_negative?(%__MODULE__{} = money) do
    with %__MODULE__{amount: amount, currency: _currency} <- money,
         %Decimal{} <- amount do
      Decimal.negative?(amount)
    else
      _ -> :error
    end
  end

  @doc """
  Generates a new _Money_ from the given amount and currency

  ## Examples

      iex> new(1000, :USD)
      %Money{amount: Decimal.new("1000"), currency: %Currency{currency: :USD}}

      iex> new(Decimal.new("1000"), :USD)
      %Money{amount: Decimal.new("1000"), currency: %Currency{currency: :USD}}
  """
  @spec new(Decimal.t() | integer, currency) :: t | :error
  def new(%Decimal{} = amount, currency) do
    with {:ok, currency} <- Currency.cast(currency),
         {:ok, return} <-
           %__MODULE__{}
           |> changeset(%{amount: amount, currency: currency})
           |> apply_action(:update) do
      return
    else
      _ -> :error
    end
  end

  def new(amount, currency) when is_number(amount) do
    with {:ok, currency} <- Currency.cast(currency),
         {:ok, return} <-
           %__MODULE__{}
           |> changeset(%{
             amount: Decimal.new(to_string(amount)),
             currency: currency
           })
           |> apply_action(:update) do
      return
    else
      _ -> :error
    end
  end

  def changeset(money, params) do
    cast(money, params, [:amount, :currency])
    |> validate_required([:amount, :currency])
    |> validate_inclusion(:currency, ExAccounting.Configuration.CurrencyConfiguration.read())
  end
end
