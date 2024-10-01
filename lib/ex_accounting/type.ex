defmodule ExAccounting.Type do
  defmacro __using__(_opts) do
    quote do
      import ExAccounting.Type
    end
  end

  @doc """
  Defines a Ecto custom type for alphanumeic code with **fixed** length.
  `field` must be a atom. It represents the key of the struct.
  The database field type is `:string`.

  `field` can be used in multiple places in the type definition.

  ## Options

   - `length:` Length of the code. It must be a positive integer.
   - `description:` Description of the entity. It must be a string. Used for documentation.

  ## Example

      iex> defmodule DocumentType do
      ...>   code(:document_type, length: 2, description: "Document Type")
      ...> end

      iex> defmodule ReversedDocumentType do
      ...>   code(:document_type, length: 2, description: "Document Type of Reversed Document")
      ...> end

  """
  @spec code(atom, length: pos_integer) :: any()
  defmacro code(field, opts) do
    quote do
      use Ecto.Type

      @typedoc unquote(opts[:description])
      @type t :: %__MODULE__{unquote(field) => charlist}

      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:string`.
      """
      @spec type() :: :string
      def type, do: :string

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(t) :: {:ok, t} | :error
      @spec cast(String.t() | charlist) :: {:ok, t} | :error | {:error, any}
      def cast(%__MODULE__{} = term) do
        with %__MODULE__{unquote(field) => code} <- term,
             {:ok, validated} <- validate(code) do
          {:ok, term}
        else
          {:error, _reason} -> {:error, term}
          _ -> :error
        end
      end

      def cast(term) do
        with true <- is_list(term) or is_binary(term),
             {:ok, _} <- validate(ExAccounting.Utility.to_c(term)) do
          cast(%__MODULE__{unquote(field) => ExAccounting.Utility.to_c(term)})
        else
          _ -> {:error, term}
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from corresponding database field with `:string` type.
      """
      @spec load(binary) :: {:ok, t}
      def load(data) when is_binary(data) do
        with stdata = %{unquote(field) => to_charlist(data)},
          do: {:ok, struct!(__MODULE__, stdata)}
      end

      @doc """
      Dumps #{unquote(opts[:description])} to `:string` type.
      """
      @spec dump(t) :: {:ok, binary} | :error
      def dump(code) do
        with %__MODULE__{unquote(field) => code} <- code,
             {:ok, _validated} <- validate(code),
             dump = code |> to_string() do
          {:ok, dump}
        else
          _ -> :error
        end
      end

      @doc """
      Creates a new #{unquote(opts[:description])} with the given term.
      """
      @spec create(charlist | binary) :: t | {:error, String.t()}
      def create(term) do
        with {:ok, code} <- cast(term) do
          code
        end
      end

      @doc """
      Returns the result of comparison betweek two #{unquote(opts[:description])}s.
      """
      @spec equal?(t, t) :: boolean()
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
             true <- Map.has_key?(term2, unquote(field)),
             l = Map.get(term1, unquote(field)),
             r = Map.get(term2, unquote(field)),
             true <- l == r do
          true
        else
          _ -> false
        end
      end

      @doc """
      Defines the form of the #{unquote(opts[:description])} in the embedded schema.
      """
      @spec embed_as(atom()) :: :self
      def embed_as(_), do: :self

      defp validate(code) do
        with true <- code != nil,
             true <- is_list(code),
             true <- ExAccounting.Utility.len(code) == unquote(opts[:length]),
             {:ok, _validated} <- ExAccounting.Utility.validate(code) do
          {:ok, code}
        else
          false -> {:error, code}
          {:error, reason} -> {:error, reason}
        end
      end

    end
  end

  @doc """
  Defines a custom type for alphanumeic code with maximum length. `field` must be a atom that represents the key of the struct.

  ## Options

  `:length` - Maximum length of the code. It must be a positive integer.
  `:description` - Description of the entity.

  ## Examples

      iex> defmodule Employee do
      ...>   entity(:employee, length: 10, description: "Employee")
      ...> end

      iex> Employee.cast("10245023")
      {:ok, %Employee{employee: "10245023"}}
  """
  defmacro entity(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{
              unquote(field) => charlist()
            }
      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:string`.
      """
      def type, do: :string

      @doc """
      Casts term to valid form of #{unquote(opts[:description])}.
      Length of the given term should be less than or equal to #{unquote(opts[:length])}.
      Letters of the given term should be alphanumeric: A-Z or 0 - 9.
      """
      @spec cast(t) :: {:ok, t} | :error
      def cast(%__MODULE__{} = term), do: {:ok, term}

      def cast(term) when is_binary(term) do
        with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
             true <- String.length(term) <= unquote(opts[:length]) do
          {:ok, %__MODULE__{unquote(field) => validated}}
        else
          _ -> :error
        end
      end

      def cast(term) when is_list(term) do
        with {:ok, validated} <- ExAccounting.Utility.validate(term),
             true <- length(term) <= unquote(opts[:length]) do
          {:ok, %__MODULE__{unquote(field) => validated}}
        else
          _ -> :error
        end
      end

      def cast(_), do: :error

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:string`.
      """
      def dump(%__MODULE__{} = entity), do: {:ok, to_string(entity.unquote(field))}
      def dump(_), do: :error

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:string`.
      """
      def load(term) do
        with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
             true <- length(validated) <= unquote(opts[:length]) do
          {:ok, %__MODULE__{unquote(field) => validated}}
        else
          _ -> :error
        end
      end

      @doc """
      Returns the result of comparison betweek two #{unquote(opts[:description])}s.
      The #{unquote(opts[:description])}s are compared by key `#{unquote(field)}` and its value not by the struct itself.
      """
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
        true <- Map.has_key?(term2, unquote(field)),
        l = Map.get(term1, unquote(field)),
        r = Map.get(term2, unquote(field)),
        true <- l == r do
     true
   else
     _ -> false
   end
      end
    end
  end

  @doc """
  Defines a custom type for numeric code with max number. `field` must be a atom that represents the key of the struct.

  ## Options

  - `:max` - Maximum number of the code. It must be a positive integer.
  - `:description` - Description of the custom type. It must be a string. Used for documentation.
  """
  defmacro sequence(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{unquote(field) => pos_integer}
      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:integer`.
      """
      @spec type() :: :integer
      def type, do: :integer

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(t | pos_integer) :: {:ok, t()} | {:error, pos_integer}
      def cast(%__MODULE__{} = term) do
        with %__MODULE__{unquote(field) => number} <- term,
             true <- is_number(number),
             true <- number > 0,
             true <- number <= unquote(opts[:max]) do
          {:ok, term}
        else
          _ -> {:error, term}
        end
      end

      def cast(term) when is_number(term) do
        with true <- term > 0,
             true <- term <= unquote(opts[:max]) do
          {:ok, %__MODULE__{unquote(field) => term}}
        else
          _ -> {:error, term}
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:integer`.
      """
      @spec dump(t) :: {:ok, pos_integer} | :error
      def dump(%__MODULE__{} = sequence) do
        with %__MODULE__{unquote(field) => number} <- sequence do
          {:ok, number}
        else
          _ -> :error
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:integer`.
      """
      @spec load(integer) :: {:ok, t} | :error
      def load(number) when is_number(number) do
        with true <- number > 0,
             true <- number <= unquote(opts[:max]) do
          {:ok, %__MODULE__{unquote(field) => number}}
        else
          _ -> :error
        end
      end

      @doc """
      Creates a new #{unquote(opts[:description])} with the given term.
      """
      @spec create(pos_integer) :: t()
      def create(sequence)
          when is_integer(sequence) and sequence > 0 and
                 sequence <= unquote(opts[:max]) do
        %__MODULE__{unquote(field) => sequence}
      end

      @doc """
      Returns the result of comparison betweek two #{unquote(opts[:description])}s.
      """
      @spec equal?(t, t) :: boolean()
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
             true <- Map.has_key?(term2, unquote(field)),
             l = Map.get(term1, unquote(field)),
             r = Map.get(term2, unquote(field)),
             true <- l == r do
          true
        else
          _ -> false
        end
      end
    end
  end

  @doc """
  Defines a custom type for currency. `field` must be a atom that represents the key of the struct.

  ## Examples

      iex> defmodule TransactionCurrency do
      ...>   currency(:transaction_currency)
      ...> end
  """
  defmacro currency(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{unquote(field) => atom}

      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:string`.
      """
      @spec type() :: :string
      def type, do: :string

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
        with {:ok, value} <- ExAccounting.Elem.Currency.cast(money.currency) do
          {:ok, %__MODULE__{unquote(field) => value.currency}}
        else
          _ -> :error
        end
      end

      def cast(%__MODULE__{} = currency) do
        with %__MODULE__{unquote(field) => value} <- currency,
             true <- is_atom(value) do
          {:ok, currency}
        else
          _ -> :error
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:string`.
      """
      @spec dump(t) :: String.t() | :error
      def dump(%__MODULE__{} = currency) do
        with %__MODULE__{unquote(field) => value} <- currency,
             true <- is_atom(value) do
          {:ok, to_string(value)}
        else
          _ -> :error
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:string`.
      """
      @spec load(String.t()) :: t | :error
      def load(data) do
        with true <- is_binary(data) do
          {:ok, %__MODULE__{unquote(field) => String.to_atom(data)}}
        else
          _ -> :error
        end
      end

      @doc """
      Returns the result of comparison betweek two #{unquote(opts[:description])}s.
      """
      @spec equal?(t, t) :: boolean()
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
             true <- Map.has_key?(term2, unquote(field)),
             l = Map.get(term1, unquote(field)),
             r = Map.get(term2, unquote(field)),
             true <- l == r do
          true
        else
          _ -> false
        end
      end
    end
  end

  @doc """
  Defines a custom type for representing amount. `field` must be a atom that represents the key of the struct.

  ## Options

  - `:description` - Description of the amount. It must be a string. Used for documentation.

  ## Examples

      iex> defmodule ExAccounting.Elem.UnitPrice do
      ...>   amount(:unit_price)
      ...> end
  """
  defmacro amount(field, opts) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => Decimal.t()}

      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:decimal`.
      """
      @spec type() :: :decimal
      def type, do: :decimal

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(Decimal.t() | t | integer) :: {:ok, t} | :error
      def cast(%__MODULE__{} = amount) do
        with %__MODULE__{unquote(field) => value} <- amount,
             %Decimal{} <- value do
          {:ok, amount}
        else
          _ -> :error
        end
      end

      def cast(%Decimal{} = amount) do
        with %Decimal{} <- amount do
          {:ok, %__MODULE__{unquote(field) => amount}}
        else
          _ -> :error
        end
      end

      def cast(amount) when is_integer(amount) do
        with {:ok, value} <- Decimal.cast(amount) do
          {:ok, %__MODULE__{unquote(field) => value}}
        else
          _ -> :error
        end
      end

      def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
        with {:ok, value} <- Decimal.cast(money.amount) do
          {:ok, %__MODULE__{unquote(field) => value}}
        else
          _ -> :error
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:decimal`.
      """
      @spec dump(t) :: Decimal.t() | :error
      def dump(%__MODULE__{} = amount) do
        with %__MODULE__{unquote(field) => value} <- amount,
             %Decimal{} <- value do
          {:ok, value}
        else
          _ -> :error
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:decimal`.
      """
      @spec load(Decimal.t()) :: t | :error
      def load(data) do
        with %Decimal{} <- data do
          {:ok, %__MODULE__{unquote(field) => data}}
        else
          _ -> :error
        end
      end
    end
  end

  @doc """
  Defines a custom type for period.

  ## Examples

      iex> defmodule ExAccounting.Elem.Period do
      ...>   period(:period, max: 12)
      ...> end
  """
  defmacro period(field, opts) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => pos_integer}
      defstruct [unquote(field)]

      @spec type() :: :integer
      def type, do: :integer

      @spec cast(t | pos_integer | charlist) :: {:ok, t()} | {:error, pos_integer}
      def cast(%__MODULE__{} = period) do
        with %__MODULE__{unquote(field) => number} <- period,
             true <- is_number(number),
             true <- number > 0,
             true <- number <= unquote(opts[:max]) do
          {:ok, period}
        else
          _ -> {:error, period}
        end
      end

      def cast(period) when is_number(period) do
        with true <- period > 0,
             true <- period <= unquote(opts[:max]) do
          {:ok, %__MODULE__{unquote(field) => period}}
        else
          _ -> {:error, period}
        end
      end

      def cast(period) when is_list(period) do
        with true <- length(period) == 2,
             true <-
               List.to_integer(period) >= 0 and
                 List.to_integer(period) <= unquote(opts[:max]) do
          {:ok, create(period)}
        else
          _ -> {:error, period}
        end
      end

      @spec dump(t) :: {:ok, pos_integer} | :error
      def dump(%__MODULE__{} = period) do
        with %__MODULE__{unquote(field) => number} <- period do
          {:ok, number}
        end
      end

      @spec load(data :: integer) :: {:ok, t} | :error
      def load(data) when is_integer(data) do
        with stdata = %{unquote(field) => data}, do: {:ok, struct!(__MODULE__, stdata)}
      end

      @spec create(pos_integer) :: t()
      @spec create(charlist) :: t()
      def create(period) when is_list(period) do
        with true <- List.to_integer(period) >= 0,
             true <- List.to_integer(period) <= unquote(opts[:max]) do
          %__MODULE__{
            unquote(field) => List.to_integer(period)
          }
        end
      end

      def create(period)
          when is_number(period) and period >= 0 and
                 period <= unquote(opts[:max]) do
        %__MODULE__{unquote(field) => period}
      end
    end
  end

  @doc """
  Defines a custom type for indicator field that represents boolean value.

  ## Examples

      iex> defmodule ExAccounting.Elem.ApprovalIndicator do
      ...>   indicator(:is_approved)
      ...> end

      iex> ExAccounting.Elem.ApprovalIndicator.cast(true)
      {:ok, %ExAccounting.Elem.ApprovalIndicator{is_approved: true}}

      iex> dump(%ExAccounting.Elem.ApprovalIndicator{is_approved: true})
      {:ok, "X"}
  """
  defmacro indicator(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => boolean}
      defstruct [unquote(field)]

      @spec type() :: :string
      def type, do: :string

      @spec cast(boolean) :: {:ok, t()} | :error
      def cast(indicator) when is_boolean(indicator) do
        case indicator do
          true -> {:ok, %__MODULE__{unquote(field) => true}}
          false -> {:ok, %__MODULE__{unquote(field) => false}}
        end
      end

      def cast(_), do: :error

      @spec dump(t) :: {:ok, boolean} | :error
      def dump(%__MODULE__{unquote(field) => indicator}) do
        case indicator do
          true -> {:ok, "X"}
          false -> {:ok, " "}
        end
      end

      def dump(_), do: :error

      @spec load(String.t()) :: {:ok, t()} | {:error, boolean}
      def load(indicator) when is_binary(indicator) do
        with true <- indicator in ["X", " "] do
          case indicator do
            "X" -> {:ok, %__MODULE__{unquote(field) => true}}
            " " -> {:ok, %__MODULE__{unquote(field) => false}}
          end
        else
          _ -> :error
        end
      end

      def load(_), do: :error

      @spec default() :: t
      def default, do: %__MODULE__{unquote(field) => false}
    end
  end

  @doc """
  Defines a custom type for time field.

  ## Examples

      iex> defmodule ExAccounting.Elem.EnteredAt do
      ...>   time(:entered_at)
      ...> end

      iex> ExAccounting.Elem.EnteredAt.cast(~T[12:00:00])
      {:ok, %ExAccounting.Elem.EnteredAt{entered_at: ~T[12:00:00] }}
  """
  defmacro time(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => Time.t()}
      defstruct [unquote(field)]

      @spec type() :: :time
      def type, do: :time

      @spec cast(t | Time.t()) :: {:ok, t()} | :error
      def cast(%__MODULE__{} = time) do
        {:ok, time}
      end

      def cast(%Time{} = time) do
        {:ok, %__MODULE__{unquote(field) => time}}
      end

      def cast(_), do: :error

      @spec dump(t) :: {:ok, Time.t()} | :error
      def dump(%__MODULE__{unquote(field) => time}), do: {:ok, time}
      def dump(_), do: :error

      @spec load(Time.t()) :: {:ok, t()} | :error
      def load(%Time{} = time), do: {:ok, %__MODULE__{unquote(field) => time}}
      def load(_), do: :error

      @spec create(Time.t()) :: t()
      def create(%Time{} = time) do
        %__MODULE__{unquote(field) => time}
      end
    end
  end

  @doc """
  Defines a custom type for date.

  ## Examples

      iex> defmodule ExAccounting.Elem.PostingDate do
      ...>   date(:posting_date)
      ...> end
  """
  defmacro date(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{unquote(field) => Date.t()}
      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:date`.
      """
      def type, do: :date

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(Date.t()) :: {:ok, t()} | :error
      def cast(term) do
        with %Date{} <- term do
          {:ok, %__MODULE__{unquote(field) => term}}
        else
          _ -> :error
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])}  into database field with type `:date`.
      """
      @spec dump(t) :: {:ok, Date.t()} | :error
      def dump(date) do
        with %__MODULE__{unquote(field) => date} <- date do
          {:ok, date}
        else
          _ -> :error
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:date`.
      """
      @spec load(Date.t()) :: {:ok, t()} | {:error, Date.t()}
      def load(term) do
        with %Date{} <- term do
          {:ok, %__MODULE__{unquote(field) => term}}
        else
          _ -> {:error, term}
        end
      end

      @doc """
      Creates a new #{unquote(opts[:description])} with the given term.
      """
      @spec create(Date.t()) :: t()
      def create(%Date{} = term) do
        %__MODULE__{unquote(field) => term}
      end
    end
  end

  @doc """
  Defines a custom type for year.
  Year must be a positive integer and less than or equal to 9999.

  ## Examples

      iex> defmodule YearDocumentPosted do
      ...>   year(:fiscal_year)
      ...> end
  """
  defmacro year(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{unquote(field) => pos_integer}
      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:integer`.
      """
      @spec type() :: :integer
      def type, do: :integer

      @doc """
      Creates a new #{unquote(opts[:description])} with the given term.
      """
      @spec create(pos_integer) :: t()
      def create(fiscal_year)
          when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year <= 9999 do
        %__MODULE__{unquote(field) => fiscal_year}
      end

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(pos_integer) :: {:ok, t()} | {:error, pos_integer}
      def cast(term) do
        with true <- is_integer(term),
             true <- term > 0,
             true <- term <= 9999 do
          {:ok, create(term)}
        else
          false -> {:error, term}
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:integer`.
      """
      @spec dump(t) :: {:ok, pos_integer} | :error
      def dump(%__MODULE__{} = term) do
        {:ok, term.fiscal_year}
      end

      def dump(_) do
        :error
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:integer`.
      """
      @spec load(pos_integer) :: {:ok, t()} | :error
      def load(term) do
        {:ok, create(term)}
      end

      @doc """
      Returns the result of comparison betweek two years.
      Years are compared by key `#{unquote(:field)}` and its value not by the struct itself.
      """
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
             true <- Map.has_key?(term2, unquote(field)),
             l = Map.get(term1, unquote(field)),
             r = Map.get(term2, unquote(field)),
             true <- l == r do
          true
        else
          _ -> false
        end
      end
    end
  end

  @doc """

  Defines a custom type for username.

  ## Exapmles

      iex> defmodule PostedBy do
      ...>   username(:user_name)
      ...> end
  """

  defmacro username(field, opts) do
    quote do
      use Ecto.Type

      @typedoc """
      #{unquote(opts[:description])}
      """
      @type t :: %__MODULE__{unquote(field) => charlist}
      defstruct [unquote(field)]

      @doc """
      Defines the type of #{unquote(opts[:description])} in database as `:string`.
      """
      def type, do: :string

      @doc """
      Casts the given term to #{unquote(opts[:description])}.
      """
      @spec cast(t) :: {:ok, t}
      @spec cast(String.t() | charlist) :: {:ok, t} | :error
      def cast(%__MODULE__{} = term) do
        {:ok, term}
      end

      def cast(term) do
        with true <- is_list(term) or is_binary(term),
             true <- ExAccounting.Utility.len(term) <= 16,
             code = ExAccounting.Utility.to_c(term) |> convert_to_lowercase(),
             {:ok, _validated} <- validate_user_name(code) do
          {:ok, create(code)}
        else
          _ -> :error
        end
      end

      @doc """
      Dumps #{unquote(opts[:description])} into database field with type `:string`.
      """
      @spec dump(t) :: binary() | :error
      def dump(term) do
        with %__MODULE__{user_name: code} <- term do
          code
          |> to_string()
        else
          _ -> :error
        end
      end

      @doc """
      Loads #{unquote(opts[:description])} from database field with type `:string`.
      """
      def load(data) do
        with user_name = to_charlist(data),
             {:ok, _} <- validate_user_name(user_name) do
          {:ok, create(data)}
        else
          _ -> :error
        end
      end

      @doc """
      Creates a new #{unquote(opts[:description])} with the given term.
      """
      @spec create(charlist) :: t() | {:error, String.t()}
      def create(user_name) when is_list(user_name) and length(user_name) <= 16 do
        case validate_user_name(convert_to_lowercase(user_name)) do
          {:ok, user_name} -> %__MODULE__{user_name: user_name}
          {:error, _user_name} -> {:error, "invalid_user_name"}
        end
      end

      def create(user_name) when is_binary(user_name) do
        user_name
        |> to_charlist
        |> create
      end

      @doc """
      Returns the result of comparison betweek two #{unquote(opts[:description])}s.
      The #{unquote(opts[:description])}s are compared by key `#{unquote(field)}` and its value not by the struct itself.
      """
      def equal?(term1, term2) do
        with true <- Map.has_key?(term1, unquote(field)),
             true <- Map.has_key?(term2, unquote(field)),
             l = Map.get(term1, unquote(field)),
             r = Map.get(term2, unquote(field)),
             true <- l == r do
          true
        else
          _ -> false
        end
      end

      @spec validate_user_name(charlist) :: {:ok, charlist} | {:error, charlist}
      def validate_user_name(user_name) do
        valid_charactors = ~c[abcdefghijklmnopqrstuvwxyz0123456789_.]

        {
          user_name
          |> Enum.reduce(:ok, fn x, acc ->
            case x in valid_charactors do
              true -> acc
              false -> :error
            end
          end),
          user_name
        }
      end

      @spec convert_to_lowercase(charlist) :: charlist
      defp convert_to_lowercase(upper_case_can_be_contained)
           when is_list(upper_case_can_be_contained) do
        upper_case_can_be_contained
        |> to_string
        |> String.downcase()
        |> to_charlist
      end
    end
  end
end
