defmodule Util do
  @doc """
  Formats a string as a list of integers.

  ## Examples

    iex> Util.string_to_int_list("13 18 15")
    [13, 18, 15]

    iex> Util.string_to_int_list("12,19,14", ",")
    [12, 19, 14]

  """
  def string_to_int_list(string, separator \\ " ") do
    string
      |> String.split(separator, trim: true)
      |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Formats a string as a list.

  ## Examples

    iex> Util.string_split_lines("hello\\nworld")
    ["hello", "world"]

    iex> Util.string_split_lines("hello\\nworld\\n")
    ["hello", "world"]

  """
  def string_split_lines(string) do
    String.split(string, ~r/\R/, trim: true)
  end
end
