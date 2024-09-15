defmodule ExAccounting.Elem.ExchangeRateTypeToAccountingUnitCurrency do
  use Ecto.Type

  @type t :: %__MODULE__{
          exchange_rate_type_to_accounting_unit_currency: charlist()
        }

  defstruct exchange_rate_type_to_accounting_unit_currency: nil

  def type, do: :string

  def cast(%__MODULE__{} = exchange_rate_type_to_accounting_unit_currency),
    do: {:ok, exchange_rate_type_to_accounting_unit_currency}

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 3 do
      {:ok, %__MODULE__{exchange_rate_type_to_accounting_unit_currency: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 3 do
      {:ok, %__MODULE__{exchange_rate_type_to_accounting_unit_currency: validated}}
    else
      _ -> :error
    end
  end

  def dump(%__MODULE__{} = exchange_rate_type_to_accounting_unit_currency),
    do: {:ok, to_string(exchange_rate_type_to_accounting_unit_currency.exchange_rate_type_to_accounting_unit_currency)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 3 do
      {:ok, %__MODULE__{exchange_rate_type_to_accounting_unit_currency: validated}}
    else
      _ -> :error
    end
  end
end
