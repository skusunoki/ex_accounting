defmodule ExAccounting.Elem.FunctionalArea do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          functional_area: charlist()
        }
  defstruct functional_area: nil

  def type, do: :string

  def cast(%__MODULE__{} = functional_area), do: {:ok, functional_area}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{functional_area: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{functional_area: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = functional_area), do: {:ok, to_string(functional_area.functional_area)}
  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{functional_area: validated}}
    else
      _ -> :error
    end
  end
end
