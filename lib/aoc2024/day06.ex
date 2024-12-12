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

  defp next({x, y, "^"}), do: {x, y-1}
  defp next({x, y, "v"}), do: {x, y+1}
  defp next({x, y, "<"}), do: {x-1, y}
  defp next({x, y, ">"}), do: {x+1, y}

  defp move(room, {x, y, dir}) do
    {nx, ny} = next({x, y, dir})

    if Matrix.inside?(room, nx, ny) do
      pos = case Matrix.get(room, nx, ny) do
        "." -> {nx, ny, dir}
        "#" -> case dir do
          "^" -> {x, y, ">"}
          "v" -> {x, y, "<"}
          "<" -> {x, y, "^"}
          ">" -> {x, y, "v"}
        end
      end
      {:cont, pos}
    else
      {:halt}
    end
  end

  defp walk(room, {x, y, dir}, visited) do
    if MapSet.member?(visited, {x, y, dir}) do
      :inf
    else
      case move(room, {x, y, dir}) do
        {:cont, {nx, ny, ndir}} ->
          walk(room, {nx, ny, ndir}, MapSet.put(visited, {x, y, dir}))
        {:halt} ->
          visited
            |> MapSet.put({x, y, dir})
            |> MapSet.to_list()
      end
    end
  end

  defp get_guard_path(room) do
    {gx, gy, dir} = find_guard(room)

    room
      |> Matrix.put({gx, gy}, ".")
      |> walk({gx, gy, dir}, MapSet.new())
  end

  def part_one(input) do
    input
      |> Matrix.from()
      |> get_guard_path()
      |> Enum.map(fn {x, y, _} -> {x, y} end)
      |> Enum.uniq()
      |> Enum.count()
  end

  def part_two(input) do
    room = Matrix.from(input)

    {gx, gy, _} = find_guard(room)

    get_guard_path(room)
      |> Enum.map(fn {x, y, _} -> {x, y} end)
      |> Enum.uniq()
      |> Enum.reject(& &1 == {gx, gy})
      # create "room" for each obstacle
      |> Enum.map(& Matrix.put(room, &1, "#"))
      # create async tasks for solving loops
      |> Enum.map(fn room ->
          Task.async(fn ->
            if get_guard_path(room) == :inf, do: 1, else: 0
          end)
        end)
      # await and sum
      |> Enum.map(&Task.await/1)
      |> Enum.sum()
  end

end
