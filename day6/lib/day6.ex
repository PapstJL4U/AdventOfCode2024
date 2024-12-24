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

  @type guard :: :^ | :< | :> | :v | :start | :finish
  @type state :: {guard, list(), integer()}
  def main() do
    input =
      @example
      |> Enum.map(&String.split(&1, "", trim: true))
      |> Enum.reject(&(&1 == []))

    state = status({:start, input, 0})

    update_state(state)
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

  @spec status(state) :: state
  def status(x) do
    x
  end

  @spec update_state(state) :: state()
  def update_state({:start, labyrinth, _}) do
    {direction, rowcol} =
      Enum.with_index(labyrinth)
      |> Enum.map(fn {row, index} ->
        {Enum.any?(row, fn x -> x == "<" || x == ">" || x == "v" || x == "^" end), row, index}
      end)
      |> Enum.filter(fn {lab, _, _} -> lab == true end)
      |> Enum.at(0)
      |> find_start()

    IO.inspect(labyrinth)
    update_state({direction, labyrinth, rowcol})
  end

  def update_state({:finish, labyrinth, row}) do
    {:finish, labyrinth, row}
  end

  def update_state({:>, labyrinth, row}) do
    r = Enum.at(labyrinth, row) |> Enum.to_list()
    index = Enum.find_index(r, fn x -> x == ">" end)

    if(index < Enum.count(r) - 1) do
      char = Enum.at(row, index + 1)

      if(char == "#") do
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, row, r)
        {:v, lab, r}
      else
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, row, r)
        {:>, lab, row}
      end
    else
      r = List.replace_at(r, index, "X")
      lab = List.replace_at(labyrinth, row, r)
      {:finish, lab, 0}
    end
  end

  def update_state({:<, labyrinth, row}) do
    r = Enum.at(labyrinth, row) |> Enum.to_list()
    index = Enum.find_index(r, fn x -> x == "<" end)

    if(index > 0) do
      char = Enum.at(row, index - 1)

      if(char == "#") do
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, row, r)
        {:^, lab, r}
      else
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, row, r)
        {:<, lab, row}
      end
    else
      r = List.replace_at(r, index, "X")
      lab = List.replace_at(labyrinth, row, r)
      {:finish, lab, 0}
    end
  end

  def update_state({:v, labyrinth, col}) do
    lab_trans = Enum.zip(labyrinth)
    r = Enum.at(lab_trans, col) |> Enum.to_list()
    index = Enum.find_index(r, fn x -> x == "v" end)

    if(index < Enum.count(r) - 1) do
      char = Enum.at(col, index + 1)

      if(char == "#") do
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, col, r)
        {:<, Enum.zip(lab), r}
      else
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, col, r)
        {:v, Enum.zip(lab), col}
      end
    else
      r = List.replace_at(r, index, "X")
      lab = List.replace_at(labyrinth, col, r)
      {:finish, Enum.zip(lab), 0}
    end
  end

  def update_state({:^, labyrinth, col}) do
    lab_trans = Enum.zip(labyrinth)
    r = Enum.at(lab_trans, col) |> Enum.to_list()
    index = Enum.find_index(r, fn x -> x == "^" end)

    if(index > 0) do
      char = Enum.at(col, index - 1)

      if(char == "#") do
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, col, r)
        {:>, Enum.zip(lab), r}
      else
        r = List.replace_at(r, index, "X")
        lab = List.replace_at(labyrinth, col, r)
        {:^, Enum.zip(lab), col}
      end
    else
      r = List.replace_at(r, index, "X")
      lab = List.replace_at(labyrinth, col, r)
      {:finish, Enum.zip(lab), 0}
    end
  end

  @spec find_start({boolean(), list(), integer()}) :: {guard, integer()}
  def find_start({_, row, index}) do
    i = Enum.find_index(row, &(&1 == "<"))

    if(i != nil) do
      {:<, index}
    else
      i = Enum.find_index(row, &(&1 == ">"))

      if(i != nil) do
        {:>, index}
      else
        i = Enum.find_index(row, &(&1 == "^"))

        if(i != nil) do
          {:^, index}
        else
          {:v, index}
        end
      end
    end
  end
end
