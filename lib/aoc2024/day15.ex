defmodule Aoc2024.Day15 do

  defp parse(input) do
    [m, i] = String.split(input, "\n\n", trim: true)

    m = Matrix.from(m)
    i = i
      |> String.replace("\n", "")
      |> String.split("", trim: true)

    {m, i}
  end

  defp next({x, y}, i) do
    case i do
      "^" -> {x, y - 1}
      "v" -> {x, y + 1}
      "<" -> {x - 1, y}
      ">" -> {x + 1, y}
    end
  end

  defp push(m, {x, y}, dir) do
    {cx, cy} = {x, y}
    {nx, ny} = next({cx, cy}, dir)

    case Matrix.get(m, {nx, ny}) do
      "#" -> {m, false}
      "." -> {Matrix.put(m, {nx, ny}, "O"), true}
      "O" -> push(m, {nx, ny}, dir)
    end
  end

  defp apply({m, []}), do: m
  defp apply({m, [i | rest]}) do
    {cx, cy} = Matrix.find(m, & &1 == "@")
    {nx, ny} = next({cx, cy}, i)

    m = case Matrix.get(m, {nx, ny}) do
      "." -> m
        |> Matrix.put({cx, cy}, ".")
        |> Matrix.put({nx, ny}, "@")
      "#" -> m
      "O" ->
        {m, f} = push(m, {nx, ny}, i)

        if f,
          do: m
            |> Matrix.put({cx, cy}, ".")
            |> Matrix.put({nx, ny}, "@"),
          else: m
    end

    # debug
    # Matrix.inspect(m)
    # IO.puts i
    # IO.puts " "

    apply({m, rest})
  end

  defp gps(m) do
    Matrix.filter(m, & &1 == "O")
      |> Enum.map(fn {x, y} -> y * 100 + x end)
      |> Enum.sum()
  end

  def part_one(input) do
    input
      |> parse()
      |> apply()
      |> gps()
  end

  def part_two(input) do

  end

end
