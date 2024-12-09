defmodule Day3 do
  alias Adventfile
  @example "mul(123,456)"
  @mul ~r/mul\(\d{1,3},\d{1,3}\)/
  @muldos ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
  def main() do
    input = Adventfile.get_simple_input()

    Regex.scan(@muldos, input, return: :binary)
    |> List.flatten()
    |> IO.inspect()
    |> dodont(true, [])
    |> Enum.map(fn x -> multiply(x) end)
    |> Enum.sum()
  end

  @spec multiply(String.t()) :: integer()
  def multiply(input) do
    i_inputs =
      input
      # |> List.first()
      |> String.trim("mul(")
      |> String.trim(")")
      |> String.split(",")

    a = i_inputs |> List.first() |> String.to_integer()
    b = i_inputs |> List.last() |> String.to_integer()
    a * b
  end

  @spec dodont(list(String.t()), boolean(), list(String.t())) :: list(String.t())
  def dodont([], _, acc), do: acc

  def dodont([head | tail], true, acc) do
    case head do
      "do()" -> dodont(tail, true, acc)
      "don't()" -> dodont(tail, false, acc)
      _ -> dodont(tail, true, [head | acc])
    end
  end

  def dodont([head | tail], false, acc) do
    case head do
      "do()" -> dodont(tail, true, acc)
      "don't()" -> dodont(tail, false, acc)
      _ -> dodont(tail, false, acc)
    end
  end
end
