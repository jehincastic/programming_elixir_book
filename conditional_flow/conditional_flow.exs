defmodule ConditionalFlow do
  def if_cond(input) do
    if input == 1, do: "true part", else: "false part"
  end

  def unless_cond(input) do
    unless input == 1, do: "ok", else: "error"
  end

  def upto(n) when n > 0, do: _upto(n, [])

  defp _upto(0, res), do: res
  defp _upto(curr, res) do
    next_ans = cond do
      rem(curr, 3) == 0 and rem(curr, 5) == 0 -> "FizzBuzz"
      rem(curr, 3) == 0 -> "Fizz"
      rem(curr, 5) == 0 -> "Buzz"
      true -> curr
    end
    _upto(curr - 1, [next_ans | res])
  end

  def upto_two(n) when n > 0 do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 ->
        "FizzBuzz"
      rem(n, 3) == 0 ->
        "Fizz"
      rem(n, 5) == 0 ->
        "Buzz"
      true ->
        n
    end
  end

  def good_fizz_buzz(n) when n > 0, do: 1..n |> Enum.map(&fizzbuzz_pattern/1)

  defp fizzbuzz_pattern(n), do: _fizzword(n, rem(n, 3), rem(n, 5))

  defp _fizzword(_n, 0, 0), do: "FizzBuzz"
  defp _fizzword(_n, 0, _), do: "Fizz"
  defp _fizzword(_n, _, 0), do: "Buzz"
  defp _fizzword(n, _, _), do: n

  def case_fn do
    case File.open("basicss.exs") do
      {:ok, file} -> IO.puts "First line: #{IO.read(file, :line)}"
      {:error, reason} -> IO.puts "Failed to open: #{reason}"
    end
  end

  def match_users do
    dave = %{ name: "Dave", state: "TX", likes: "programming", age: 23 }
    case dave do
      %{state: some_state} = person -> IO.puts "#{person.name} lives in #{some_state}"
      _ -> IO.puts "No Matches"
    end

    case dave do
      %{ age: age } = person when is_number(age) and age >= 21 ->
        IO.puts "You are cleared to enter the Foo Bar, #{person.name} your age is #{age}"
      _ -> IO.puts "Sorry, no admission"
    end
  end
end

IO.puts ConditionalFlow.if_cond(1)
IO.puts ConditionalFlow.if_cond(2)
IO.puts ConditionalFlow.unless_cond(1)
IO.puts ConditionalFlow.unless_cond(2)
IO.inspect ConditionalFlow.upto(15)
IO.inspect ConditionalFlow.upto_two(15)
IO.inspect ConditionalFlow.good_fizz_buzz(15)
ConditionalFlow.case_fn
ConditionalFlow.match_users
