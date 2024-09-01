defmodule ExAccounting.Money.Impl do
  require Decimal

  import Ecto.Changeset
  alias ExAccounting.Money.Currency
  alias ExAccounting.Money

  @type currency :: ExAccounting.Money.currency()

  @spec abs(Money.t()) :: Money.t() | :error
  def abs(%ExAccounting.Money{} = money) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      %ExAccounting.Money{amount: Decimal.abs(amount), currency: currency}
    else
      _ -> :error
    end
  end

  @spec add(m :: Money.t(), addend :: Money.t()) :: Money.t()
  def add(m, addend) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- m,
         %ExAccounting.Money{amount: addend_amount, currency: addend_currency} <- addend,
         %Decimal{} <- amount,
         %Decimal{} <- addend_amount,
         true <- currency == addend_currency do
      %ExAccounting.Money{amount: Decimal.add(amount, addend_amount), currency: currency}
    else
      _ -> :error
    end
  end

  @spec is_less_than?(m :: Money.t(), n :: Money.t()) :: boolean | :error
  def is_less_than?(m, n) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- m,
         %ExAccounting.Money{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.lt?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @spec is_greater_than?(m :: Money.t(), n :: Money.t()) :: boolean | :error
  def is_greater_than?(m, n) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- m,
         %ExAccounting.Money{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.gt?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @spec is_equal?(m :: Money.t(), n :: Money.t()) :: boolean | :error
  def is_equal?(m, n) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- m,
         %ExAccounting.Money{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.eq?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @spec multiply(Money.t(), multiplier :: integer | float | Decimal.t()) :: Money.t()
  def multiply(%ExAccounting.Money{} = money, multiplier) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount,
         true <- is_number(multiplier) or Decimal.is_decimal(multiplier) do
      %ExAccounting.Money{amount: Decimal.mult(amount, multiplier), currency: currency}
    else
      _ -> :error
    end
  end

  @spec negate(money :: Money.t()) :: Money.t() | :error
  def negate(%ExAccounting.Money{} = money) do
    with %ExAccounting.Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      %ExAccounting.Money{amount: Decimal.negate(amount), currency: currency}
    else
      _ -> :error
    end
  end

  @spec is_negative?(Money.t()) :: boolean | :error
  def is_negative?(%ExAccounting.Money{} = money) do
    with %ExAccounting.Money{amount: amount, currency: _currency} <- money,
         %Decimal{} <- amount do
      Decimal.negative?(amount)
    else
      _ -> :error
    end
  end

  @spec new(Decimal.t() | integer, currency) :: Money.t() | :error
  def new(%Decimal{} = amount, currency) do
    with {:ok, currency} <- Currency.cast(currency),
         {:ok, return} <-
           %ExAccounting.Money{}
           |> changeset(%{amount: amount, currency: currency})
           |> apply_action(:update) do
      return
    else
      {:error, reson} -> {:error, reson}
    end
  end

  def new(amount, currency) when is_number(amount) do
    with {:ok, currency} <- Currency.cast(currency),
         {:ok, return} <-
           %ExAccounting.Money{}
           |> changeset(%{
             amount: Decimal.new(to_string(amount)),
             currency: currency
           })
           |> apply_action(:update) do
      return
    else
      {:error, reson} -> {:error, reson}
    end
  end

  @doc """
  Makes a changeset for the _Money_.

  ## Examples

      iex> %Money{} |> changeset(%{amount: 1000, currency: :USD}) |> Ecto.Changeset.apply_changes()
      %Money{amount: Decimal.new("1000"), currency: %Currency{currency: :USD}}
  """

  def changeset(money, params) do
    cast(money, params, [:amount, :currency])
    |> validate_required([:amount, :currency])
    |> validate_inclusion(:currency, ExAccounting.Configuration.CurrencyConfiguration.read(),
      message: "should be in the list of the available currencies in the configuration"
    )
  end
end
