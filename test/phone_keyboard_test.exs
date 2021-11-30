defmodule PhoneKeyboardTest do
  use ExUnit.Case
  doctest PhoneKeyboard.Parser

  alias PhoneKeyboard.Parser

  test "translates individual numbers" do
    assert Parser.parse("2") == {:ok, "a"}
  end

  test "uses dashes to separate words" do
    assert Parser.parse("444-555-88-888") == {:ok, "iluv"}
  end

  test "errors on unrecognized sequences" do
    assert Parser.parse("23-24") == {:error, ~S(unrecognized sequence)}
  end
end
