defmodule Learning.VectorTest do
  use ExUnit.Case
  alias Learning.CompositeType.Vector
  alias Learning.EmbeddedSchema

  test "vector" do
    vector = %Vector{x: 1, y: 2}
    assert vector.x == 1
    assert vector.y == 2
  end

  test "vector with embedded schema" do
    vector = %Vector{x: 1, y: 2}
    embedded_schema = %EmbeddedSchema{position1: vector, position2: vector, position3: vector}
    assert embedded_schema.position1.x == 1
    assert embedded_schema.position1.y == 2
    assert embedded_schema.position2.x == 1
    assert embedded_schema.position2.y == 2
    assert embedded_schema.position3.x == 1
    assert embedded_schema.position3.y == 2
  end

  test "map to database schema" do
    vector1 = %Vector{x: 1, y: 2}
    vector2 = %Vector{x: 3, y: 4}
    vector3 = %Vector{x: 5, y: 6}

    %Learning.Schema{}
    |> Learning.Persistable.changeset(%{
      position1_x: vector1,
      position1_y: vector1,
      position2_x: vector2,
      position2_y: vector2,
      position3_x: vector3,
      position3_y: vector3
    })
    |> ExAccounting.Repo.insert()
  end

  test "to_schema" do
    vector1 = %{x: 10, y: 2}
    vector2 = %{x: 3, y: 4}
    vector3 = %{x: 5, y: 6}

    %Learning.EmbeddedSchema{}
    |> Learning.EmbeddedSchema.changeset(%{
      position1: vector1,
      position2: vector2,
      position3: vector3
    })
    |> Ecto.Changeset.apply_changes()
    |> Learning.EmbeddedSchema.to_repo(%Learning.Schema{})
    |> ExAccounting.Repo.insert()
  end

  test "normarize" do
    vector1 = %{x: 10, y: 2}
    vector2 = %{x: 3, y: 40}
    vector3 = %{x: 5, y: 6}

    %Learning.EmbeddedSchema{}
    |> Learning.EmbeddedSchema.changeset(%{
      position1: vector1,
      position2: vector2,
      position3: vector3
    })
    |> Ecto.Changeset.apply_changes()
    |> (&Learning.Persistable.changeset(%Learning.Schema{}, &1)).()
    |> ExAccounting.Repo.insert()
  end
end
