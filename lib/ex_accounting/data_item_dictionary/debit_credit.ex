defmodule ExAccounting.DataItemDictionary.DebitCredit do
  @moduledoc """
  DebitCredit indicates accounting document item is placed on whether Debitor or Creditor.
  """

  use Ecto.Type

  @typedoc "_Debit Credit Indicator_"
  @type t :: %__MODULE__{debit_credit: :debit} | %__MODULE__{debit_credit: :credit}
  defstruct debit_credit: nil

  @doc """
  Defines the type of the _Debit Credit_ in database as string.

  ## Exapmles

      iex> ExAccounting.DataItemDictionary.DebitCredit.type()
      :string
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Cast the given atom or string to the valid internal form of _Debit Credit_.

  ## Examples

      iex> ExAccounting.DataItemDictionary.DebitCredit.cast(:debit)
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :debit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.cast(:credit)
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :credit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.cast("D")
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :debit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.cast("C")
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :credit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.cast("X")
      :error

  """
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
  def cast(_), do: :error

  @doc """
  Dumps the _Debit Credit_ to the string.

  ## Examples

      iex> ExAccounting.DataItemDictionary.DebitCredit.dump(%ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :debit})
      {:ok, "D"}
      iex> ExAccounting.DataItemDictionary.DebitCredit.dump(%ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :credit})
      {:ok, "C"}
  """
  @spec dump(t) :: {:ok, String.t()} | :error
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

  @doc """
  Loads the _Debit Credit_ from the given database form.

  ## Examples

      iex> ExAccounting.DataItemDictionary.DebitCredit.load("D")
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :debit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.load("C")
      {:ok, %ExAccounting.DataItemDictionary.DebitCredit{debit_credit: :credit}}

      iex> ExAccounting.DataItemDictionary.DebitCredit.load("X")
      :error
  """
  @spec load(String.t()) :: {:ok, t} | :error
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
    Generates valid _Debit Credit_.
    Debit Credit can be either :debit or :credit.

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
