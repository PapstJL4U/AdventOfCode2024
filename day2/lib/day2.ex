defmodule Day2 do
  alias Adventfile

  @test """
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9
  """
  def main() do
    Adventfile.get_file()
    |> Enum.map(fn x -> Adventfile.line_to_ints(x) end)
    |> Enum.map(fn x -> up_or_down(x) end)
    |> Enum.count(fn x -> x == true end)
  end

  def test() do
    @test
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> Adventfile.line_to_ints(x) end)
    |> Enum.map(fn x -> up_or_down(x) end)
    |> Enum.count(fn x -> x == true end)
  end

  @spec up_or_down(list(integer())) :: list(boolean())
  def up_or_down([]), do: [false]
  def up_or_down([a, b]), do: [abs(a - b) < 4 && a != b]

  def up_or_down([head | tail] = list) do
    if(head >= hd(tail)) do
      down(list)
    else
      up(list)
    end
  end

  def up([head | tail]) do
    case tail do
      [] ->
        true

      _ ->
        tailhead = hd(tail)

        if(head < tailhead && tailhead - head <= 3 && tailhead - head > 0) do
          up(tail)
        else
          false
        end
    end
  end

  def down([head | tail]) do
    case tail do
      [] ->
        true

      _ ->
        tailhead = hd(tail)

        if(head > tailhead && head - tailhead <= 3 && head - tailhead > 0) do
          down(tail)
        else
          false
        end
    end
  end
end
