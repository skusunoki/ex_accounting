defmodule ExAccounting.Type do
  defmacro __using__(_opts) do
    quote do
      import ExAccounting.Type
    end
  end

  @doc """
  options:
    type
    length
  """
  defmacro code(field, opts) do
    quote do
      use Ecto.Type
      @type t :: %__MODULE__{unquote(field) => charlist}

      defstruct [unquote(field)]

      @spec type() :: unquote(opts[:type])
      def type, do: unquote(opts[:type])

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
          {:ok, create(term)}
        else
          _ -> {:error, term}
        end
      end

      def load(data) when is_binary(data) do
        with stdata = %{unquote(field) => to_charlist(data)},
          do: {:ok, struct!(__MODULE__, stdata)}
      end

      def dump(term) do
        with %__MODULE__{unquote(field) => code} <- term,
             {:ok, _validated} <- validate(code),
             dump = code |> to_string() do
          {:ok, dump}
        else
          _ -> :error
        end
      end

      def create(term)
          when term != nil and is_list(term) and length(term) == unquote(opts[:length]) do
        %__MODULE__{unquote(field) => term}
      end

      def create(term) when is_binary(term) and term != nil do
        term
        |> to_charlist()
        |> create()
      end

      def validate(code) do
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

  defmacro entity(field, opts) do
    quote do
      use Ecto.Type
      @type t :: %__MODULE__{
              unquote(field) => charlist()
            }
      defstruct [unquote(field)]

      def type, do: :string

      @doc """
      Casts term to valid form of entity.
      Length of the given term should be less than or equal to the defined length of the entity.
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

      def dump(%__MODULE__{} = entity), do: {:ok, to_string(entity.unquote(field))}
      def dump(_), do: :error

      def load(term) do
        with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
             true <- length(validated) <= unquote(opts[:length]) do
          {:ok, %__MODULE__{unquote(field) => validated}}
        else
          _ -> :error
        end
      end
    end
  end

  defmacro sequence(field, opts) do
    quote do
      use Ecto.Type
      @type t :: %__MODULE__{unquote(field) => pos_integer}
      defstruct [unquote(field)]

      @spec type() :: :integer
      def type, do: :integer

      @spec cast(t | pos_integer) :: {:ok, t()} | {:error, pos_integer}
      def cast(%__MODULE__{} = sequence) do
        with %__MODULE__{unquote(field) => number} <- sequence,
             true <- is_number(number),
             true <- number > 0,
             true <- number <= unquote(opts[:max]) do
          {:ok, sequence}
        else
          _ -> {:error, sequence}
        end
      end

      def cast(sequence) when is_number(sequence) do
        with true <- sequence > 0,
             true <- sequence <= unquote(opts[:max]) do
          {:ok, %__MODULE__{unquote(field) => sequence}}
        else
          _ -> {:error, sequence}
        end
      end

      @spec dump(t) :: {:ok, pos_integer} | :error
      def dump(%__MODULE__{} = sequence) do
        with %__MODULE__{unquote(field) => number} <- sequence do
          {:ok, number}
        else
          _ -> :error
        end
      end

      @spec load(integer) :: {:ok, t} | :error
      def load(number) when is_number(number) do
        with true <- number > 0,
             true <- number <= unquote(opts[:max]) do
          {:ok, %__MODULE__{unquote(field) => number}}
        else
          _ -> :error
        end
      end

      @spec create(pos_integer) :: t()
      def create(sequence)
          when is_integer(sequence) and sequence > 0 and
                 sequence <= unquote(opts[:max]) do
        %__MODULE__{unquote(field) => sequence}
      end
    end
  end

  defmacro currency(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => atom}

      defstruct [unquote(field)]

      @spec type() :: :string
      def type, do: :string

      def cast(%ExAccounting.EmbeddedSchema.Money{} = money) do
        with {:ok, value} <- ExAccounting.Elem.Currency.cast(money.currency) do
          {:ok, %__MODULE__{unquote(field) => value.currency}}
        else
          _ -> :error
        end
      end

      @spec dump(t) :: String.t() | :error
      def dump(%__MODULE__{} = currency) do
        with %__MODULE__{unquote(field) => value} <- currency,
             true <- is_atom(value) do
          {:ok, to_string(value)}
        else
          _ -> :error
        end
      end

      @spec load(String.t()) :: t | :error
      def load(data) do
        with true <- is_binary(data) do
          {:ok, %__MODULE__{unquote(field) => String.to_atom(data)}}
        else
          _ -> :error
        end
      end
    end
  end

  defmacro amount(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => Decimal.t()}

      defstruct [unquote(field)]

      @spec type() :: :decimal
      def type, do: :decimal

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

      @spec dump(t) :: Decimal.t() | :error
      def dump(%__MODULE__{} = amount) do
        with %__MODULE__{unquote(field) => value} <- amount,
             %Decimal{} <- value do
          {:ok, value}
        else
          _ -> :error
        end
      end

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

  defmacro date(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => Date.t()}
      defstruct [unquote(field)]

      def type, do: :date

      @spec cast(Date.t()) :: {:ok, t()} | :error
      def cast(date) do
        with %Date{} <- date do
          {:ok, %__MODULE__{unquote(field) => date}}
        else
          _ -> :error
        end
      end

      @spec dump(t) :: {:ok, Date.t()} | :error
      def dump(posting_date) do
        with %__MODULE__{unquote(field) => date} <- posting_date do
          {:ok, date}
        else
          _ -> :error
        end
      end

      @spec load(Date.t()) :: {:ok, t()} | {:error, Date.t()}
      def load(date) do
        with %Date{} <- date do
          {:ok, %__MODULE__{unquote(field) => date}}
        else
          _ -> {:error, date}
        end
      end

      @spec create(Date.t()) :: t()
      def create(%Date{} = posting_date) do
        %__MODULE__{unquote(field) => posting_date}
      end
    end
  end

  defmacro year(field) do
    quote do
      use Ecto.Type

      @type t :: %__MODULE__{unquote(field) => pos_integer}
      defstruct [unquote(field)]

      @spec type() :: :integer
      def type, do: :integer

      @spec create(pos_integer) :: t()
      def create(fiscal_year)
          when is_integer(fiscal_year) and fiscal_year > 0 and fiscal_year <= 9999 do
        %__MODULE__{fiscal_year: fiscal_year}
      end

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

      @spec dump(t) :: {:ok, pos_integer} | :error
      def dump(%__MODULE__{} = term) do
        {:ok, term.fiscal_year}
      end

      def dump(_) do
        :error
      end

      @spec load(pos_integer) :: {:ok, t()} | :error
      def load(term) do
        {:ok, create(term)}
      end
    end
  end

  defmacro username(field) do
    quote do
      @type t :: %__MODULE__{unquote(field) => charlist}
      defstruct [unquote(field)]

      def type, do: :string

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

      @spec dump(t) :: binary() | :error
      def dump(term) do
        with %__MODULE__{user_name: code} <- term do
          code
          |> to_string()
        else
          _ -> :error
        end
      end

      def load(data) do
        with user_name = to_charlist(data),
             {:ok, _} <- validate_user_name(user_name) do
          {:ok, create(data)}
        else
          _ -> :error
        end
      end

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
