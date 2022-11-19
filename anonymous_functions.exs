sum = fn (a,b) -> a + b end
IO.puts sum.(1, 2)

greet = fn -> IO.puts "Hello" end
greet.()

sum = fn a, b -> a + b + 5 end
IO.puts sum.(100, 110)

swap = fn {a, b} -> {b, a} end
IO.inspect swap.({ 6, 8 })

list_concat = fn (a, b) -> a ++ b end
convert_tuple = fn ({ a, b }) -> [a, b] end

IO.inspect list_concat.([1,2,3], [4,5,6])
IO.inspect convert_tuple.({ 1, 2 })

handle_open = fn
    {:ok, file} -> "Read data: #{IO.read(file, :line)}"
    {_, error} -> "Error: #{:file.format_error(error)}"
end

IO.puts handle_open.(File.open("./basics.exs"))
IO.puts handle_open.(File.open("./sics.exs"))

fizz_buzz = fn
    (0, 0, _) -> "FizzBuzz"
    (0, _, _) -> "Fizz"
    (_, 0, _) -> "Buzz"
    (_, _, a) -> a
end

IO.puts fizz_buzz.(0, 0, 0)
IO.puts fizz_buzz.(0, 1, 0)
IO.puts fizz_buzz.(2, 0, 0)
IO.puts fizz_buzz.(1, 2, 10)

fizz_buzz_gen = fn (n) -> fizz_buzz.(rem(n, 3), rem(n, 5), n) end
IO.puts fizz_buzz_gen.(10)
IO.puts fizz_buzz_gen.(11)
IO.puts fizz_buzz_gen.(12)
IO.puts fizz_buzz_gen.(13)
IO.puts fizz_buzz_gen.(14)
IO.puts fizz_buzz_gen.(15)
IO.puts fizz_buzz_gen.(16)

IO.puts "-----------------------"
fun1 = fn -> fn -> "hello" end end
IO.puts fun1.().()
add_num = fn (num) -> (fn (num2) -> num + num2 end) end
add_five = add_num.(5)
IO.puts add_five.(10)
IO.puts add_five.(11)

prefix_fn = fn (pre) -> fn (suf) -> "#{pre} #{suf}" end end
IO.puts "---------------------------"
mr = prefix_fn.("Mr")
IO.puts mr.("Desmond Miles")

times_2 = fn (n) -> n * n end
call_fn = fn (fun, val) -> fun.(val) end
IO.puts call_fn.(times_2, 10)
list = [1, 2, 3, 4]
IO.inspect Enum.map list, fn e -> e * 2 end

IO.puts "--------------------------"

add_one = &(&1 + 1) # same as add_one = fn (n) -> n + 1
square = &(&1 * &1)
speak = &(IO.puts("#{&1} #{&2}"))

IO.puts add_one.(100)
IO.puts square.(5)
speak.("hello", "world")

divrem = &{ div(&1,&2), rem(&1,&2) }
IO.inspect divrem.(10, 3)

s = &"Hola #{&1}"
IO.puts s.("Amigo")

match_end = &~r/.*#{&1}$/
IO.puts "cat" =~ match_end.("t")

list = [1,2,3,4]
IO.puts length(list)
IO.puts Enum.count(list)
l = &length/1
count = &Enum.count/1
IO.puts l.(list)
IO.puts count.(list)

IO.inspect Enum.map [1,2,3,4], &(&1 + 1)
IO.puts "==========================="
Enum.each(list, &IO.inspect/1)
IO.puts "==========================="
