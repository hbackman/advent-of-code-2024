defmodule Aoc2024.Day09 do

  defp parse(input) do
    input
      |> String.replace("\n", "")
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
  end

  defp repeat(string, times),
    do: List.duplicate(string, times)

  defp expand(input, mode \\ :f, index \\ 0, output \\ [])

  # expand in file mode
  defp expand([size | rest], :f, index, output),
    do: expand(rest, :e, index + 1, output ++ repeat("#{index}", size))

  # expand in empty mode
  defp expand([size | rest], :e, index, output),
    do: expand(rest, :f, index + 0, output ++ repeat(".", size))

  defp expand([], _mode, _index, output), do: output

  defp defrag(input),
    do: defrag(input, Enum.reverse(input))

  defp defrag(input, [head | tail]) do
    if head == "." do
      defrag(input, tail)
    else
      index1 = Enum.find_index(input, & &1 == ".")
      index2 = length(tail)

      result = input
        |> List.replace_at(index1, head)
        |> List.replace_at(index2, ".")

      # progress, kind of
      #if rem(length(tail), 100) == 0 do
      #  IO.puts "#{length(tail)} / #{length(input)}"
      #end

      if !(index2 >= index1) do
        #IO.write Enum.join(result)
        #IO.write " : "
        #IO.write Enum.join(input)
        #IO.write "\n"

        input
      else
        defrag(result, tail)
      end
    end
  end

  defp defrag(input, []) do
    input
  end

  defp checksum(filesystem) do
    filesystem
      |> Enum.with_index()
      |> Enum.reduce(0, fn
        {".", _ndex}, chk -> chk
        {chr, index}, chk -> chk + String.to_integer(chr) * index
      end)
  end

  def part_one(input) do
    input
      |> parse()
      |> expand()
      |> defrag()
      |> checksum()
  end

end
