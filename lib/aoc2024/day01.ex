defmodule Aoc2024.Day01 do

  alias Util

  defp parse(line) do
    line
      |> String.split("   ", trim: true)
      |> Enum.map(&String.to_integer/1)
      |> List.to_tuple()
  end

  defp sort(lists) do
    {l1, l2} = Enum.unzip(lists)

    l1 = Enum.sort(l1)
    l2 = Enum.sort(l2)

    Enum.zip(l1, l2)
  end

  defp dist(lists) do
    lists
      |> Enum.map(fn {a, b} -> abs(a - b) end)
      |> Enum.sum()
  end

  def part_one(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&parse/1)
      |> sort()
      |> dist()
  end

  def part_two(input) do
    {l1, l2} = input
      |> Util.string_split_lines()
      |> Enum.map(&parse/1)
      |> Enum.unzip()

    l1
      |> Enum.map(fn v ->
        similarity = l2
          |> Enum.filter(&(&1 == v))
          |> Enum.count()
        similarity * v
      end)
      |> Enum.sum()
  end

end
