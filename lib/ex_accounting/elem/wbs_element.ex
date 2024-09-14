defmodule ExAccounting.Elem.WbsElement do
  use Ecto.Type

  @type t :: %__MODULE__{
          wbs_element: charlist()
        }

  defstruct wbs_element: nil

  def type, do: :string

  def cast(%__MODULE__{} = wbs_element), do: {:ok, wbs_element}

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 256 do
      {:ok, %__MODULE__{wbs_element: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 256 do
      {:ok, %__MODULE__{wbs_element: validated}}
    else
      _ -> :error
    end
  end

  def dump(%__MODULE__{} = wbs_element),
    do: {:ok, to_string(wbs_element.wbs_element)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 256 do
      {:ok, %__MODULE__{wbs_element: validated}}
    else
      _ -> :error
    end
  end
end
