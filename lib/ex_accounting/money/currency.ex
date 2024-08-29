defmodule ExAccounting.Money.Currency do
  use Ecto.Type
  defstruct currency: nil

  @typedoc "_Currency_"
  @type t :: %__MODULE__{currency: atom}

  @typedoc "_Configuration Reader_"
  @type config_reader :: (-> [atom()])

  @doc """
  Defines the database field type of _Currency_ as `:string`.
  """
  @spec type() :: :string
  def type, do: :string

  @doc """
  Casts the given atom or strings to the _Currency_.

  ## Example

      iex> cast(:usd, fn -> [:usd, :jpy, :eur] end)
      {:ok, %Currency{currency: :usd}}

      iex> cast("usd", fn -> [:usd, :jpy, :eur] end)
      {:ok, %Currency{currency: :usd}}

  """
  @spec cast(t) :: {:ok, t} | :error
  @spec cast(t, config_reader) :: {:ok, t} | :error
  @spec cast(String.t() | atom, config_reader) :: {:ok, t} | :error
  def cast(term) do
    cast(term, &ExAccounting.Configuration.CurrencyConfiguration.read/0)
  end

  def cast(%__MODULE__{} = term, config_reader) do
    with %__MODULE__{currency: code} <- term,
         {:ok, _} <- validate(code, config_reader) do
      {:ok, term}
    else
      {:error, _reason} -> {:error, term}
      _ -> :error
    end
  end

  def cast(term, config_reader) when is_atom(term) do
    with {:ok, _} <- validate(term, config_reader) do
      {:ok, create(term, config_reader)}
    else
      _ -> {:error, term}
    end
  end

  def cast(term, config_reader) when is_binary(term) do
    with {:ok, _} <- validate(term, config_reader) do
      {:ok, create(term, config_reader)}
    else
      _ -> {:error, term}
    end
  end

  @doc """
  Validates the given currency code.

  ## Examples

      iex> validate(:usd, fn -> [:usd, :jpy, :eur] end)
      {:ok, :usd}

      iex> validate("usd", fn -> [:usd, :jpy, :eur] end)
      {:ok, :usd}

      iex> validate(:us, fn -> [:usd, :jpy, :eur] end)
      {:error, :us}

      iex> validate("us", fn -> [:usd, :jpy, :eur] end)
      {:error, "us"}

  """
  @spec validate(atom, config_reader) :: {:ok, atom} | {:error, atom}
  @spec validate(String.t(), config_reader) :: {:ok, String.t()} | {:error, String.t()}
  def validate(code, config_reader) when is_atom(code) do
    with true <- code in config_reader.() do
      {:ok, code}
    else
      _ -> {:error, code}
    end
  end

  def validate(code, config_reader) when is_binary(code) do
    with true <- String.to_atom(code) in config_reader.() do
      {:ok, code}
    else
      _ -> {:error, code}
    end
  end

  @doc """
  Loads the _Currency_ from the given binary data.

  ## Examples

      iex> load("usd")
      {:ok, %Currency{currency: :usd}}

  """
  @spec load(binary) :: {:ok, t} | :error
  def load(data) when is_binary(data) do
    with stdata = %{currency: String.to_atom(data)}, do: {:ok, struct!(__MODULE__, stdata)}
  end

  @doc """
  Dumps _Currency_ into the database form.

  ## Examples

      iex> dump(%Currency{currency: :usd}, fn -> [:usd, :jpy, :eur] end)
      {:ok, "usd"}

  """
  @spec dump(t) :: binary() | :error
  @spec dump(t, config_reader) :: binary() | :error
  def dump(term) do
    dump(term, &ExAccounting.Configuration.CurrencyConfiguration.read/0)
  end

  def dump(term, config_reader) do
    with %__MODULE__{currency: code} <- term,
         true <- is_atom(code),
         {:ok, _validated} <- validate(code, config_reader) do
      {:ok, Atom.to_string(code)}
    else
      _ -> :error
    end
  end

  @doc """
  Generates a new _Currency_ from the given currency code.


  ## Examples

      iex> new(:usd, fn -> [:usd, :jpy, :eur] end)
      %Currency{currency: :usd}

      iex> new("usd", fn -> [:usd, :jpy, :eur] end)
      %Currency{currency: :usd}

  """
  @spec create(atom, config_reader) :: t | :error
  @spec create(String.t(), config_reader) :: t | :error
  def create(code, config_reader) when is_atom(code) do
    with {:ok, _} <- validate(code, config_reader) do
      %__MODULE__{currency: code}
    else
      _ -> :error
    end
  end

  def create(code, config_reader) when is_binary(code) do
    with {:ok, _} <- validate(String.to_atom(code), config_reader) do
      %__MODULE__{currency: String.to_atom(code)}
    else
      _ -> :error
    end
  end
end
