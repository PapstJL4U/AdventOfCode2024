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

  def main() do
    # @example
    input =
      Adventfile.get_file()
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.reject(&(&1 == []))

    width = input |> Enum.at(0) |> Enum.count()
    finput = input |> Enum.flat_map(fn x -> x end)
    # IO.inspect(finput)
    fin = move("^", finput, width)
    # IO.inspect(fin |> Enum.chunk_every(width))
    Enum.count(fin, fn x -> x == "X" end)
  end

  @spec move(String.t(), list(String.t()), integer()) :: list(String.t())
  def move("^", lab, width) do
    pos_now = Enum.find_index(lab, &(&1 == "^"))

    if(tr(pos_now, width) > 0) do
      pos_next = pos_now - width

      if(Enum.at(lab, pos_next) != "#") do
        new_lab = update(lab, pos_now, pos_next, "^")
        move("^", new_lab, width)
      else
        new_lab = step(lab, pos_now, ">")
        move(">", new_lab, width)
      end
    else
      lab |> cross(pos_now)
    end
  end

  def move(">", lab, width) do
    pos_now = Enum.find_index(lab, &(&1 == ">"))

    if(tc(pos_now, width) < width - 1) do
      pos_next = pos_now + 1

      if(Enum.at(lab, pos_next) != "#") do
        new_lab = update(lab, pos_now, pos_next, ">")
        move(">", new_lab, width)
      else
        new_lab = step(lab, pos_now, "v")
        move("v", new_lab, width)
      end
    else
      lab |> cross(pos_now)
    end
  end

  def move("v", lab, width) do
    pos_now = Enum.find_index(lab, &(&1 == "v"))

    if(tr(pos_now, width) < width - 1) do
      pos_next = pos_now + width

      if(Enum.at(lab, pos_next) != "#") do
        new_lab = update(lab, pos_now, pos_next, "v")
        move("v", new_lab, width)
      else
        new_lab = step(lab, pos_now, "<")
        move("<", new_lab, width)
      end
    else
      lab |> cross(pos_now)
    end
  end

  def move("<", lab, width) do
    pos_now = Enum.find_index(lab, &(&1 == "<"))

    if(tc(pos_now, width) > 0) do
      pos_next = pos_now - 1

      if(Enum.at(lab, pos_next) != "#") do
        new_lab = update(lab, pos_now, pos_next, "<")
        move("<", new_lab, width)
      else
        new_lab = step(lab, pos_now, "^")
        move("^", new_lab, width)
      end
    else
      lab |> cross(pos_now)
    end
  end

  @doc """
  returns the "virtual" row of any position
  """
  @spec tr(integer(), integer()) :: integer()
  def tr(pos, width) do
    Integer.floor_div(pos, width)
  end

  @doc """
  returns the "virtual" col of any position
  """
  @spec tc(integer(), integer()) :: integer()
  def tc(pos, width) do
    Integer.mod(pos, width)
  end

  @spec cross(list(String.t()), integer()) :: list(String.t())
  def cross(list, i) do
    Enum.concat([
      Enum.slice(list, 0, i),
      ["X"],
      Enum.slice(list, (i + 1)..Enum.count(list))
    ])
  end

  @spec step(list(String.t()), integer(), String.t()) :: list(String.t())
  def step(list, i, guard) do
    Enum.concat([
      Enum.slice(list, 0, i),
      [guard],
      Enum.slice(list, (i + 1)..Enum.count(list))
    ])
  end

  @spec update(list(String.t()), integer(), integer(), String.t()) :: list(String.t())
  def update(list, old, new, guard) do
    list
    |> cross(old)
    |> step(new, guard)
  end
end
