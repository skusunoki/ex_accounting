defmodule Learning.CompositeType.Vector do
  use Ecto.Type

  defstruct x: nil, y: nil

  def type, do: :map

  def cast(%{x: x_axis, y: y_axis}) do
    {:ok, %__MODULE__{x: x_axis, y: y_axis}}
  end

  def dump(%__MODULE__{x: x_axis, y: y_axis}) do
    {:ok, %{x: x_axis, y: y_axis}}
  end

  def load(%{x: x_axis, y: y_axis}) do
    {:ok, %__MODULE__{x: x_axis, y: y_axis}}
  end
end
