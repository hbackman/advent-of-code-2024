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

   Enum.reduce(antennas, [], fn a = {{x, y}, f}, antinodes ->
     local = antennas
       |> Enum.reject(& &1 == a)
       |> Enum.filter(& elem(&1, 1) == f)
       |> Enum.map(fn {{x2, y2}, _} ->
         # find distances, then place antinodes on 2x distance
         {x2 + ((x - x2) * 2), y2 + ((y - y2) * 2)}
       end)
       |> Enum.reject(fn p -> Matrix.inside?(matrix, p) == false end)
     local ++ antinodes
   end)
     |> Enum.uniq()
     |> Enum.count()
  end

  defp gen_many_antinodes(matrix, {x, y}, {dx, dy}, n, nodes \\ []) do
    {nx, ny} = {x + dx * n,  y + dy * n}
    if Matrix.inside?(matrix, {nx, ny}) do
      gen_many_antinodes(matrix, {x, y}, {dx, dy}, n + 1, [{nx, ny} | nodes])
    else
      nodes
    end
  end

  #defp draw(antinodes, matrix) do
  #  antinodes
  #    |> Enum.reduce(matrix, fn p, m -> Matrix.put(m, p, "#") end)
  #    |> Matrix.inspect()
  #  antinodes
  #end

  def part_two(input) do
    matrix = Matrix.from(input)
    points = antennas(matrix)

    Enum.reduce(points, [], fn a = {{x, y}, f}, antinodes ->
      local = points
        |> Enum.reject(& &1 == a)
        |> Enum.filter(& elem(&1, 1) == f)
        |> Enum.flat_map(fn {{x2, y2}, _} ->
          gen_many_antinodes(matrix, {x2, y2}, {x - x2, y - y2}, 1)
        end)
      local ++ antinodes
    end)
      |> Enum.uniq()
      |> Enum.count()
  end

end
