defmodule ExAccounting.Money.Currency do
  use Ecto.Type
  defstruct currency: nil

  @typedoc "_Currency_"
  @type t :: %__MODULE__{currency: atom}

  @doc """
  Defines the database field type of _Currency_ as `:string`.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given atom or strings to the _Currency_.

  ## Example

      iex> cast(:USD)
      {:ok, %Currency{currency: :USD}}

      iex> cast("usd")
      :error

  """
  @spec cast(t) :: {:ok, t} | :error
  def cast(%__MODULE__{} = term) do
    with %__MODULE__{currency: code} <- term,
    true <- is_atom(code) do
      {:ok, term}
    else
      _ -> :error
    end
  end

  def cast(term) when is_atom(term) do
    with true <- is_atom(term),
    true <- String.length(to_string(term)) == 3,
    true <- to_string(term) == String.upcase(to_string(term)) do
      {:ok, %__MODULE__{currency: term}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_binary(term) do
    with true <- is_binary(term),
    true <- String.length(term) == 3,
    true <- term == String.upcase(term) do
      {:ok, %__MODULE__{currency: String.to_atom(term)}}
    else
      _ -> :error
    end
  end

  @doc """
  Loads the _Currency_ from the given binary data.

  ## Examples

      iex> load("USD")
      {:ok, %Currency{currency: :USD}}

  """
  @spec load(binary) :: {:ok, t} | :error
  def load(data) when is_binary(data) do
    with stdata = %{currency: String.to_atom(data)}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  @doc """
  Dumps _Currency_ into the database form.

  ## Examples

      iex> dump(%Currency{currency: :USD})
      {:ok, "USD"}

  """
  @spec dump(t) :: binary() | :error
  def dump(term) do
    with %__MODULE__{currency: code} <- term,
    true <- is_atom(code) do
      {:ok, Atom.to_string(code)}
    else
      _ -> :error
    end
  end

end
