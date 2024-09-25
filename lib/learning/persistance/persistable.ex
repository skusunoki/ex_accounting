defprotocol Learning.Persistence.Persistable do
  @moduledoc """
  The `Persistable` protocol is used to convert a struct to a changeset.
  """
  def changeset(schema, params)
end
