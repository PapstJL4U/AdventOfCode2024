defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @fpath "./inputs/day1.txt"
  @spec sum_lists(list(integer()), list(integer()), integer()) :: integer()
  defp sum_lists(a, b, acc \\ 0)
  defp sum_lists([], _, _), do: 0
  defp sum_lists(_, [], _), do: 0

  defp sum_lists(a, b, acc) do
    {f, apop} = List.pop_at(a, 0)
    {s, bpop} = List.pop_at(b, 0)
    acc = acc + abs(f - s)
    sum_lists(apop, bpop, acc)
  end

  def path(), do: @fpath

  def main do
    IO.puts(@fpath)
    IO.puts(File.exists?(@fpath))

    case File.read(@fpath) do
      {:ok, value} ->
        raw_input(value)
        |> IO.puts()

      {:error, reasons} ->
        IO.puts(reasons)
    end
  end

  @spec raw_input(binary()) :: list(integer())
  defp raw_input(value) do
    String.split(value, "\n")
    |> Enum.each(&line_to_integer(&1))

    [0]
  end

  @spec line_to_integer(binary()) :: {integer(), integer()}
  defp line_to_integer(line) do
    [first, second, _] = String.split(line, ~r/\s/, trim: true)

    {String.to_integer(first), String.to_integer(second)}
  end
end
