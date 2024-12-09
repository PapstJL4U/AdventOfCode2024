defmodule Day3 do
  @example "mul(123,456)"
  @mul ~r/mul\(\d{1,3},\d{1,3}\)/
  @muldos ~r/mul\(\d{1,3},\d{1,3}\)|do\(\)|don't\(\)/
  def main() do
    input = Adventfile.get_simple_input()

    Regex.scan(@muldos, input, return: :binary)
    |> List.flatten()
    # |> IO.inspect()
    |> dos([])
    |> Enum.map(&multiply(&1))
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

  @spec dos(list(String.t()), list(String.t())) :: list(String.t())
  def dos([], acc), do: acc

  def dos([head | tail], acc) do
    case head do
      "do()" -> dos(tail, acc)
      "don't()" -> dont(tail, acc)
      _ -> dos(tail, [head | acc])
    end
  end

  @spec dont(list(String.t()), list(String.t())) :: list(String.t())
  def dont([], acc), do: acc

  def dont([head | tail], acc) do
    case head do
      "do()" -> dos(tail, acc)
      _ -> dont(tail, acc)
    end
  end
end
