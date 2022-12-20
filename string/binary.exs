b = << 1, 2, 3 >>

IO.puts byte_size(b)
IO.puts bit_size(b)

b = << 1::size(2), 1::size(3) >>

IO.puts byte_size(b)
IO.puts bit_size(b)

int = <<1>>
IO.inspect(int)

float = << 2.5 :: float >>
IO.inspect(float)

mix = << int :: binary, float :: binary >>
IO.inspect mix

<< sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159::float >>
IO.inspect (1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exp-1023) * (1 - 2 * sign)

dqs = "∂x/∂y"
IO.inspect String.length dqs
IO.inspect byte_size dqs
IO.inspect String.at(dqs, 0)
IO.inspect String.codepoints(dqs)
IO.inspect String.split(dqs, "/")

IO.puts String.at("∂og", 0)
IO.puts String.at("∂og", -1)
IO.puts String.capitalize("école")
IO.puts String.capitalize("ÎÎÎÎÎ")
IO.inspect String.codepoints("José's ∂øg")
IO.inspect String.downcase "ØRSteD"
IO.puts String.duplicate "Ho! ", 3
IO.puts String.ends_with? "string", ["elix", "stri", "ring"]
IO.puts String.starts_with? "string", ["elix", "stri", "ring"]
IO.puts String.first "∂og" # returns first grapheme from str (∂)
IO.inspect String.codepoints "noe\u0308l"
IO.inspect String.graphemes "noe\u0308l"
IO.inspect String.jaro_distance("color", "colour") # Returns a float between 0 and 1 indicating the likely similarity of two strings.
IO.inspect String.jaro_distance("josé", "john")
IO.inspect String.last("∂øg")# Returns the last grapheme from str.
IO.inspect String.length "∂x/∂y"
IO.inspect String.myers_difference("banana", "panama") # Returns the list of transformations needed to convert one string to another.

defmodule MyString do
  def each(str, func), do: _each(String.next_codepoint(str), func)

  defp _each({ codepoint, rest }, func) do
    func.(codepoint)
    _each(String.next_codepoint(rest), func)
  end

  defp _each(nil, _), do: []

  def for_each(str, func) when is_binary(str), do: _for_each(str, func)

  defp _for_each(<< head :: utf8, tail :: binary >>, func) do
    func.(head)
    _for_each(tail, func)
  end
  defp _for_each(<<>>, _func), do: []
end

MyString.each("José's ∂øg", fn c -> IO.puts c end)

IO.puts String.pad_leading("hello", 10, "%")
IO.puts String.pad_trailing("hello", 10, "%")
IO.puts String.printable? dqs
IO.puts String.printable? "\x00 a null"
IO.puts String.replace "the cat on the mat", "at", "AT"
IO.puts String.replace "the cat on the mat", "at", "AT", global: false
# IO.puts String.replace "the cat on the mat", "at", "AT", insert_replaced: 0
# IO.puts String.replace "the cat on the mat", "at", "AT", insert_replaced: [0,2]
IO.inspect String.reverse dqs
IO.inspect String.slice "the cat on the mat", 4, 3
IO.inspect String.slice "the cat on the mat", -3, 3
IO.inspect String.split "     the cat on the mat   "
IO.inspect String.split "the cat on the mat", "t"
IO.inspect String.split "the cat on the mat", ~r{[ae]}
IO.inspect String.split "the cat on the mat", ~r{[ae]}, parts: 2
IO.inspect String.trim "  \t hola amingo   "
IO.inspect String.trim_leading "  \t hola amingo   "
IO.inspect String.trim_trailing "  \t hola amingo   "
IO.inspect String.trim_trailing "hola! amingo!!!", "!"
IO.inspect String.upcase "hola! amingo!!!"
IO.inspect String.valid? dqs
IO.inspect String.valid? <<0x80, 0x81>>

MyString.for_each("∂øg", fn c -> IO.puts c end)
