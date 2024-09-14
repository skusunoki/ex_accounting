defmodule ExAccounting.Elem.Vendor do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          vendor: charlist()
        }
  defstruct vendor: nil

  def type, do: :string

  def cast(%__MODULE__{} = vendor), do: {:ok, vendor}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{vendor: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{vendor: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = vendor), do: {:ok, to_string(vendor.vendor)}
  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{vendor: validated}}
    else
      _ -> :error
    end
  end
end
