defmodule Learning.Persistence.EmbeddedSchema do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field(:position1, Learning.Persistence.Vector)
    field(:position2, Learning.Persistence.Vector)
    field(:position3, Learning.Persistence.Vector)
  end

  def changeset(embedded_schema, params) do
    embedded_schema
    |> cast(params, [:position1, :position2, :position3])
  end

  def to_repo(embedded_schema, schema) do
    schema
    |> Learning.Persistence.Persistable.changeset(embedded_schema)
  end
end
