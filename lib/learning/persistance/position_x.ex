defmodule Learning.Persistence.PositionX do
  use Ecto.Type

  defstruct x: nil

  def type, do: :integer

  def cast(%{x: x_axis}) do
    {:ok, %__MODULE__{x: x_axis}}
  end

  def cast(%Learning.Persistence.Vector{x: x_axis}) do
    {:ok, %__MODULE__{x: x_axis}}
  end

  def dump(%__MODULE__{x: x_axis}) do
    {:ok, x_axis}
  end

  def load(x_axis) do
    {:ok, %__MODULE__{x: x_axis}}
  end
end
