defmodule PhoneKeyboardTest do
  use ExUnit.Case
  doctest PhoneKeyboard

  test "translates individual numbers" do
    assert PhoneKeyboard.parse("2") == "a"
  end

  test "uses dashes to separate words" do
    assert PhoneKeyboard.parse("444-555-88-888") == "iluv"
  end

  test "errors on unrecognized sequences" do
    assert PhoneKeyboard.parse("23-24") == {:error, ~S(unrecognized sequence for "23")}
  end
end
