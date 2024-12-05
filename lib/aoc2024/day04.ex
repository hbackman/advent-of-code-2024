defmodule Aoc2024.Day04 do

  defp find_xmas_maybes(matrix, target) do
    positions =
      for y <- Matrix.y_range(matrix),
          x <- Matrix.x_range(matrix),
          do: {x, y}

    Enum.filter(positions, fn pos ->
      case Matrix.get(matrix, pos) do
        ^target -> true
        _       -> false
      end
    end)
  end

  defp find_xmas_strings(positions, matrix, n \\ 0)
  defp find_xmas_strings([{x, y} | rest], matrix, n) do
    found = [
      # linear
      [{0, 0}, {+1, +0}, {+2, +0}, {+3, +0}],
      [{0, 0}, {-1, +0}, {-2, +0}, {-3, +0}],
      [{0, 0}, {+0, +1}, {+0, +2}, {+0, +3}],
      [{0, 0}, {+0, -1}, {+0, -2}, {+0, -3}],
      # diagonal
      [{0, 0}, {+1, +1}, {+2, +2}, {+3, +3}],
      [{0, 0}, {-1, -1}, {-2, -2}, {-3, -3}],
      [{0, 0}, {+1, -1}, {+2, -2}, {+3, -3}],
      [{0, 0}, {-1, +1}, {-2, +2}, {-3, +3}],
    ] |> Enum.count(fn cords ->
        cords
          |> Enum.map(fn {xd, yd} -> Matrix.get(matrix, {x + xd, y + yd}) end)
          |> Enum.join()
          == "XMAS"
      end)

    find_xmas_strings(rest, matrix, n + found)
  end

  defp find_xmas_strings([], _matrix, n), do: n

  def part_one(input) do
    matrix = Matrix.from(input)

    matrix
      |> find_xmas_maybes("X")
      |> find_xmas_strings(matrix)
  end

  defp find_x_max_strings(positions, matrix, n \\ 0)
  defp find_x_max_strings([{x, y} | rest], matrix, n) do
    found = [
      # M.S    S.M    M.M    S.S
      # .A. -> .A. -> .A. -> .A.
      # M.S    S.M    S.S    M.M
      [{-1, -1}, {0, 0}, {+1, +1}, {-1, +1}, {0, 0}, {+1, -1}],
      [{+1, +1}, {0, 0}, {-1, -1}, {+1, -1}, {0, 0}, {-1, +1}],
      [{-1, -1}, {0, 0}, {+1, +1}, {+1, -1}, {0, 0}, {-1, +1}],
      [{-1, +1}, {0, 0}, {+1, -1}, {+1, +1}, {0, 0}, {-1, -1}],
    ] |> Enum.count(fn cords ->
        cords
          |> Enum.map(fn {xd, yd} -> Matrix.get(matrix, {x + xd, y + yd}) end)
          |> Enum.join()
          == "MASMAS"
      end)

    find_x_max_strings(rest, matrix, n + found)
  end

  defp find_x_max_strings([], _matrix, n), do: n

  def part_two(input) do
    matrix = Matrix.from(input)

    matrix
      |> find_xmas_maybes("A")
      |> find_x_max_strings(matrix)
  end

end
