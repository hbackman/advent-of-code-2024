defmodule Aoc2024.Day02 do

  alias Util

  defp parse(input) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&Util.string_to_int_list/1)
  end

  defp safe?(levels, dir \\ :unknown)
  defp safe?([l1, l2 | levels], dir) do
    dir2 = if l2 > l1,
      do:   :inc,
      else: :dec

    cond do
      # increases more than 3
      abs(l1 - l2) > 3 -> false

      # did not increase
      l1 == l2 -> false

      # is increasing but direction is decreasing
      dir2 == :inc && dir == :dec -> false

      # is decreasing but direction is increasing
      dir2 == :dec && dir == :inc -> false

      # is increasing or decreasing in the right amount
      true -> safe?([l2 | levels], dir2)
    end
  end

  defp safe?([_], _dir), do: true
  defp safe?([], _dir), do: true

  def part_one(input) do
    input
      |> parse()
      |> Enum.count(&safe?/1)
  end

  # brute force is good enough
  defp safe_with_dampner?(levels, l2 \\ [])
  defp safe_with_dampner?([l1 | levels], l2) do
    if safe?(l2 ++ levels) do
      true
    else
      safe_with_dampner?(levels, l2 ++ [l1])
    end
  end

  defp safe_with_dampner?([], _l2),
    do: false

  def part_two(input) do
    input
      |> parse()
      |> Enum.count(&safe_with_dampner?/1)
  end

end
