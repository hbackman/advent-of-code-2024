defmodule Aoc2024.Day13 do

  defp parse(input) do
    input
      |> Util.string_split_lines(2)
      |> Util.array_split_lines()
      |> Enum.map(&Enum.map(&1, fn m -> scan_nums(m) end))
  end

  defp scan_nums(string) do
    ~r/.*: X[\+=](\d+), Y[\+=](\d+)/
      |> Regex.run(string, capture: :all_but_first)
      |> Util.list_int_parse()
      |> List.to_tuple()
  end

  defp solve([{ax, ay}, {bx, by}, {px, py}]) do
    a_cost = 3
    b_cost = 1

    # linear regression?

    IO.inspect {{ax, ay}, {bx, by}, {px, py}}
  end

  def part_one(input) do
    input
      |> parse()
      |> List.first()
      |> solve()
  end

end
