defmodule Aoc2024.Day10 do

  defp neighbours({x, y}) do
    [
      {x-1, y},
      {x+1, y},
      {x, y-1},
      {x, y+1},
    ]
  end

  defp walk(map, [{x, y} | _] = path) do
    height = Matrix.get(map, {x, y})

    if height == 9 do
      {path}
    else
      neighbours({x, y})
        |> Enum.filter(& Matrix.inside?(map, &1))
        |> Enum.map(& {&1, Matrix.get(map, &1)})
        |> Enum.filter(& (elem(&1, 1)-1 == height))
        |> Enum.map(fn {pos, _} -> walk(map, [pos | path]) end)
        |> List.flatten()
    end
  end

  def part_one(input) do
    map = input
      |> Matrix.from()
      |> Matrix.map(&String.to_integer/1)

    Matrix.filter(map, &(&1 == 0))
      |> Enum.map(fn pos ->
          walk(map, [pos])
            |> Enum.map(&elem(&1, 0))
            |> Enum.map(&hd/1)
            |> Enum.uniq()
            |> Enum.count()
        end)
      |> Enum.sum()
  end

  def part_two(input) do
    map = input
      |> Matrix.from()
      |> Matrix.map(&String.to_integer/1)

    Matrix.filter(map, &(&1 == 0))
      |> Enum.map(fn pos ->
          walk(map, [pos])
            |> Enum.map(&elem(&1, 0))
            |> Enum.count()
        end)
      |> Enum.sum()
  end

end
