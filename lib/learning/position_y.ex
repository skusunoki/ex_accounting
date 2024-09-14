defmodule Learning.PositionY do
  use Ecto.Type

  defstruct y: nil

  def type, do: :integer

  def cast(%{y: y_axis}) do
    {:ok, %__MODULE__{y: y_axis}}
  end

  def cast(%Learning.CompositeType.Vector{y: y_axis}) do
    {:ok, %__MODULE__{y: y_axis}}
  end

  def dump(%__MODULE__{y: y_axis}) do
    {:ok, y_axis}
  end

  def load(y_axis) do
    {:ok, %__MODULE__{y: y_axis}}
  end
end
