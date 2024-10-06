defmodule ExAccounting.Elem.Currency do
  @moduledoc """
  _Currency_ represents a currency code.
  """
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
      {:error, "currency must be uppercase"}

  """
  @spec cast(t | atom | binary) :: {:ok, t} | :error
  def cast(%__MODULE__{} = term) do
    with %__MODULE__{currency: code} = term,
         {:M1, true} <- {:M1, is_atom(code)},
         {:M2, true} <- {:M2, to_string(code) == String.upcase(to_string(code))} do
      {:ok, term}
    else
      {:M1, _} -> {:error, "currency must be 3 letters atom"}
      {:M2, _} -> {:error, "currency must be uppercase"}
    end
  end

  def cast(term) when is_map(term) do
    with %{currency: code} = term,
         {:ok, casted} <- cast(%__MODULE__{currency: code}) do
      {:ok, casted}
    else
      error -> error
    end
  end

  def cast(term) when is_atom(term) do
    with {:M1, true} <- {:M1, String.length(to_string(term)) == 3},
         {:M2, true} <- {:M2, to_string(term) == String.upcase(to_string(term))} do
      {:ok, %__MODULE__{currency: term}}
    else
      {:M1, _} -> {:error, "currency must be 3 letters"}
      {:M2, _} -> {:error, "currency must be uppercase"}
    end
  end

  def cast(term) when is_binary(term) do
    with {:M1, true} <- {:M1, String.length(term) == 3},
         {:M2, true} <- {:M2, term == String.upcase(term)} do
      {:ok, %__MODULE__{currency: String.to_atom(term)}}
    else
      {:M1, _} -> {:error, "currency must be 3 letters"}
      {:M2, _} -> {:error, "currency must be uppercase"}
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
