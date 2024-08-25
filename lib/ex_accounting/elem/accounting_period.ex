defmodule ExAccounting.Elem.AccountingPeriod do
  @moduledoc """
  _Accounting Period_ is a period of time for which the financial statements are prepared.
  """

  use Ecto.Type

  @typedoc "_Accounting Period_"
  @type t :: %__MODULE__{accounting_period: pos_integer}
  defstruct accounting_period: nil

  @doc """
  Defines the type of the _Accounting Period_ in database as integer.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given positive integer or charlist to the _Accounting Period_.
  _Accounting Period_ must be between 1 and 12.

  ## Examples

      iex> cast(12)
      {:ok, %AccountingPeriod{accounting_period: 12}}

      iex> cast(0)
      {:error, 0}

      iex> cast(13)
      {:error, 13}
  """
  @spec cast(t | pos_integer | charlist) :: {:ok, t()} | {:error, pos_integer}
  def cast(%__MODULE__{} = accounting_period) do
    with %__MODULE__{accounting_period: number} <- accounting_period,
         true <- is_number(number),
         true <- number > 0,
         true <- number <= 12 do
      {:ok, accounting_period}
    else
      _ -> {:error, accounting_period}
    end
  end

  def cast(accounting_period) when is_number(accounting_period) do
    with true <- accounting_period > 0,
         true <- accounting_period <= 12 do
      {:ok, %__MODULE__{accounting_period: accounting_period}}
    else
      _ -> {:error, accounting_period}
    end
  end

  def cast(accounting_period) when is_list(accounting_period) do
    with true <- length(accounting_period) == 2,
         true <-
           accounting_period == ~C[01] or
             accounting_period == ~C[02] or
             accounting_period == ~C[03] or
             accounting_period == ~C[04] or
             accounting_period == ~C[05] or
             accounting_period == ~C[06] or
             accounting_period == ~C[07] or
             accounting_period == ~C[08] or
             accounting_period == ~C[09] or
             accounting_period == ~C[10] or
             accounting_period == ~C[11] or
             accounting_period == ~C[12] do
      {:ok, create(accounting_period)}
    else
      _ -> {:error, accounting_period}
    end
  end

  @doc """
  Dumps the _Accounting Period_ to the integer.

  ## Examples

      iex> dump(%AccountingPeriod{accounting_period: 12})
      {:ok, 12}
  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(%__MODULE__{} = accounting_period) do
    with %__MODULE__{accounting_period: number} <- accounting_period do
      {:ok, number}
    end
  end

  @doc """
  Loads the _Accounting Period_ from the given database form data.

  ## Examples

      iex> load(12)
      {:ok, %AccountingPeriod{accounting_period: 12}}
  """
  @spec load(data :: integer) :: {:ok, t} | :error
  def load(data) when is_integer(data) do
    with stdata = %{accounting_period: data}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  @doc """
    Generates the valid _Accounting Period_ from the given integer value or charlist.

  ## Examples

      iex> create(12)
      %AccountingPeriod{accounting_period: 12}

      iex> create(~C[12])
      %AccountingPeriod{accounting_period: 12}

  """
  @spec create(pos_integer) :: t()
  @spec create(charlist) :: t()
  def create(accounting_period)
      when is_list(accounting_period) and
             (accounting_period == ~C[01] or
                accounting_period == ~C[02] or
                accounting_period == ~C[03] or
                accounting_period == ~C[04] or
                accounting_period == ~C[05] or
                accounting_period == ~C[06] or
                accounting_period == ~C[07] or
                accounting_period == ~C[08] or
                accounting_period == ~C[09] or
                accounting_period == ~C[10] or
                accounting_period == ~C[11] or
                accounting_period == ~C[12]) do
    %__MODULE__{
      accounting_period:
        cond do
          accounting_period == ~C[01] -> 1
          accounting_period == ~C[02] -> 2
          accounting_period == ~C[03] -> 3
          accounting_period == ~C[04] -> 4
          accounting_period == ~C[05] -> 5
          accounting_period == ~C[06] -> 6
          accounting_period == ~C[07] -> 7
          accounting_period == ~C[08] -> 8
          accounting_period == ~C[09] -> 9
          accounting_period == ~C[10] -> 10
          accounting_period == ~C[11] -> 11
          accounting_period == ~C[12] -> 12
        end
    }
  end

  def create(accounting_period)
      when is_number(accounting_period) and accounting_period >= 1 and accounting_period <= 12 do
    %__MODULE__{accounting_period: accounting_period}
  end
end
