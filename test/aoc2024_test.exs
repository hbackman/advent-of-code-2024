defmodule Aoc2024Test do
  use ExUnit.Case

  @moduletag timeout: :infinity

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

    assert Aoc2024.Day03.part_one(input) == 188116424
    assert Aoc2024.Day03.part_two(input) == 104245808
  end

  test "day04" do
    input = load_input("day04.txt")

    assert Aoc2024.Day04.part_one(input) == 2536
    assert Aoc2024.Day04.part_two(input) == 1875
  end

  test "day05" do
    input = load_input("day05.txt")

    assert Aoc2024.Day05.part_one(input) == 4774
    assert Aoc2024.Day05.part_two(input) == 6004
  end

  test "day06" do
    input = load_input("day06.txt")

    assert Aoc2024.Day06.part_one(input) == 5453
    assert Aoc2024.Day06.part_two(input) == 2188
  end

end
