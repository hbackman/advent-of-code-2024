defmodule Mix.Tasks.GenDay do
  use Mix.Task

  @shortdoc "Generate boilerplate for a new day of Advent of Code."

  def run([day | _rest]) do
    day = String.pad_leading(day, 2, "0")

    if ! File.exists?(module_path(day)) do
      File.write!(module_path(day), module_template(day))
      File.write!(input_path(day), "")

      Mix.shell().info("Generated files for Day #{day}.")
    else
      Mix.shell().error("Files for day #{day} already exists.")
    end
  end

  defp module_path(day), do: "lib/aoc2024/day#{day}.ex"
  defp input_path(day), do: "priv/day#{day}.txt"

  defp module_template(day) do
    """
    defmodule Aoc2024.Day#{day} do

      def part_one(input) do
        # Part one logic here.
      end

      def part_two(input) do
        # Part two logic here.
      end

    end
    """
  end
end
