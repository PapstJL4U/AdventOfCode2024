defmodule Day4 do
  @xmas ~r/xmas/i
  @samx ~r/samx/i
  @type row :: {String.t(), integer()}
  def main() do
    list =
      Adventfile.get_file()

    vlist =
      Enum.map(0..139, fn x -> col_to_row(list, x, "") end)
      |> add_accumulators()
      |> Enum.map(&find_h(&1))
      |> Enum.map(fn {_, i} -> i end)
      |> Enum.sum()

    hlist =
      list
      |> add_accumulators()
      |> Enum.map(&find_h(&1))
      |> Enum.map(fn {_, i} -> i end)
      |> Enum.sum()

    dlist =
      Enum.map(0..139, fn x -> get_diagonal(list, x, "") end)
      |> add_accumulators()
      |> Enum.map(&find_h(&1))
      |> Enum.map(fn {_, i} -> i end)
      |> Enum.sum()

    [dlist, vlist, hlist]
    |> Enum.map(&IO.puts(Integer.to_string(&1)))

    dlist + vlist + hlist
  end

  @spec add_accumulators(list(String.t())) :: list(row)
  def add_accumulators(list) do
    Enum.map(list, fn x -> {x, 0} end)
  end

  @spec find_h(row) :: row
  def find_h({str, _}) do
    {str, find(str)}
  end

  @spec find(String.t()) :: integer()
  def find(str) do
    backward =
      Regex.scan(@samx, str)
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

  @spec get_diagonal(list(String.t()), integer(), String.t()) :: String.t()
  def get_diagonal([], _, str), do: String.pad_trailing(str, 140, ".")
  def get_diagonal(_, 140, str), do: String.pad_trailing(str, 140, ".")

  def get_diagonal([hd | tail], col, str) do
    str =
      str <> String.at(hd, col)

    get_diagonal(tail, col + 1, str)
  end
end
