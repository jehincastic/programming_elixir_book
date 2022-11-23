defmodule Example do
  # def func(a, b) do -> This will work but stills shows a warning
  #   a + b + 45    
  # end

  def func(a, b \\ 2, c \\ 3, d \\ 4) do
    a + b + c + d
  end

  def funct(a, b \\ 123)

  def funct(a, b) when is_list(a) do
    [head | _tail] = a
    head + b
  end

  def funct(a, b) do
    a + b
  end
end

IO.puts Example.func(1)
IO.puts Example.func(1, 10)
IO.puts Example.func(1, 10, 100)
IO.puts Example.func(1, 10, 100, 1000)
IO.puts Example.funct([100], 10)
IO.puts Example.funct(100)
IO.puts Example.funct(100, 5)
