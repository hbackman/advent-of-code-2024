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
    [{x, y-1}, {x, y+1}, {x-1, y}, {x+1, y}]
      |> Enum.filter(& not MapSet.member?(node_set, &1))
  end

  defp area(nodes) do
    Enum.count(nodes)
  end

  defp solve(map = %Matrix{}) do
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
  end

  def part_one(input) do
    input
      |> Matrix.from()
      |> solve()
      |> Enum.map(fn {seed, nodes} -> {seed, area(nodes), perimeter(nodes)} end)
      |> Enum.map(fn {_, a, p} -> a * p end)
      |> Enum.sum()
  end

  defp sides(map, nodes, chr) do
    set = MapSet.new(nodes)

    IO.puts "------------------ #{chr} ------------------"
    Matrix.map(map, fn ch, {x, y} ->
      if Enum.member?(nodes, {x, y}) do
        ch
      else
        "."
      end
    end) |> Matrix.inspect()

    IO.puts ""

    Enum.reduce(nodes, 0, fn {x, y}, s ->
      s + case edges({x, y}, set) do
        v -> 0
      end
    end)
  end

  # M:  5 *  6 = 30
  # C:  1 *  4 = 4
  # S:  3 *  6 = 18
  # F: 10 * 12 = 120
  # C: 14 * 22 = 308
  # J: 11 * 12 = 132
  # I:  4 *  4 = 16
  # I: 14 * 16 = 224
  # R: 12 * 10 = 120
  # E: 13 *  8 = 104
  # V: 13 * 10 = 130

  def part_two(input) do
    map = Matrix.from(input)
    input
      |> Matrix.from()
      |> solve()
      |> Enum.map(fn {seed, nodes} -> {seed, area(nodes), sides(map, nodes, seed)} end)
      |> Enum.map(fn {seed, a, b} -> {seed, a, b} end)
      |> Enum.each(fn {seed, a, b} ->
          aa = String.pad_leading("#{a}", 2, " ")
          bb = String.pad_leading("#{b}", 2, " ")

          IO.puts "#{seed}:   #{aa} * #{bb} = #{a*b}"
        end)
  end

end
