defmodule PhoneKeyboard do
  @moduledoc """
  A phone keyboard parser.
  It takes a string with letters separated by dashes, which separate individual letters.
  The above translates to "brb".

  ## Examples
    iex> PhoneKeyboard.parse("22-777-22")
    "brb"
  """

  def parse(string) do
    with split <- String.split(string, "-"),
         {:ok, mapped} <- parse_values(split),
         mapped <- Enum.reverse(mapped),
         do: Enum.join(mapped)
  end

  defp parse_values(values) do
    values = Enum.reduce_while(values, [], fn value, all_parsed ->
      case for_string(value) do
        {:ok, value} -> {:cont, [value | all_parsed]}
        error -> {:halt, error}
      end
    end)

    case values do
      {:error, _reason} = error -> error
      values -> {:ok, values}
    end
  end

  keyboard_map = %{
    "2" => "a",
    "22" => "b",
    "222" => "c",
    "3" => "d",
    "33" => "e",
    "333" => "f",
    "4" => "g",
    "44" => "h",
    "444" => "i",
    "5" => "j",
    "55" => "k",
    "555" => "l",
    "6" => "m",
    "66" => "n",
    "666" => "o",
    "7" => "p",
    "77" => "q",
    "777" => "r",
    "7777" => "s",
    "8" => "t",
    "88" => "u",
    "888" => "v",
    "9" => "w",
    "99" => "x",
    "999" => "y",
    "9999" => "z",
    "0" => " "
  }

  for {string, letter} <- keyboard_map do
    defp for_string(unquote(string)), do: {:ok, unquote(letter)}
  end

  defp for_string(str), do: {:error, "unrecognized sequence for #{inspect(str)}"}
end
