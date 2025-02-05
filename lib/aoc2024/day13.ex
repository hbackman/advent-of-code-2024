defmodule Aoc2024.Day13 do

  defp parse(input) do
    input
      |> Util.string_split_lines(2)
      |> Util.array_split_lines()
      |> Enum.map(&Enum.map(&1, fn m -> scan_nums(m) end))
  end

  defp scan_nums(string) do
    ~r/.*: X[\+=](\d+), Y[\+=](\d+)/
      |> Regex.run(string, capture: :all_but_first)
      |> Util.list_int_parse()
      |> List.to_tuple()
  end

  defp solve([{ax, ay}, {bx, by}, {px, py}]) do
    # We have the linear system:
    # `94a + 22b = 8400` = `ax*a + bx*b = px`
    # `34a + 67b = 5400` = `ay*a + by*b = py`
    #
    # where `a` and `b` are the number of button presses

    # We solve for one variable by expressing `a` in terms of `b`.
    #
    # `(34 * 94)a + (34 * 22)b = 34 * 8400` => `(ay*ax)*a + (ay*bx)*b = ay * px`
    # `(94 * 34)a + (94 * 67)b = 94 * 5400` => `(ax*ay)*a + (ax*by)*b = ax * py`

    # Now subtract the equations.
    #
    #    `(34 * 22 - 94 * 67)b = 34 * 8400 - 94 * 5400`
    # => `(ay*bx - ax*by)b = ay*px - ax*py`

    # Solve for `b`
    b = (ay*px - ax*py) / (ay*bx - ax*by)

    # Solve for `a`
    #
    #    `ax*a + bx*b = px`
    # => `ax*a + bx*40 = px`
    # => `a = (px-bx*40)/ax`
    a = (px - bx * b) / ax

    # Calculate cost
    c = (a * 3) + (b * 1)

    # The cost will be an integer if there is a solvable solution. If it is
    # not an integer, return zero instead.
    if c == trunc(c), do: trunc(c), else: 0
  end

  def part_one(input) do
    input
      |> parse()
      |> Enum.map(&solve/1)
      |> Enum.sum()
  end

  def part_two(input) do
    input
      |> parse()
      |> Enum.map(fn [a, b, {px, py}] ->
          [a, b, {px + 10000000000000, py + 10000000000000}]
        end)
      |> Enum.map(&solve/1)
      |> Enum.sum()
  end

end
