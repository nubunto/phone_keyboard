defmodule PhoneKeyboard.Parser do
  @moduledoc """
  A phone keyboard parser.
  It takes a string with letters separated by dashes.

  ## Examples
    iex> PhoneKeyboard.Parser.parse("22-777-22")
    {:ok, "brb"}
  """

  def parse(string) do
    letters =
      string
      |> String.split("-")
      |> Enum.map(&PhoneKeyboard.Mapper.for_string/1)

    case Enum.any?(letters, &(&1 === :error)) do
      true ->
        {:error, "unrecognized sequence"}

      false ->
        word =
          letters
          |> Enum.map(fn {:ok, letter} -> letter end)
          |> Enum.join("")

        {:ok, word}
    end
  end
end
