defprotocol Learning.Persistence.Persistable do
  def changeset(schema, params)
end
