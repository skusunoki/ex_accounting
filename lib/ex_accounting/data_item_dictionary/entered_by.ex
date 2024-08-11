defmodule ExAccounting.DataItemDictionary.EnteredBy do
  @moduledoc """
  TODO
  """

  @type t :: %__MODULE__{entered_by: ExAccounting.SystemDictionary.UserName.t()}
  defstruct entered_by: nil

  @doc """
    [create] is function for generating valid EnteredBy.

  ## Exampels

    iex> EnteredBy.create( ExAccounting.SystemDictionary.UserName.create(~C[JohnDoe]))
    %EnteredBy{entered_by: %ExAccounting.SystemDictionary.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(ExAccounting.SystemDictionary.UserName.t()) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = entered_by) do
    %__MODULE__{entered_by: entered_by}
  end
end
