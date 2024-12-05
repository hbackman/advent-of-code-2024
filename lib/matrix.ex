defmodule Matrix do

  alias __MODULE__

  defstruct [
    :data,
    :w,
    :h,
  ]

  @doc """
  Create a new matrix with given dimensions.
  """
  def make(width, height, default \\ nil) do
    from(
      for _ <- 1..height do
      for _ <- 1..width do
        default
      end end
    )
  end

  def from(list) when is_list(list) do
    %__MODULE__{
      data: list_to_matrix(list),
      w: Enum.count(List.first(list)),
      h: Enum.count(list),
    }
  end

  def from(list) when is_bitstring(list) do
    list
      |> String.split(~r/\R/, trim: true)
      |> Enum.map(&String.split(&1, "", trim: true))
      |> from()
  end

  defp list_to_matrix(list) when is_list(list) do
    {map, _} = Enum.reduce(list, {%{}, 0}, fn i, {map, index} ->
      {put_in(map[index], list_to_matrix(i)), index + 1}
    end)
    map
  end

  defp list_to_matrix(list), do: list

  @doc """
  Convert a matrix into a 2d list.
  """
  def to_list(matrix = %Matrix{}) do
    matrix_to_list(matrix.data)
  end

  defp matrix_to_list(map) when is_map(map) do
    map
      |> Enum.reduce([], fn {_index, value}, acc ->
        [matrix_to_list(value) | acc]
      end)
      |> Enum.reverse()
  end

  defp matrix_to_list(map), do: map

  @doc """
  Put a value in the matrix.
  """
  def put(matrix = %Matrix{}, x, y, value) do
    put_in(matrix.data[y][x], value)
  end

  def put(matrix = %Matrix{}, {x, y}, value),
    do: put(matrix, x, y, value)

  @doc """
  Get a value from the matrix.
  """
  def get(matrix = %Matrix{}, x, y) do
    matrix.data[y][x]
  end

  def get(matrix = %Matrix{}, {x, y}),
    do: get(matrix, x, y)

  @doc """
  Transpose the matrix.
  """
  def transpose(matrix = %Matrix{}) do
    matrix
      |> Matrix.to_list()
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)
      |> Matrix.from()
  end

  @doc """
  Get the x-axis range.
  """
  def x_range(matrix = %Matrix{}), do: 0..(matrix.w-1)

  @doc """
  Get the y-axis range.
  """
  def y_range(matrix = %Matrix{}), do: 0..(matrix.h-1)

end
