defmodule ExAccounting.DataItemDictionary.PostedBy do
  @moduledoc """
    _Entered By_ is who posts the accounting document.
  """

  @typedoc "_Posted By_"
  @type t :: %__MODULE__{posted_by: ExAccounting.SystemDictionary.UserName.t()}

  @typedoc "_User Name_"
  @type user_name :: ExAccounting.SystemDictionary.UserName.t()
  defstruct posted_by: nil

  @doc """
    Generates the valid _Posted By_ from _User Name_.

  ## Exampels

      iex> PostedBy.create( ExAccounting.SystemDictionary.UserName.create( ~C[JohnDoe]))
      %PostedBy{posted_by: %ExAccounting.SystemDictionary.UserName{ user_name: ~C[johndoe]}}
  """
  @spec create(user_name :: user_name) :: t()
  def create(%ExAccounting.SystemDictionary.UserName{} = user_name) do
    %__MODULE__{posted_by: user_name}
  end
end
