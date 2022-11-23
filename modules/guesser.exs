defmodule Chop do
  def guess(n, %Range{} = range) when is_integer(n) do
    if n not in range do
      raise RuntimeError, message: "Invalid integer provided"
    end

    guess_val = get_middle range
    do_guess(n, range, guess_val)
  end

  def guess(n, _range) when not is_integer(n),
    do: {:error, "Expected an integer"}

  defp do_guess(n, _range, guess) when n == guess do
    IO.puts "It is #{guess}"
    {:ok, guess}
  end

  defp do_guess(n, range, guess) when n < guess do
    IO.puts "Is it #{guess}"

    min.._max = range
    new_max = guess - 1
    new_range = min..new_max
    guess(n, new_range)
  end
  
  defp do_guess(n, range, guess) when n > guess do
    IO.puts "Is it #{guess}"

    _min..max = range
    new_min = guess + 1
    new_range = new_min..max
    guess(n, new_range)
  end

  defp get_middle(%Range{} = range) do
    min..max = range
    count = max - min + 1
    max - div(count, 2)
  end
end

IO.inspect Chop.guess(10, 1..100)
IO.inspect Chop.guess(100, 1..100)
