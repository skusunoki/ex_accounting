defmodule ExAccounting.LearningDateTest do
  use ExUnit.Case
  import Ecto.Query

  test "Read from ecto date type" do
    {:ok, record} =
      from(p in Learning.LearningDate)
      |> ExAccounting.Repo.one()
      |> Learning.LearningDate.changeset(%{date: ~D[2024-08-11]})
      |> ExAccounting.Repo.update()

    assert record != nil

    result =
      from(Learning.LearningDate)
      |> ExAccounting.Repo.one()

    assert result.date == ~D[2024-08-11]
  end
end
