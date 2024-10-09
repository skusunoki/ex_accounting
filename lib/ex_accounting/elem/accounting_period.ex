defmodule ExAccounting.Elem.AccountingPeriod do
  @moduledoc """
  _Accounting Period_ is a period of time for which the financial statements are prepared.

  ## Examples

    Accounting Period must be between 0 and 12.

      iex> cast(12)
      {:ok, %ExAccounting.Elem.AccountingPeriod{accounting_period: 12}}

    0 is used for the opening balance.

      iex> cast(0)
      {:ok, %ExAccounting.Elem.AccountingPeriod{accounting_period: 0}}

    Out of range values are not allowed.

      iex> cast(13)
      {:error, 13}

    Skips the period for opening balance when getting the next or previous period.

      iex> next(%ExAccounting.Elem.AccountingPeriod{accounting_period: 12})
      %ExAccounting.Elem.AccountingPeriod{accounting_period: 1}

      iex> previous(%ExAccounting.Elem.AccountingPeriod{accounting_period: 1})
      %ExAccounting.Elem.AccountingPeriod{accounting_period: 12}

  """

  use ExAccounting.Type
  period(:accounting_period, max: 12, description: "Accounting Period")

  def next(%__MODULE__{accounting_period: period}) when period == 12 do
    %__MODULE__{accounting_period: 1}
  end

  def next(%__MODULE__{accounting_period: period}) when period == 0 do
    %__MODULE__{accounting_period: 1}
  end

  def next(%__MODULE__{accounting_period: period}) when period > 0 and period < 12 do
    %__MODULE__{accounting_period: period + 1}
  end

  def previous(%__MODULE__{accounting_period: period}) when period == 1 do
    %__MODULE__{accounting_period: 12}
  end

  def previous(%__MODULE__{accounting_period: period}) when period == 0 do
    %__MODULE__{accounting_period: 12}
  end

  def previous(%__MODULE__{accounting_period: period}) when period > 1 and period < 12 do
    %__MODULE__{accounting_period: period - 1}
  end
end
