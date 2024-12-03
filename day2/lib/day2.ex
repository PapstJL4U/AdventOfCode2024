defmodule Day2 do
  @fpath "./assets/day2.txt"

  @spec check_ints(list(integer())) :: integer()
  defp check_ints(list) do
    list
    |> Enum.map(&up_or_down(&1))
    |> Enum.count(fn x -> x == true end)
  end

  defp up_or_down([head, tail] = list) do
    if(head >= hd(tail)) do
      down(list)
    else
      up(list)
    end
  end

  defp up(list) do
    [head, tail] = list

    case tail do
      nil ->
        true

      _ ->
        tailhead = hd(tail)

        if(head < tailhead && tailhead - head <= 2 && tailhead - head > 0) do
          up(tail)
        else
          false
        end
    end
  end

  defp down(list) do
    [head, tail] = list

    case tail do
      nil ->
        true

      _ ->
        tailhead = hd(tail)

        if(head > tailhead && head - tailhead <= 2 && head - tailhead > 0) do
          down(tail)
        else
          false
        end
    end
  end
end
