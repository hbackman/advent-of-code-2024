defmodule Aoc2024.Day11 do

  defp even_digits?(0), do: false
  defp even_digits?(n) do
    n
      |> :math.log10()
      |> floor()
      |> Kernel.+(1)
      |> rem(2)
      == 0
  end

  defp split_digits(0), do: {0, 0}
  defp split_digits(n) do
    divisor = n
      |> :math.log10()
      |> floor()
      |> Kernel.+(1)
      |> div(2)
      |> (&:math.pow(10, &1)).()
      |> round()

    l = div(n, divisor)
    r = rem(n, divisor)

    {l, r}
  end

  defp blink(input, output \\ [])
  defp blink([], output), do: Enum.reverse(output)
  defp blink([stone | rest], output) do
    cond do
      stone == 0 ->
        blink(rest, [1 | output])

      even_digits?(stone) ->
        {l, r} = split_digits(stone)
        blink(rest, [r, l | output])

      true ->
        blink(rest, [stone * 2024 | output])
    end
  end

  def part_one(input) do
    stones = Util.string_to_int_list(input)

    1..25
      |> Enum.reduce(stones, fn _, s -> blink(s) end)
      |> Enum.count()
  end

  defp smart_blink(input) do
    input
      |> Map.to_list()
      |> Enum.reduce(%{}, fn {stone, count}, counts ->
          cond do
            stone == 0 ->
              counts
                |> Map.update(stone + 1, count, &(&1 + count))

            even_digits?(stone) ->
              {l, r} = split_digits(stone)
              counts
                |> Map.update(l, count, &(&1 + count))
                |> Map.update(r, count, &(&1 + count))

            true ->
              counts
                |> Map.update(stone * 2024, count, &(&1 + count))
          end
        end)
  end

  def part_two(input) do
    stones = input
      |> Util.string_to_int_list()
      |> Enum.reduce(%{}, &Map.put(&2, &1, 1))

    1..75
      |> Enum.reduce(stones, fn _, s -> smart_blink(s) end)
      |> Map.values()
      |> Enum.sum()
  end

end
