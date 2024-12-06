defmodule Aoc2024.Day05 do

  defp parse(input) do
    [rules, stacks] = input
      |> Util.string_split_lines(2)
      |> Util.array_split_lines()

    rules = rules
      |> Enum.map(&String.split(&1, "|", trim: true))
      |> Enum.map(fn v -> Enum.map(v, &String.to_integer/1) end)
      |> Enum.group_by(fn [a, _] -> a end, fn [_, b] -> b end)

    stacks = stacks
      |> Enum.map(&Util.string_to_int_list(&1, ","))

    {rules, stacks}
  end

  defp order(stack, rules) do
    Enum.sort(stack, fn a, b ->
      rules
        |> Map.get(a, [])
        |> Enum.member?(b)
    end)
  end

  defp middle(stack) do
    Enum.at(stack, div(length(stack), 2))
  end

  def part_one(input) do
    {rules, stacks} = parse(input)

    stacks
      |> Enum.filter(fn stack -> stack == order(stack, rules) end)
      |> Enum.map(&middle/1)
      |> Enum.sum()
  end

  def part_two(input) do
    {rules, stacks} = parse(input)

    stacks
      |> Enum.map(fn stack -> {stack, order(stack, rules)} end)
      |> Enum.filter(fn {s1, s2} -> s1 != s2 end)
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(&middle/1)
      |> Enum.sum()
  end

end
