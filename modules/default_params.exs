defmodule Example do
  def func(a, b) do
    a + b + 45    
  end

  def func(a, b \\ 2, c \\ 3, d \\ 4) do
    a + b + c + d
  end
end

IO.puts Example.func(1)
IO.puts Example.func(1, 10)
IO.puts Example.func(1, 10, 100)
IO.puts Example.func(1, 10, 100, 1000)
