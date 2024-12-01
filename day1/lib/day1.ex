defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day1.hello()
      :world

  """
  def hello do
    :world
  end

  @spec sum_lists(list(integer()), list(integer()), integer()) :: integer()
  def sum_lists(a, b, acc \\ 0)
  def sum_lists([], _, _), do: 0
  def sum_lists(_, [], _), do: 0

  def sum_lists(a, b, acc) do
    {f, apop} = List.pop_at(a, 0)
    {s, bpop} = List.pop_at(b, 0)
    acc = acc + abs(f - s)
    sum_lists(apop, bpop, acc)
  end
end
