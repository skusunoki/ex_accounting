defmodule ExAccounting.Elem.OffsettingGeneralLedgerAccount do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          offsetting_general_ledger_account: charlist()
        }
  defstruct offsetting_general_ledger_account: nil

  def type, do: :string

  def cast(%__MODULE__{} = offsetting_general_ledger_account),
    do: {:ok, offsetting_general_ledger_account}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_general_ledger_account: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{offsetting_general_ledger_account: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = offsetting_general_ledger_account),
    do: {:ok, to_string(offsetting_general_ledger_account.offsetting_general_ledger_account)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{offsetting_general_ledger_account: validated}}
    else
      _ -> :error
    end
  end
end
