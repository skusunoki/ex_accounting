defmodule ExAccounting.Elem.GeneralLedgerAccount do
  @moduledoc false

  use Ecto.Type

  @type t :: %__MODULE__{
          general_ledger_account: charlist()
        }
  defstruct general_ledger_account: nil

  def type, do: :string

  def cast(%__MODULE__{} = general_ledger_account), do: {:ok, general_ledger_account}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{general_ledger_account: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{general_ledger_account: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = general_ledger_account),
    do: {:ok, to_string(general_ledger_account.general_ledger_account)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{general_ledger_account: validated}}
    else
      _ -> :error
    end
  end
end
