defmodule Aoc2024.Day06 do

  defp find_guard(matrix) do
    positions =
      for y <- Matrix.y_range(matrix),
          x <- Matrix.x_range(matrix),
          do: {x, y}

    Enum.find_value(positions, fn {x, y} ->
      case Matrix.get(matrix, {x, y}) do
        "^" -> {x, y, "^"}
        "v" -> {x, y, "v"}
        "<" -> {x, y, "<"}
        ">" -> {x, y, ">"}
        _   -> false
      end
    end)
  end

  defp move(map) do
    {gx, gy, gdir} = find_guard(map)

    {nx, ny} = next({gx, gy, gdir})

    {nx, ny, ndir} = case Matrix.get(map, {nx, ny}) do
      "#" -> turn(gx, gy, gdir)
      _   -> {nx, ny, gdir}
    end

    if Matrix.inside?(map, {nx, ny}) do
      map = map
        |> Matrix.put({gx, gy}, "X")
        |> Matrix.put({nx, ny}, ndir)
      {:cont, map}
    else
      map = map
        |> Matrix.put({gx, gy}, "X")
      {:halt, map}
    end
  end

  defp simulate(map) do
    case move(map) do
      {:cont, map} -> simulate(map)
      {:halt, map} -> map
    end
  end

  defp positions(map) do
    positions =
      for y <- Matrix.y_range(map),
          x <- Matrix.x_range(map),
          do: {x, y}

    Enum.count(positions, fn {x, y} ->
      case Matrix.get(map, {x, y}) do
        "X" -> true
        _   -> false
      end
    end)
  end

  defp next({x, y, "^"}), do: {x, y - 1}
  defp next({x, y, "v"}), do: {x, y + 1}
  defp next({x, y, "<"}), do: {x - 1, y}
  defp next({x, y, ">"}), do: {x + 1, y}

  defp turn(x, y, "^"), do: {x + 1, y, ">"}
  defp turn(x, y, "v"), do: {x - 1, y, "<"}
  defp turn(x, y, "<"), do: {x, y - 1, "^"}
  defp turn(x, y, ">"), do: {x, y + 1, "v"}

  def part_one(input) do
    input
      |> Matrix.from()
      |> simulate()
      |> Matrix.inspect()
      |> positions()
  end

end
