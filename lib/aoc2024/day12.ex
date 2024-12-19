defmodule Aoc2024.Day12 do

  defp scan(map = %Matrix{}, {x, y}, target) do
    scan(MapSet.new(), map, {x, y}, target)
      |> MapSet.to_list()
  end

  defp scan(visited, map, {x, y}, target) do
    if valid?(map, {x, y}, target, visited) do
      visited = MapSet.put(visited, {x, y})

      visited
        |> scan(map, {x, y-1}, target) # north
        |> scan(map, {x, y+1}, target) # south
        |> scan(map, {x-1, y}, target) # west
        |> scan(map, {x+1, y}, target) # east
    else
      visited
    end
  end

  defp valid?(map, {x, y}, target, visited) do
    Matrix.inside?(map, {x, y}) and
    Matrix.get(map, {x, y}) == target and
    not MapSet.member?(visited, {x, y})
  end

  defp perimeter(nodes) do
    set = MapSet.new(nodes)

    Enum.reduce(nodes, 0, fn {x, y}, p ->
      p + edges({x, y}, set)
    end)
  end

  defp edges({x, y}, node_set) do
    [
      {x, y-1}, # north
      {x, y+1}, # south
      {x-1, y}, # west
      {x+1, y}, # east
    ] |> Enum.count(fn n ->
        not MapSet.member?(node_set, n)
      end)
  end

  defp area(nodes) do
    Enum.count(nodes)
  end

  def part_one(input) do
    map = Matrix.from(input)

    map
      |> Matrix.to_map()
      |> Map.to_list()
      |> Enum.reduce([], fn {pos, seed}, areas ->
          scanned = areas
            |> Enum.map(&elem(&1, 1))
            |> List.flatten()
            |> Enum.member?(pos)

          # avoid re-scanning already scanned positions
          if not scanned,
            do: [{seed, scan(map, pos, seed)} | areas],
            else: areas
        end)
      |> Enum.map(fn {seed, nodes} -> {seed, area(nodes), perimeter(nodes)} end)
      |> Enum.map(fn {_, a, p} -> a * p end)
      |> Enum.sum()
  end

end
