defmodule ExAccounting.Elem.SalesOrderItem do
  @moduledoc """
  SalesOrderItem is identifier of accounting document item
  """
  use Ecto.Type

  @typedoc "_Sales Order Item_"
  @type t :: %__MODULE__{sales_order_item: pos_integer}
  defstruct sales_order_item: nil

  @doc """
  Defines the type of the _Sales Order Item_ in database as integer.
  """
  @spec type() :: :integer
  def type, do: :integer

  @doc """
    Generates the valid _Sales Order Item_ from the given positive integer.

  ## Examples

      iex> create(101)
      %SalesOrderItem{sales_order_item: 101}
  """
  @spec create(pos_integer) :: t()
  def create(sales_order_item)
      when is_number(sales_order_item) and sales_order_item > 0 and
             sales_order_item <= 999_999 do
    %__MODULE__{sales_order_item: sales_order_item}
  end

  @doc """
  Casts the given postive integer to the _Sales Order Item_.

  ## Exampples

      iex> cast(101)
      {:ok, %SalesOrderItem{sales_order_item: 101}}

      iex> cast(0)
      {:error, 0}

      iex> cast(1_000_000)
      {:error, 1_000_000}
  """
  @spec cast(pos_integer) :: {:ok, t()} | {:error, pos_integer}
  @spec cast(t) :: {:ok, t} | :error
  def cast(%__MODULE__{sales_order_item: number} = sales_order_item) do
    with true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999 do
      {:ok, sales_order_item}
    else
      false -> {:error, sales_order_item}
    end
  end

  def cast(number) do
    with true <- is_number(number),
         true <- number > 0,
         true <- number <= 999_999 do
      {:ok, create(number)}
    else
      false -> {:error, number}
    end
  end

  @doc """
  Dumps the _Sales Order Item_ to the positive integer.

  ## Examples

      iex> dump(%SalesOrderItem{sales_order_item: 101})
      {:ok, 101}
  """
  @spec dump(t) :: {:ok, pos_integer} | :error
  def dump(%__MODULE__{sales_order_item: number} = _sales_order_item) do
    {:ok, number}
  end

  def dump(_) do
    :error
  end

  @doc """
  Loads the _Sales Order Item_ from the given database form data.
  """
  @spec load(integer) :: {:ok, t} | :error
  def load(data) do
    int_data = %{sales_order_item: data}
    {:ok, struct!(__MODULE__, int_data)}
  end
end
