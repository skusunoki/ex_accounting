defprotocol ExAccounting.Persistable do
  def changeset(schema, params)
end

