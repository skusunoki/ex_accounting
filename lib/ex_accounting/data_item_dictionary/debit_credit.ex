defmodule ExAccounting.DataItemDictionary.DebitCredit do
  @moduledoc """
  DebitCredit indicates accounting document item is placed on whether Debitor or Creditor.
  """

  @type t :: %__MODULE__{debit_credit: atom}
  defstruct debit_credit: nil

  @doc """
    [create] is function for generating valid DebitCredit

  ## Examples
    iex> DebitCredit.create(:debit)
    %DebitCredit{debit_credit: :debit}

    iex> DebitCredit.create(:credit)
    %DebitCredit{debit_credit: :credit}

  """
  @spec create(atom) :: t()
  def create(debit_credit)
      when is_atom(debit_credit) and (debit_credit == :debit or debit_credit == :credit) do
    %__MODULE__{debit_credit: debit_credit}
  end
end
