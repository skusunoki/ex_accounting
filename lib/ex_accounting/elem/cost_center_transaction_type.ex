defmodule ExAccounting.Elem.CostCenterTransactionType do
  use Ecto.Type

  @type t :: %__MODULE__{
          cost_center_transaction_type: charlist()
        }

  defstruct cost_center_transaction_type: nil

  def type, do: :string

  def cast(%__MODULE__{} = cost_center_transaction_type), do: {:ok, cost_center_transaction_type}

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 3 do
      {:ok, %__MODULE__{cost_center_transaction_type: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 3 do
      {:ok, %__MODULE__{cost_center_transaction_type: validated}}
    else
      _ -> :error
    end
  end

  def dump(%__MODULE__{} = cost_center_transaction_type),
    do: {:ok, to_string(cost_center_transaction_type.cost_center_transaction_type)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 3 do
      {:ok, %__MODULE__{cost_center_transaction_type: validated}}
    else
      _ -> :error
    end
  end
end
