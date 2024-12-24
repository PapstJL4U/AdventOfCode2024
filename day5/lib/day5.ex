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

  @type row :: {list(integer()), boolean(), integer()}
  def main() do
    # input = @example

    input =
      Adventfile.get_simple_input()
      |> String.split("\n")

    sep_index =
      Enum.find_index(input, &(&1 == ""))

    rules =
      Enum.slice(input, 0..sep_index)
      |> Enum.map(&String.split(&1, "|", trim: true))
      |> Enum.reject(&(&1 == []))
      |> Enum.map(&inner_parse/1)
      |> Enum.map(&List.to_tuple/1)

    update =
      Enum.slice(input, (sep_index + 1)..Enum.count(input))
      |> Enum.map(&String.split(&1, ",", trim: true))
      |> Enum.reject(&(&1 == []))
      |> Enum.map(&inner_parse/1)
      |> Enum.map(fn x -> {x, true, round((Enum.count(x) - 1) / 2)} end)
      |> Enum.map(&check_rules(&1, rules))

    sum =
      Enum.filter(update, fn {_, correct, _} -> correct == true end)
      |> Enum.map(fn {input, _, mid} -> Enum.at(input, mid) end)
      |> Enum.sum()

    # IO.inspect(rules)
    IO.inspect(update)
    IO.inspect(sum)
    IO.puts("~fine~")
  end

  @spec inner_parse(list(String.t())) :: list(integer())
  def inner_parse(list) do
    Enum.map(list, &String.to_integer/1)
  end

  @spec check_rules(row, list({integer(), integer()})) :: row
  def check_rules({input, _, mid}, rules) do
    correct =
      Enum.map(rules, &check_rule(input, &1))
      |> Enum.all?(fn x -> x == true end)

    {input, correct, mid}
  end

  @spec check_rule(list(integer()), {integer(), integer()}) :: boolean()
  def check_rule(print, {first, second}) do
    findex = Enum.find_index(print, &(&1 == first))
    sindex = Enum.find_index(print, &(&1 == second))

    case {findex, sindex} do
      {nil, _} -> true
      {_, nil} -> true
      {fi, si} -> fi < si
    end
  end
end
