defmodule ExAccounting.Elem.SalesOrder do
  @moduledoc """
  _Sales Order_ is sequential unique number to identify the accounting document.
  """
  use Ecto.Type

  @typedoc "_Sales Order_"
  @type t :: %__MODULE__{sales_order: pos_integer}
  defstruct sales_order: nil

  @doc """
  Defines the type of the _Sales Order_ in database as integer.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
  Casts the given positive integer to the _Sales Order_.

  ## Examples

        iex> cast(1010)
        {:ok, %SalesOrder{sales_order: 1010}}

        iex> cast(0)
        {:error, 0}

        iex> cast(1_000_000_000_000)
        {:error, 1_000_000_000_000}
  """
  @spec cast(t | pos_integer) :: {:ok, t()} | {:error, pos_integer}
  def cast(%__MODULE__{} = sales_order) do
    with %__MODULE__{sales_order: number} <- sales_order,
         true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999_999_999 do
      {:ok, sales_order}
    else
      _ -> {:error, sales_order}
    end
  end

  def cast(sales_order) when is_number(sales_order) do
    with true <- sales_order > 0,
         true <- sales_order <= 999_999_999_999 do
      {:ok, %__MODULE__{sales_order: sales_order}}
    else
      _ -> {:error, sales_order}
    end
  end

  @doc """
  Dumps the _Sales Order_ to the integer.

  ## Examples

      iex> dump(%SalesOrder{sales_order: 1010})
      {:ok, 1010}
  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(%__MODULE__{} = sales_order) do
    with %__MODULE__{sales_order: number} <- sales_order do
      {:ok, number}
    else
      _ -> :error
    end
  end

  @doc """
  Loads the _Sales Order_ from the given database form.

  ## Examples

      iex> load(1010)
      {:ok, %SalesOrder{sales_order: 1010}}
  """
  @spec load(integer) :: {:ok, t} | :error
  def load(number) when is_number(number) do
    with true <- number > 0,
         true <- number <= 999_999_999_999 do
      {:ok, %__MODULE__{sales_order: number}}
    else
      _ -> :error
    end
  end

  @doc """
    Generate valid _Sales Order_

  ## Examples

      iex> create(1010)
      %SalesOrder{sales_order: 1010}
  """
  @spec create(pos_integer) :: t()
  def create(sales_order)
      when is_integer(sales_order) and sales_order > 0 and
             sales_order <= 999_999_999_999 do
    %__MODULE__{sales_order: sales_order}
  end
end
