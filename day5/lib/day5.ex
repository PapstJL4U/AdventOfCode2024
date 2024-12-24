defmodule Day5 do
  @example """
           47|53
           97|13
           97|61
           97|47
           75|29
           61|13
           75|53
           29|13
           97|29
           53|29
           61|53
           97|53
           61|29
           47|13
           75|47
           97|75
           47|61
           75|61
           47|29
           75|13
           53|13

           75,47,61,53,29
           97,61,53,29,13
           75,29,13
           75,97,47,61,53
           61,13,29
           97,13,75,29,47
           """
           |> String.split("\n")
  def main() do
    input = @example
    # Adventfile.get_file()

    sep_index =
      Enum.find_index(input, &(&1 == ""))

    rules =
      Enum.slice(input, 0..sep_index)
      |> Enum.map(&String.split(&1, "|", trim: true))
      |> Enum.reject(&(&1 == []))
      |> Enum.map(&inner_parse(&1))

    update =
      Enum.slice(input, (sep_index + 1)..Enum.count(input))
      |> Enum.map(&String.split(&1, ",", trim: true))
      |> Enum.reject(&(&1 == []))
      |> Enum.map(&inner_parse(&1))

    IO.inspect(rules)
    IO.inspect(update)

    IO.puts("~Fine~")
  end

  @spec inner_parse(list(String.t())) :: list(integer())
  def inner_parse(list) do
    Enum.map(list, &String.to_integer(&1))
  end
end
