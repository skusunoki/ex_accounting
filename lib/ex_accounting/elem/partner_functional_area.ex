defmodule ExAccounting.Elem.PartnerFunctionalArea do
  @moduledoc """
  _Partner Functional Area_ is identifier of a partner functional area.
  """

  use Ecto.Type

  @type t :: %__MODULE__{
          partner_functional_area: charlist()
        }
  defstruct partner_functional_area: nil

  def type, do: :string

  def cast(%__MODULE__{} = partner_functional_area), do: {:ok, partner_functional_area}

  def cast(term) when is_binary(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- String.length(term) <= 10 do
      {:ok, %__MODULE__{partner_functional_area: validated}}
    else
      _ -> :error
    end
  end

  def cast(term) when is_list(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(term),
         true <- length(term) <= 10 do
      {:ok, %__MODULE__{partner_functional_area: validated}}
    else
      _ -> :error
    end
  end

  def cast(_), do: :error

  def dump(%__MODULE__{} = partner_functional_area),
    do: {:ok, to_string(partner_functional_area.partner_functional_area)}

  def dump(_), do: :error

  def load(term) do
    with {:ok, validated} <- ExAccounting.Utility.validate(to_charlist(term)),
         true <- length(validated) <= 10 do
      {:ok, %__MODULE__{partner_functional_area: validated}}
    else
      _ -> :error
    end
  end
end
