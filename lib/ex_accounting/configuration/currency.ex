defmodule ExAccounting.Configuration.Currency do
  @moduledoc """
  _Currency Configuration_ defines the currencies available in the system.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias ExAccounting.Configuration.Currency.DbGateway

  @typedoc "_Currency Configuration_"

  @type t :: %__MODULE__{
          currency: ExAccounting.EmbeddedSchema.Money.Currency.t(),
          cent_factor: integer
        }

  @server ExAccounting.Configuration.Currency.Server

  @primary_key false
  embedded_schema do
    field(:currency, ExAccounting.EmbeddedSchema.Money.Currency)
    field(:cent_factor, :integer)
  end

  @spec add(ExAccounting.EmbeddedSchema.Money.Currency.t()) :: :ok
  def add(currency) do
    GenServer.call(@server, {:add, currency})
  end

  @spec read() :: [atom()]
  def read() do
    GenServer.call(@server, :read)
  end

  def save() do
    with server <- read() do
      DbGateway.save(server)
    end
  end

  def changeset(%__MODULE__{} = struct, %{currency: _currency} = params) do
    struct
    |> cast(params, [:currency])
  end

  # TODO: Implement the database read function
  def cent_factor(currency) do
    GenServer.call(@server, {:cent_factor, currency})

    case currency do
      :USD -> 100
      :JPY -> 1
      :EUR -> 100
      _ -> 100
    end
  end
end
