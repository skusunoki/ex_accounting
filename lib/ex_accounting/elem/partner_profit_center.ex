defmodule ExAccounting.Elem.PartnerProfitCenter do
  @moduledoc """
  _Partner Profit Center_ is identifier of a partner profit center.
  """

  use Ecto.Type

  @type t :: %__MODULE__{
          partner_profit_center: charlist()
        }
  defstruct partner_profit_center: nil

  def type, do: :string

  def cast(%__MODULE__{} = partner_profit_center), do: {:ok, partner_profit_center}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{partner_profit_center: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{partner_profit_center: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = partner_profit_center),
    do: {:ok, to_string(partner_profit_center.partner_profit_center)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{partner_profit_center: validated}}
    else
      _ -> :error
    end
  end
end
