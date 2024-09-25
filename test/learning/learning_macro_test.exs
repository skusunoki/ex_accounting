defmodule LearningMacroTest do
  use ExUnit.Case
  alias Learning.UseMacro.{Example1, Example2, Example3}

  test "type should be :string" do
    assert Example1.type() == :string
  end

  test "struct should be defined" do
    IO.inspect(%Example1{})
  end

  test "string casts to struct" do
    assert Example1.cast("1234567890") ==
             {:ok, %Example1{example1: ~c"1234567890"}}
  end

  test "charlist casts to struct" do
    assert Example1.cast(~c"1234567890") ==
             {:ok, %Example1{example1: ~c"1234567890"}}
  end

  test "dumped struct should be string" do
    assert Example1.dump(%Example1{example1: ~c"1234567890"}) ==
             {:ok, "1234567890"}
  end

  test "loaded data should be struct" do
    assert Example1.load("1234567890") ==
             {:ok, %Example1{example1: ~c"1234567890"}}
  end

  test "length should be strict" do
    assert Example1.cast("12345678901") == {:error, "12345678901"}
  end

  test "length should be strict2" do
    assert Example2.cast("123") == {:error, "123"}
  end

  test "Module should be exist" do
    assert Example3.type() == :string
  end
end
