defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @fpath "./inputs/day1.txt"
  @spec sum_lists(list(integer()), list(integer()), integer()) :: integer()
  defp sum_lists(a, b, acc \\ 0)
  defp sum_lists([], _, acc), do: acc
  defp sum_lists(_, [], acc), do: acc

  defp sum_lists(a, b, acc) do
    {f, apop} = List.pop_at(a, 0)
    {s, bpop} = List.pop_at(b, 0)
    acc = acc + abs(f - s)
    sum_lists(apop, bpop, acc)
  end

  def main do
    IO.puts(@fpath)
    IO.puts(File.exists?(@fpath))

    case File.read(@fpath) do
      {:ok, value} ->
        {total_dist, sim} =
          raw_input(value)

        IO.puts("#{total_dist} :: #{sim}")

      {:error, reasons} ->
        IO.puts(reasons)
    end
  end

  @spec raw_input(binary()) :: {integer(), integer()}
  defp raw_input(value) do
    {left, right} =
      String.split(value, "\n", trim: true)
      |> Enum.map(&line_to_integer(&1))
      |> Enum.unzip()

    left = Enum.sort(left, :asc)
    right = Enum.sort(right, :asc)
    td = sum_lists(left, right)

    sim =
      Enum.zip(left, left_in_right(left, right))
      |> Enum.map(fn {l, c} -> l * c end)
      |> Enum.sum()

    {td, sim}
  end

  @spec line_to_integer(binary()) :: {integer(), integer()}
  defp line_to_integer(line) do
    [first, second] = String.split(line, ~r/\s/, trim: true)
    # IO.inspect("#{String.to_integer(first)} :: #{String.to_integer(second)}")
    {String.to_integer(first), String.to_integer(second)}
  end

  @spec left_in_right(list(), list()) :: list(integer())
  defp left_in_right(left, right) do
    Enum.map(left, fn l -> Enum.count(right, fn r -> r == l end) end)
  end
end
