defmodule ExAccounting.DataItemDictionary.DebitCredit do
  @moduledoc """
  DebitCredit indicates accounting document item is placed on whether Debitor or Creditor.
  """

  use Ecto.Type

  @type t :: %__MODULE__{debit_credit: :debit} | %__MODULE__{debit_credit: :credit}
  defstruct debit_credit: nil

  def type, do: :string

  def cast(%__MODULE__{} = term) do
    with %__MODULE__{debit_credit: code} <- term,
         true <- code in [:debit, :credit] do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(:debit), do: {:ok, %__MODULE__{debit_credit: :debit}}
  def cast(:credit), do: {:ok, %__MODULE__{debit_credit: :credit}}
  def cast("D"), do: {:ok, %__MODULE__{debit_credit: :debit}}
  def cast("C"), do: {:ok, %__MODULE__{debit_credit: :credit}}

  def dump(%__MODULE__{} = debit_credit) do
    with %__MODULE__{debit_credit: code} <- debit_credit,
         true <- code in [:debit, :credit] do
      case code do
        :debit -> {:ok, "D"}
        :credit -> {:ok, "C"}
      end
    else
      _ -> :error
    end
  end

  def load(code) do
    with true <- code in ["D", "C"] do
      case code do
        "D" -> {:ok, %__MODULE__{debit_credit: :debit}}
        "C" -> {:ok, %__MODULE__{debit_credit: :credit}}
      end
    else
      _ -> :error
    end
  end

  @doc """
    Generates valid **DebitCredit**

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
