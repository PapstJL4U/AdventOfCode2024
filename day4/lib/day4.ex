defmodule Day4 do
  # @xmas ~r/x(?=[a-zA-Z]?mas)/iU
  @xmas ~r/xmas/iU
  @example """
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
  """

  @type row :: {String.t(), integer()}
  def main() do
    list =
      Adventfile.get_file()

    # list =
    #  @example
    # |> String.split("\n", trim: true)

    pad = String.length(Enum.at(list, 1))
    last = pad - 1
    # Enum.map(list, &IO.puts(&1))

    rot_list =
      Enum.map(0..last, fn x -> col_to_row(list, x, "") end)

    rot_2_list =
      Enum.reverse(list)
      |> Enum.map(&String.reverse(&1))

    hsum =
      list
      |> do_all()

    IO.puts("===")

    vsum =
      rot_list
      |> do_all()

    IO.puts("===")

    ddrsum =
      Enum.map(0..last, fn x -> get_diagonal(list, x, "", pad) end)
      |> do_all()

    IO.puts("===")

    ddlsum =
      Enum.map(1..last, fn x -> get_diagonal(rot_list, x, "", pad) end)
      |> do_all()

    IO.puts("===")

    dursum =
      Enum.map(0..last, fn x -> get_diagonalu(list, x, "", pad) end)
      |> do_all()

    IO.puts("===")

    dulsum =
      Enum.map(0..(last - 1), fn x -> get_diagonalu(rot_2_list, x, "", pad) end)
      |> do_all()

    [hsum, vsum, ddrsum, ddlsum, dursum, dulsum]
    |> Enum.map(&IO.puts(Integer.to_string(&1)))

    Enum.sum([hsum, vsum, ddrsum, ddlsum, dursum, dulsum])
  end

  @spec add_accumulators(list(String.t())) :: list(row)
  def add_accumulators(list) do
    Enum.map(list, fn x -> {x, 0} end)
  end

  @spec find(row) :: row
  def find({str, _}) do
    {str, find(str)}
  end

  @spec find(String.t()) :: integer()
  def find(str) do
    backward =
      Regex.scan(@xmas, String.reverse(str))
      |> Enum.count()

    forward =
      Regex.scan(@xmas, str)
      |> Enum.count()

    backward + forward
  end

  @spec col_to_row(list(String.t()), integer(), String.t()) :: String.t()
  def col_to_row([], _, str), do: str

  def col_to_row([hd | tail], col, str) do
    str =
      str <> String.at(hd, col)

    col_to_row(tail, col, str)
  end

  @spec get_diagonal(list(String.t()), integer(), String.t(), integer()) :: String.t()
  def get_diagonal([], _, str, max), do: String.pad_trailing(str, max, ".")
  def get_diagonal(_, max, str, max), do: String.pad_trailing(str, max, ".")

  def get_diagonal([hd | tail], col, str, max) do
    str =
      str <> String.at(hd, col)

    get_diagonal(tail, col + 1, str, max)
  end

  @spec get_diagonalu(list(String.t()), integer(), String.t(), integer()) :: String.t()
  def get_diagonalu([], _, str, max), do: String.pad_trailing(str, max, ".")
  def get_diagonalu(_, -1, str, max), do: String.pad_trailing(str, max, ".")

  def get_diagonalu([hd | tail], col, str, max) do
    str =
      str <> String.at(hd, col)

    get_diagonalu(tail, col - 1, str, max)
  end

  @spec do_all(list(String.t())) :: integer()
  def do_all(list) do
    list
    |> add_accumulators()
    |> Enum.map(&find(&1))
    |> Enum.map(&IO.inspect(&1))
    |> Enum.map(fn {_, i} -> i end)
    |> Enum.sum()
  end
end
