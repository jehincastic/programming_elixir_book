defmodule Gcd do
  def calculate(x, 0), do: x
  def calculate(x, y), do: calculate(y, rem(x, y))
end

IO.puts Gcd.calculate(30, 45)
