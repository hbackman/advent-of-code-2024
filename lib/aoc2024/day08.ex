defmodule Aoc2024.Day08 do

  def antennas(matrix) do
    matrix
      |> Matrix.positions()
      |> Enum.map(& {&1, Matrix.get(matrix, &1)})
      |> Enum.reject(fn {_, c} -> c == "." end)
  end

  def part_one(input) do
    matrix = Matrix.from(input)

    antennas = antennas(matrix)

    Enum.reduce(antennas, matrix, fn a = {{x, y}, f}, mat ->

      same_frequency = antennas
        |> Enum.reject(& &1 == a)
        |> Enum.filter(& elem(&1, 1) == f)
        # distances
        |> Enum.map(fn {x2, y2, _} ->
          # find distances, then place antinodes on 2x distance
        end)

      mat

    end)

    :ok
  end

end
