defmodule Aoc2024.Day03 do

  def part_one(input) do
    ~r/mul\((-?\d+),(-?\d+)\)/
      |> Regex.scan(input, capture: :all_but_first)
      |> Enum.map(&Util.list_int_parse/1)
      |> Enum.map(fn [a, b] -> a * b end)
      |> Enum.sum()
  end

  def part_two(input) do
    ~r/(mul|do|don't)\((?:(-?\d+),(-?\d+))?\)/
      |> Regex.scan(input, capture: :all_but_first)
      |> Enum.reduce({:y, 0}, fn
        ["mul" | [a, b]], {:y, s} ->
          a = String.to_integer(a)
          b = String.to_integer(b)
          {:y, s + (a * b)}
        ["mul" | _args], {:n, s} ->
          {:n, s}
        ["do"], {_, s} ->
          {:y, s}
        ["don't"], {_, s} ->
          {:n, s}
      end)
      |> elem(1)
  end

end
