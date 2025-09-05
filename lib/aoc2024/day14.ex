defmodule Aoc2024.Day14 do

  defp parse(input) do
    ~r/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/
      |> Regex.scan(input, capture: :all_but_first)
      |> Enum.map(&Util.list_int_parse/1)
      |> Enum.map(&List.to_tuple/1)
  end

  defp tick(guards, _matrix, 0) do
    guards
  end

  defp tick(guards, matrix, times) do
    guards = Enum.map(guards, fn {x, y, vx, vy} ->
      nx = x + vx
      ny = y + vy

      nx = rem(nx + matrix.w, matrix.w)
      ny = rem(ny + matrix.h, matrix.h)

      {nx, ny, vx, vy}
    end)

    tick(guards, matrix, times - 1)
  end

#  defp print(guards, matrix) do
#    matrix
#      |> Matrix.map(fn ch, {x, y} ->
#        count = Enum.count(guards, fn {x2, y2, _, _} -> x == x2 && y == y2 end)
#
#        if count > 0, do: count, else: ch
#      end)
#      |> Matrix.inspect
#  end

  defp calculate_safety_factor(guards, matrix) do
    mid_x = div(matrix.w, 2)
    mid_y = div(matrix.h, 2)

    quadrants = guards
      |> Enum.reject(fn {x, y, _, _} -> x == mid_x || y == mid_y end)
      |> Enum.group_by(fn {x, y, _, _} ->
        cond do
          x < mid_x && y < mid_y -> :tl
          x > mid_x && y < mid_y -> :tr
          x < mid_x && y > mid_y -> :bl
          x > mid_x && y > mid_y -> :br
        end
      end)

    [:tl, :tr, :bl, :br]
      |> Enum.map(&Map.get(quadrants, &1, []) |> length())
      |> Enum.reduce(1, &*/2)
  end

  def part_one(input) do
    guards = parse(input)
    matrix = Matrix.make(101, 103, ".")

    guards
      |> tick(matrix, 100)
      |> calculate_safety_factor(matrix)
  end

  defp no_overlaps?(guards) do
    p = Enum.map(guards, fn {x, y, _, _} -> {x, y} end)
    length(p) == length(Enum.uniq(p))
  end

  defp search(guards, matrix, n \\ 1) do
    guards = tick(guards, matrix, 1)

    if no_overlaps?(guards), do: n, else: search(guards, matrix, n + 1)
  end

  def part_two(input) do
    guards = parse(input)
    matrix = Matrix.make(101, 103, ".")

    # tree was found where no overlaps occurred
    search(guards, matrix)
  end

end
