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
      |> String.replace("\n", "")
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
  def string_split_lines(string, n \\ 1) when is_bitstring(string) do
    String.split(string, ~r/\R{#{n}}/, trim: true)
  end

  def array_split_lines(array, n \\ 1) when is_list(array) do
    Enum.map(array, &string_split_lines(&1, n))
  end

  def array_split_strings(array) when is_list(array) do
    Enum.map(array, &String.split(&1, "", trim: true))
  end

  @doc """
  Formats a list of string integers into a list of integers.

  ## Examples

    iex> Util.list_int_parse(["1", "2", "3"])
    [1, 2, 3]

  """
  def list_int_parse(list) do
    Enum.map(list, &String.to_integer/1)
  end
end
