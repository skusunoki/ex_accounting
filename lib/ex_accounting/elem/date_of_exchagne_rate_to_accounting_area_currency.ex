defmodule ExAccounting.Elem.DateOfExchangeRateToAccountingAreaCurrency do
  @moduledoc """
  _Date of Exchange Rate to Accounting Area Currency_ is the date of accounting document posted.

  _Posting date_ must be consistent with accounting period within an accounting document.
  """
  use Ecto.Type

  @typedoc "__Date of Exchange Rate to Accounting Area Currency__"
  @type t :: %__MODULE__{date_of_exchange_rate_to_accounting_area_currency: Date.t()}
  defstruct date_of_exchange_rate_to_accounting_area_currency: nil

  def type, do: :date

  @doc """
  Casts the given date in Elixir Date type to the date in the valid internal form.

  ## Examples

      iex> cast(~D[2024-08-01])
      {:ok, %DateOfExchangeRateToAccountingAreaCurrency{date_of_exchange_rate_to_accounting_area_currency: ~D[2024-08-01]}}
  """
  @spec cast(Date.t()) :: {:ok, t()} | :error
  def cast(date) do
    with %Date{} <- date do
      {:ok, %__MODULE__{date_of_exchange_rate_to_accounting_area_currency: date}}
    else
      _ -> :error
    end
  end

  @doc """
  Dumps the given date in the valid internal type into the Elixir Date type.

  ## Examples

      iex> dump(%DateOfExchangeRateToAccountingAreaCurrency{date_of_exchange_rate_to_accounting_area_currency: ~D[2024-08-01]})
      {:ok, ~D[2024-08-01]}
  """
  @spec dump(t) :: {:ok, Date.t()} | :error
  def dump(date_of_exchange_rate_to_accounting_area_currency) do
    with %__MODULE__{date_of_exchange_rate_to_accounting_area_currency: date} <- date_of_exchange_rate_to_accounting_area_currency do
      {:ok, date}
    else
      _ -> :error
    end
  end

  @doc """
  Loads the _Date of Exchange Rate to Accounting Area Currency_ from the database form data.

  ## Examples

      iex> load(~D[2024-08-01])
      {:ok, %DateOfExchangeRateToAccountingAreaCurrency{date_of_exchange_rate_to_accounting_area_currency: ~D[2024-08-01]}}
  """
  @spec load(Date.t()) :: {:ok, t()} | {:error, Date.t()}
  def load(date) do
    with %Date{} <- date do
      {:ok, %__MODULE__{date_of_exchange_rate_to_accounting_area_currency: date}}
    else
      _ -> {:error, date}
    end
  end

  @doc """
    Generates valid _Date of Exchange Rate to Accounting Area Currency_ from the given date in Elixir Date type.

  ## Examples
      iex> create(~D[2024-08-03])
      %DateOfExchangeRateToAccountingAreaCurrency{date_of_exchange_rate_to_accounting_area_currency: ~D[2024-08-03]}
  """
  @spec create(Date.t()) :: t()
  def create(%Date{} = date_of_exchange_rate_to_accounting_area_currency) do
    %__MODULE__{date_of_exchange_rate_to_accounting_area_currency: date_of_exchange_rate_to_accounting_area_currency}
  end
end
