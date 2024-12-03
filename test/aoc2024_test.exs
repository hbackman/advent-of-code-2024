defmodule Aoc2024Test do
  use ExUnit.Case

  doctest Aoc2024
  doctest Util

  defp load_input(input) do
    [:code.priv_dir(:aoc2024), input]
      |> Path.join()
      |> File.read!()
  end

  test "day01" do
    input = load_input("day01.txt")

    assert Aoc2024.Day01.part_one(input) == 1603498
    assert Aoc2024.Day01.part_two(input) == 25574739
  end

  test "day02" do
    input = load_input("day02.txt")

    assert Aoc2024.Day02.part_one(input) == 526
    assert Aoc2024.Day02.part_two(input) == 566
  end

  test "day03" do
    input = load_input("day03.txt")

    # assert Aoc2024.Day03.part_one(input) == 188116424
    IO.inspect Aoc2024.Day03.part_two(input)
  end
end
