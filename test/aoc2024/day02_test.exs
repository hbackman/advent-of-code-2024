defmodule Aoc2024.Day02Test do
  use ExUnit.Case, async: true

  alias Aoc2024.Day02

  @input [:code.priv_dir(:aoc2024), "day02.txt"]
    |> Path.join()
    |> File.read!()

  describe "part one" do
    assert Day02.part_one(@input) == 526
  end

  describe "part two" do
    assert Day02.part_two(@input) == 566
  end

end
