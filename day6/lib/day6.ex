defmodule Day6 do
  @example """
           ....#.....
           .........#
           ..........
           ..#.......
           .......#..
           ..........
           .#..^.....
           ........#.
           #.........
           ......#...
           """
           |> String.split("\n")

  @type guard :: :^ | :< | :> | :v
  def main() do
    input = @example
  end

  @spec str_to_guard!(String.t()) :: guard
  def str_to_guard!(str) do
    case str do
      "^" -> :^
      "<" -> :<
      ">" -> :>
      "v" -> :v
      _ -> raise "Not a guard!"
    end
  end

  @spec str_to_guard(String.t()) :: {:ok, guard} | {:err, String.t()}
  def str_to_guard(str) do
    case str do
      "^" -> {:ok, :^}
      "<" -> {:ok, :<}
      ">" -> {:ok, :>}
      "v" -> {:ok, :v}
      _ -> raise {:err, "Not a guard!"}
    end
  end
end
