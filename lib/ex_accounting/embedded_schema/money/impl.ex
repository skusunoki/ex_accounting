defmodule ExAccounting.EmbeddedSchema.Money.Impl do
  @moduledoc false
  require Decimal
  import Ecto.Changeset
  alias ExAccounting.Elem.Currency
  alias ExAccounting.EmbeddedSchema.Money

  @type currency :: Currency.t()

  @spec abs(Money.t()) :: Money.t() | :error
  def abs(%Money{} = money) do
    with %Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      %Money{amount: Decimal.abs(amount), currency: currency}
    else
      _ -> :error
    end
  end

  @spec add(m :: Money.t(), addend :: Money.t()) :: Money.t()
  def add(m, addend) do
    with %Money{amount: amount, currency: currency} <- m,
         %Money{amount: addend_amount, currency: addend_currency} <-
           addend,
         %Decimal{} <- amount,
         %Decimal{} <- addend_amount,
         true <- currency == addend_currency do
      m
      |> changeset(%{amount: Decimal.add(amount, addend_amount), currency: currency})
      |> apply_changes()
    else
      _ -> :error
    end
  end

  @spec is_less_than?(m :: Money.t(), n :: Money.t()) :: boolean | :error
  def is_less_than?(m, n) do
    with %Money{amount: amount, currency: currency} <- m,
         %Money{amount: n_amount, currency: n_currency} <- n,
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
    with %Money{amount: amount, currency: currency} <- m,
         %Money{amount: n_amount, currency: n_currency} <- n,
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
    with %Money{amount: amount, currency: currency} <- m,
         %Money{amount: n_amount, currency: n_currency} <- n,
         %Decimal{} <- amount,
         %Decimal{} <- n_amount,
         true <- currency == n_currency do
      Decimal.eq?(amount, n_amount)
    else
      _ -> :error
    end
  end

  @spec multiply(Money.t(), multiplier :: integer | float | Decimal.t()) :: Money.t()
  def multiply(%Money{} = money, multiplier) do
    with %Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount,
         true <- is_number(multiplier) or Decimal.is_decimal(multiplier) do
      money
      |> changeset(%{amount: Decimal.mult(amount, multiplier), currency: currency})
      |> apply_changes()
    else
      _ -> :error
    end
  end

  @spec negate(money :: Money.t()) :: Money.t() | :error
  def negate(%Money{} = money) do
    with %Money{amount: amount, currency: currency} <- money,
         %Decimal{} <- amount do
      money
      |> changeset(%{amount: Decimal.negate(amount), currency: currency})
      |> apply_changes()
    else
      _ -> :error
    end
  end

  @spec is_negative?(Money.t()) :: boolean | :error
  def is_negative?(%Money{} = money) do
    with %Money{amount: amount, currency: _currency} <- money,
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
           %Money{}
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
           %Money{}
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
    with {:ok, currency} <- Currency.cast(params.currency) do
      cast(money, params, [:amount, :currency])
      |> validate_required([:amount, :currency])
      |> validate_inclusion(
        :currency,
        ExAccounting.Configuration.Currency.read()
        |> Enum.map(fn x -> x.currency end),
        message: "should be in the list of the available currencies in the configuration"
      )
      |> put_change(
        :cent_factor,
        ExAccounting.Configuration.Currency.cent_factor(currency.currency)
      )
    end
  end

  @spec divide(Money.t(), by :: integer) :: Money.t()
  def divide(%Money{} = money, by) do
    with %Money{
           amount: amount,
           currency: currency,
           cent_factor: cent_factor
         } <-
           money,
         %Decimal{} <- amount,
         true <- is_number(by) or Decimal.is_decimal(by),
         param =
           %{
             amount:
               amount
               |> Decimal.mult(cent_factor)
               |> Decimal.div_int(by)
               |> Decimal.div(cent_factor),
             currency: currency
           } do
      money
      |> changeset(param)
      |> apply_changes()
    else
      _ -> :error
    end
  end

  def allocate(money, by) do
    with %Money{
           amount: amount,
           currency: currency,
           cent_factor: cent_factor
         } <-
           money,
         %Decimal{} <- amount,
         true <- is_integer(by),
         true <- by > 0,
         low_amount = divide(money, by),
         high_amount = low_amount |> add(new(Decimal.div(Decimal.new(1), cent_factor), currency)),
         remaindar = Decimal.mult(amount, cent_factor) |> Decimal.rem(by) do
      1..by
      |> Enum.map(fn x ->
        case Decimal.new(x) |> Decimal.compare(remaindar) do
          :lt -> high_amount
          :eq -> high_amount
          :gt -> low_amount
        end
      end)
    end
  end
end
