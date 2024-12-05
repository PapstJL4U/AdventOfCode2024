defmodule Adventfile do
  @file_path "./assets/advent.txt"

  @spec get_file() :: list()
  def get_file() do
    IO.puts(@file_path)
    IO.puts(File.exists?(@file_path))

    case File.read(@file_path) do
      {:ok, value} ->
        String.split(value, "\n", trim: true)

      {:error, reasons} ->
        IO.puts(reasons)
        []
    end
  end

  @spec line_to_ints(String.t(), String.t()) :: list(integer())
  def line_to_ints(line, splitter \\ "\s") do
    line
    |> String.split(splitter, trim: true)
    |> Enum.map(&String.to_integer(&1))
  end
end
