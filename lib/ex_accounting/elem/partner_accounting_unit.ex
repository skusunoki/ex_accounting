defmodule ExAccounting.Elem.PartnerAccountingUnit do
  @moduledoc """
  AccountingUnit is unit of organization to external reporting.
  """

  use Ecto.Type

  @typedoc "_Partner Accounting Unit_"
  @type t :: %__MODULE__{partner_accounting_unit: charlist}
  defstruct partner_accounting_unit: nil

  @doc """
  Defines the type of the _Partner Accounting Unit_ in database as string.

  ## Examples

      iex> type()
      :string
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given charlist or strings to the _Partner Accounting Unit_.

  ## Examples

      iex> cast(~C[1000])
      {:ok, %AccountingUnit{partner_accounting_unit: ~C[1000]}}

      iex> cast("1000")
      {:ok, %AccountingUnit{partner_accounting_unit: ~C[1000]}}

      iex> cast(1000)
      {:error, 1000}

      iex> cast(%AccountingUnit{partner_accounting_unit: ~c[1000]})
      {:ok, %AccountingUnit{partner_accounting_unit: ~c[1000]}}
  """
  @spec cast(t | String.t() | charlist) :: {:ok, t} | :error
  def cast(%__MODULE__{} = term) do
    with %__MODULE__{partner_accounting_unit: code} <- term,
         {:ok, _} <- ExAccounting.Utility.validate(code) do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) or is_binary(term) do
    with {:ok, _} <- ExAccounting.Utility.validate(ExAccounting.Utility.to_c(term)) do
      {:ok, create(term)}
    else
      _ -> :error
    end
  end

  def cast(term), do: {:error, term}

  @doc """
  Loads the _Partner Accounting Unit_ from the given database form data.

  ## Examples

      iex> load("1000")
      {:ok, %AccountingUnit{partner_accounting_unit: ~C[1000]}}
  """
  @spec load(String.t()) :: {:ok, t} | :error
  def load(partner_accounting_unit) do
    case ExAccounting.Utility.validate(ExAccounting.Utility.to_c(partner_accounting_unit)) do
      {:ok, validated} -> {:ok, %__MODULE__{partner_accounting_unit: validated}}
      {:error, _keyword} -> :error
    end
  end

  @doc """
  Dumps _Partner Accounting Unit_ into the database form.

  ## Examples

      iex> dump(%AccountingUnit{partner_accounting_unit: ~C[1000]})
      {:ok, "1000"}
  """
  @spec dump(t) :: {:ok, String.t()} | :error
  def dump(%__MODULE__{} = term) do
    with %__MODULE__{partner_accounting_unit: code} <- term,
         {:ok, _validated} <- ExAccounting.Utility.validate(code) do
      {:ok, to_string(code)}
    else
      _ -> :error
    end
  end

  @doc """
    Generates the valid _Partner Accounting Unit_ from the given charlist or strings.

  ## Examples

      iex> create(~C[1000])
      %AccountingUnit{ partner_accounting_unit: ~C[1000]}

  """

  @spec create(String.t()) :: t()
  def create(partner_accounting_unit) when is_binary(partner_accounting_unit) do
    partner_accounting_unit
    |> to_charlist()
    |> create()
  end

  @spec create(charlist) :: t()
  def create(partner_accounting_unit) when length(partner_accounting_unit) == 4 do
    case ExAccounting.Utility.validate(partner_accounting_unit) do
      {:ok, validated} -> %__MODULE__{partner_accounting_unit: validated}
      {:error, input} -> {:error, to_string(input) <> " is not valid"}
    end
  end
end
