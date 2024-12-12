defmodule Aoc2024.Day07 do

  defp parse_line(line) do
    [result | inputs] = line
      |> String.split([": ", " "], trim: true)
      |> Util.list_int_parse()
    {result, inputs}
  end

  defp gen_eq([], total, _), do: [total]
  defp gen_eq([a | rest], total, ops) do
    Enum.flat_map(ops, fn
      "+"  -> gen_eq(rest, total + a, ops)
      "*"  -> gen_eq(rest, total * a, ops)
      "||" -> gen_eq(rest, String.to_integer("#{total}#{a}"), ops)
    end)
  end

  defp valid?({result, inputs}, ops) do
    gen_eq(
      tl(inputs),
      hd(inputs),
      ops
    ) |> Enum.member?(result)
  end

  defp exec(input, ops) do
    input
      |> Util.string_split_lines()
      |> Enum.map(&parse_line/1)
      |> Enum.filter(&valid?(&1, ops))
      |> Enum.map(&elem(&1, 0))
      |> Enum.sum()
  end

  def part_one(input) do
    exec(input, ["+", "*"])
  end

  def part_two(input) do
    exec(input, ["+", "*", "||"])
  end

end
