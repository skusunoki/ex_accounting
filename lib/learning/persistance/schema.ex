defmodule Learning.Persistence.Schema do
  use Ecto.Schema

  schema "three_vectors" do
    field(:position1_x, Learning.Persistence.PositionX)
    field(:position1_y, Learning.Persistence.PositionY)
    field(:position2_x, Learning.Persistence.PositionX)
    field(:position2_y, Learning.Persistence.PositionY)
    field(:position3_x, Learning.Persistence.PositionX)
    field(:position3_y, Learning.Persistence.PositionY)
  end
end

defimpl Learning.Persistence.Persistable, for: Learning.Persistence.Schema do
  import Ecto.Changeset

  def changeset(schema, %Learning.Persistence.EmbeddedSchema{} = params) do
    schema
    |> cast(%{position1_x: params.position1, position1_y: params.position1}, [
      :position1_x,
      :position1_y
    ])
    |> cast(%{position2_x: params.position2, position2_y: params.position2}, [
      :position2_x,
      :position2_y
    ])
    |> cast(%{position3_x: params.position3, position3_y: params.position3}, [
      :position3_x,
      :position3_y
    ])
  end

  def changeset(schema, params) do
    schema
    |> cast(params, [
      :position1_x,
      :position1_y,
      :position2_x,
      :position2_y,
      :position3_x,
      :position3_y
    ])
  end
end
