defmodule ExAccounting.Elem.FixedAsset do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          fixed_asset: charlist()
        }
  defstruct fixed_asset: nil

  def type, do: :string

  def cast(%__MODULE__{} = fixed_asset), do: {:ok, fixed_asset}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{fixed_asset: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{fixed_asset: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = fixed_asset), do: {:ok, to_string(fixed_asset.fixed_asset)}
  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{fixed_asset: validated}}
    else
      _ -> :error
    end
  end
end
