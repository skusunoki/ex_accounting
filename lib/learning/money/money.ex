defmodule Learning.Money.Money do
  use Ecto.Type
  defstruct amount: nil, currency: nil

  def type, do: :map

  def cast(%{amount: amount, currency: currency}) do
    {:ok, %__MODULE__{amount: amount, currency: currency}}
  end

  def dump(%__MODULE__{amount: amount, currency: currency}) do
    {:ok, %{amount1: amount, currency1: currency}}
  end

  def load(%{amount: amount, currency: currency}) do
    {:ok, %__MODULE__{amount: amount, currency: currency}}
  end
end
