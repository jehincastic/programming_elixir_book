defmodule Exercise do
    def printable?(char_list), do: char_list |> Enum.all?(fn c -> c in ?\s..?~ end)

    def anagram?(wrd1, wrd2) when length(wrd1) != length(wrd2), do: false
    def anagram?(wrd1, wrd2) when is_list(wrd1) and is_list(wrd2) do
        wrd1_cnt = wrd1 |> Enum.reduce(0, fn c, acc -> c + acc end)
        wrd2_cnt = wrd2 |> Enum.reduce(0, fn c, acc -> c + acc end)
        wrd1_cnt == wrd2_cnt
    end

    def calculate(expression) do
      { n1, rest } = parse_number(expression)
      rest = skip_spaces(rest)
      { op, rest } = parse_operator(rest)
      rest = skip_spaces(rest)
      { n2, [] } = parse_number(rest)
      op.(n1, n2)
    end

    defp parse_number(exp), do: _parse_number({ 0, exp })

    defp _parse_number({ value, [digit | rest] }) when digit in ?0..?9 do
        _parse_number({ value * 10 + digit - ?0, rest })
    end
    defp _parse_number(res), do: res
    defp skip_spaces([ ?\s | rest ]), do: skip_spaces(rest)
    defp skip_spaces(rest), do: rest

    defp parse_operator([ ?- | rest ]), do: { fn x, y -> x - y end, rest}
    defp parse_operator([ ?+ | rest ]), do: { fn x, y -> x + y end, rest}
    defp parse_operator([ ?* | rest ]), do: { fn x, y -> x * y end, rest}
    defp parse_operator([ ?/ | rest ]), do: { fn x, y -> div(x, y) end, rest}

    def center(strings) do
      strings
      |> Enum.map_reduce(0, &acc_max_leng(&1, &2))
      |> center_str
      |> Enum.each(&IO.puts/1)
    end

    defp acc_max_leng(str, max_len) do
      l = String.length str
      { {str, l}, max(l, max_len) }
    end

    defp center_str({ strings, field_width }) do
      val = strings |> Enum.map(&center_one_string(field_width, &1))
      val
    end

    defp center_one_string(field_width, { str, length }) do
      "#{String.duplicate(" ", div(field_width - length, 2))}#{str}"
    end

    def capitalize(str) do
      str
      |> String.split(~r{\.\s+})
      |> Enum.map(&String.capitalize/1)
      |> Enum.join(". ")
    end
end

IO.puts Exercise.printable?('hello')
IO.puts Exercise.anagram?('hello', 'hello')
IO.puts Exercise.anagram?('xello', 'heloo')
IO.puts Exercise.anagram?('hello', 'helao')
IO.puts Exercise.anagram?('hello', 'hlleo')
IO.puts Exercise.calculate(('23+45'))
IO.puts Exercise.calculate(('45-23'))
IO.puts Exercise.calculate(('11 * 4'))
IO.puts Exercise.calculate(('100 / 5'))
Exercise.center(["cat", "zebra", "elephant"])
IO.inspect Exercise.capitalize("oh. a DOG. woof. ")
