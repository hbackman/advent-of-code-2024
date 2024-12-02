defmodule Aoc2024.Day01Test do
  use ExUnit.Case, async: true

  alias Aoc2024.Day01

  @input [:code.priv_dir(:aoc2024), "day01.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day01.part_one(@input) == 1603498
  end

  describe "part two" do
    assert Day01.part_two(@input) == 25574739
  end

end
