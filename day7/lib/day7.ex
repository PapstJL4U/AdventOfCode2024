defmodule Day7 do
  import Combinatorics

  @example """
           190: 10 19
           3267: 81 40 27
           83: 17 5
           156: 15 6
           7290: 6 8 6 15
           161011: 16 10 13
           192: 17 8 14
           21037: 9 7 18 13
           292: 11 6 16 20
           """
           |> String.split("\n")

  def main() do
    # Adventfile.get_file()
    # @example
    input =
      Adventfile.get_file()
      |> Enum.reject(&(&1 == ""))
      |> Enum.map(&sol_equ/1)
      |> Enum.map(fn {sol, equ, i} -> {sol, equ, bin_combinations(i)} end)
      |> Enum.map(fn {sol, equ, combs} -> {sol, Enum.map(combs, fn x -> combine(equ, x) end)} end)
      |> Enum.map(fn {sol, combs} ->
        {sol, Enum.map(combs, fn x -> is_solution?(x, sol) end)}
      end)
      |> Enum.map(fn {sol, combs} ->
        {sol, Enum.any?(combs, fn x -> x == true end)}
      end)
      |> Enum.reject(fn {_, bool} -> bool == false end)
      |> Enum.map(fn {val, _} -> val end)
      |> Enum.sum()
  end

  @spec sol_equ(String.t()) :: {integer(), list(integer()), integer()}
  def sol_equ(line) do
    [head | tail] =
      line
      |> String.split(":", trim: true)

    head = String.to_integer(head)

    tail =
      tail
      |> Enum.at(0)
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

    {head, tail, Enum.count(tail) - 1}
  end

  @spec bin_combinations(integer()) :: list(list(String.t()))
  def bin_combinations(i) do
    List.duplicate(["*", "+"], i) |> product()
  end

  @spec combine(list(integer()), list(String.t())) :: list()
  def combine(ints, []), do: List.wrap(ints)
  def combine([], _), do: []

  def combine([hi | ti], [ho | to]) do
    [hi, ho | combine(ti, to)]
  end

  @spec is_solution?(list(), integer()) :: boolean()
  def is_solution?([acc], sol), do: sol == acc

  def is_solution?([op1, op, op2 | tail], sol) do
    a =
      case op do
        "*" -> op1 * op2
        "+" -> op1 + op2
      end

    if(a > sol) do
      false
    else
      is_solution?([a | tail], sol)
    end
  end
end
