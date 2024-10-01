defmodule ExAccounting.Elem.ReferenceKey do
  @moduledoc """
  _Reference Key_ is the key of reference.
  """
  use Ecto.Type

  @type t :: %__MODULE__{reference_key: String.t()}
  defstruct [:reference_key]

  def type, do: :string

  def cast(%__MODULE__{reference_key: reference_key}), do: {:ok, reference_key}
  def cast(reference_key), do: {:ok, %__MODULE__{reference_key: reference_key}}

  def dump(%__MODULE__{reference_key: reference_key}), do: {:ok, reference_key}
  def dump(reference_key), do: {:ok, reference_key}

  def load(term), do: {:ok, %__MODULE__{reference_key: term}}
end
