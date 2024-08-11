defmodule ExAccounting.DataItemDictionary.EnteredAt do
  @moduledoc """
  EnteredAt is the time of the document created.
  """

  @type t :: %__MODULE__{entered_at: Time.t()}
  defstruct entered_at: nil

  @doc """
    [create] is function for generating valid EnteredAt.

  ## Examples

    iex> EnteredAt.create(~T[12:34:56.00])
    %EnteredAt{entered_at: ~T[12:34:56.00]}
  """
  @spec create(Time.t()) :: t()
  def create(%Time{} = entered_at) do
    %__MODULE__{entered_at: entered_at}
  end
end
