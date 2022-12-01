defmodule Example do
  @author "John Doe"
  def get_author do
    @author
  end
  @author "Desmond Miles"
  def get_author2, do: @author
end

IO.puts "#{Example.get_author2} <=> #{Example.get_author}"
IO.puts is_atom(Example.get_author)
IO.puts to_string(Example)
# Internally, module names are just atoms.
# When you write a name starting with an uppercase letter, such as IO,
  # Elixir converts it internally into an atom of the same name with Elixir. prepended.
# So "IO" becomes "Elixir.IO" and "Dog" becomes "Elixir.Dog".
:"Elixir.IO".puts :"Elixir.Example".get_author2

:io.format("This number is ~3.1f~n", [5.678])
