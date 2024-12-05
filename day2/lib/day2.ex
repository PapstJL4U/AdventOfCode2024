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
    |> Enum.map(fn x -> check_ints(x) end)
    |> Enum.count(fn x -> x == true end)
  end

  def test() do
    @test
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> Adventfile.line_to_ints(x) end)
    |> Enum.map(fn x -> check_ints(x) end)
    |> Enum.count(fn x -> x == true end)
  end

  @spec check_ints(list(integer())) :: integer()
  def check_ints([]), do: 0

  def check_ints(list) do
    up_or_down(list)
  end

  def up_or_down(list) do
    [head | tail] = list

    if(head >= hd(tail)) do
      down(list)
    else
      up(list)
    end
  end

  def up(list) do
    [head | tail] = list

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

  def down(list) do
    [head | tail] = list

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
