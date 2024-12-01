defmodule Util do
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