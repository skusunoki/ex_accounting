defmodule ExAccounting.DataItemDictionary.AccountingPeriod do
  @type t :: %__MODULE__{accounting_period: pos_integer}
  defstruct accounting_period: nil

  @doc """
    [create] is function for generating valid AccountingPeriod.

  ## Examples
    iex> AccountingPeriod.create(~C[12])
    %AccountingPeriod{accounting_period: 12}

    iex> AccountingPeriod.create(12)
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
