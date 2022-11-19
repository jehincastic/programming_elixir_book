# defmodule Times, do: (def double(n), do: n*2)

defmodule Times do
  def double(n) do
    n * 2
  end

  def double(a, b), do: (a + b) * 2 

  def quadruple(a, b, c, d) do
    double(a, b) * double(c, d)
  end

  def greet(greeting, name), do: (
    IO.puts "#{greeting} #{name}"
    100
  )
end

IO.puts Times.double(10)
IO.puts Times.double(5, 10)
IO.puts Times.greet("Hola", "Amigo")
IO.puts "Quad #{Times.quadruple(1, 2, 3, 2)}"
