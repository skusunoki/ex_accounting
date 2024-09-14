defmodule ExAccounting.Elem.FixedAssetTransactionType do
  use Ecto.Type

  @type t :: %__MODULE__{
          fixed_asset_transaction_type: charlist()
        }

  defstruct fixed_asset_transaction_type: nil

  def type, do: :string

  def cast(%__MODULE__{} = fixed_asset_transaction_type), do: {:ok, fixed_asset_transaction_type}
  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
          true <- length(term) <= 3
    do
      {:ok, %__MODULE__{fixed_asset_transaction_type: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
          true <- length(validated) <= 3
    do
      {:ok, %__MODULE__{fixed_asset_transaction_type: validated}}
    else
      _ -> :error
    end
  end

  def dump(%__MODULE__{} = fixed_asset_transaction_type), do: {:ok, to_string(fixed_asset_transaction_type.fixed_asset_transaction_type)}
  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
          true <- length(validated) <= 3
    do
      {:ok, %__MODULE__{fixed_asset_transaction_type: validated}}
    else
      _ -> :error
    end
  end

end
