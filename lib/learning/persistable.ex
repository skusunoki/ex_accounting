defprotocol Learning.Persistable do
  def changeset(schema, params)
end
