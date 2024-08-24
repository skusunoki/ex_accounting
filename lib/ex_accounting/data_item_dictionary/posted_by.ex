defmodule ExAccounting.DataItemDictionary.PostedBy do
  @moduledoc """
    _Entered By_ is who posts the accounting document.
  """

  @typedoc "_Posted By_"
  @type t :: %__MODULE__{posted_by: ExAccounting.SystemDictionary.UserName.t()}
  defstruct posted_by: nil

  @doc """
    [create] is function for generating valid PostedBy.

  ## Exampels

    iex> PostedBy.create( ExAccounting.SystemDictionary.UserName.create( ~C[JohnDoe]))
    %PostedBy{posted_by: %ExAccounting.SystemDictionary.UserName{ user_name: ~C[johndoe]}}

  """
  @spec create(ExAccounting.SystemDictionary.UserName.t()) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = posted_by) do
    %__MODULE__{posted_by: posted_by}
  end
end
