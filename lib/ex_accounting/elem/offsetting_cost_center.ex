defmodule ExAccounting.Elem.OffsettingCostCenter do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          offsetting_cost_center: charlist()
        }
  defstruct offsetting_cost_center: nil

  def type, do: :string

  def cast(%__MODULE__{} = offsetting_cost_center), do: {:ok, offsetting_cost_center}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_cost_center: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_cost_center: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = offsetting_cost_center),
    do: {:ok, to_string(offsetting_cost_center.offsetting_cost_center)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{offsetting_cost_center: validated}}
    else
      _ -> :error
    end
  end
end
