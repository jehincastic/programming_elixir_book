a = 1
1 = a
# 2 = a -> Throws an error as 2 (LHS) will not match with 1 (RHS)

list = [1,2,3]
[a,b,c] = list
[1,2,a] = list
# [a,4,3] = list -> [1,4,3] (LHS) !== [1,2,3]
[1, _, _] = [1, 2, 3]
# [a, a] = [1, 2] -> Variables can be binded only once.
# -> Once a variable is bound to a value it keeps it for the remainder of match
[a, a] = [100, 100]

# In Elixir, all values are immutable.
list = [1,2,3]
list2 = [4 | list] # [4,1,2,3]

# But the cool thing about Elixir is that you write your code using lots and lots of processes, and each process has its own heap
# The data in your application is divied up between these processes, so each individual heap is much, much smaller than would have been the case if all the data had been in a single heap.
# As a result, garbage collection runs faster. If a process terminates before its heap becomes full, all its data is discarded—no garbage collection is required.

name = "elixir"
cap_name = String.capitalize(name)
IO.puts "Cap Name is #{cap_name}"
IO.puts "Name is #{name}"

# Types
 # -> Integer literals can be written as decimal (1234), hexadecimal (0xcafe), octal (0o765), and binary (0b1010).
 # -> Decimal numbers may contain underscores—these are often used to separate groups of three digits when writing large numbers, so one million could be written 1_000_000.
 # -> Floating-point numbers are written using a decimal point. (1.0, 0.2345)
 # -> Atoms
 #    -> Atoms are constants that represent something’s name.
 #    -> We write them using a leading colon (:), which can be followed by an atom word or an Elixir operator.
 #    -> An atom word is a sequence of UTF-8 letters (including combining marks), digits, underscores, and at signs (@).
 #    -> It may end with an exclamation point or a question mark.
 #    -> You can also create atoms containing arbitrary characters by enclosing the characters following the colon in double quotes.
 #    -> An atom’s name is its value
 #    -> :fred :is_binary? :var@2 :<> :=== :"func/3" :"long john silver" :эликсир :mötley_crüe
 # -> Ranges are represented as start..end, where start and end are integers.
 # -> Regular Expressions written as ~r{regexp} or ~r{regexp}opts.
 # -> Ex
IO.inspect Regex.run ~r{[aeiou]}, "caterpillar"
IO.inspect Regex.scan ~r{[aeiou]}, "caterpillar"
IO.inspect Regex.split ~r{[aeiou]}, "caterpillar"
IO.inspect Regex.replace ~r{[aeiou]}, "caterpillar", "*"

# System Types
# -> PIDs and Ports
# -> A PID is a reference to a local or remote process, and a port is a reference to a resource (typically external to the application) that you’ll be reading or writing.
# -> The PID of the current process is available by calling self.
# -> References -> The function make_ref creates a globally unique reference; no other reference will be equal to it.

IO.inspect self()

# Collection Types
# Tuples
#   -> A tuple is an ordered collection of values.
#   -> As with all Elixir data structures, once created a tuple cannot be modified.
#   -> Ex: {1, 2}  {:ok, 42, "next"}   {:error,:enoent}
{status, count, action} = {:ok, 42, "next"}
IO.puts status
IO.puts count
IO.puts action
{status, file} = File.open("mix.exs")
IO.inspect status

# Lists
#   -> Tuples are the closest Elixir gets to a conventional array.
#   -> Instead, a list is effectively a linked data structure.
#   -> A list may either be empty or consist of a head and a tail.
#   -> The head contains a value and the tail is itself a list.

IO.inspect [ 1, 2, 3 ] ++ [ 4, 5, 6 ]
IO.inspect [1, 2, 3, 4] -- [2, 4]
IO.inspect [1, 2, 3, 4, 3, 2, 1] -- [2, 4]
IO.inspect 1 in [1,2,3,4]
IO.inspect "wombat" in [1, 2, 3, 4, "wo"]
IO.inspect "wombat" in [1, 2, 3, 4, "wombat"]

# Keyword Lists
keyword_list = [name: "Dave", city: "Dallas", likes: "Programming"]
# Elixir converts this to a list of two-value tuples something like
# [{:name, "Dave"}, {:city, "Dallas"}, {:likes, "Programming"}]
IO.inspect [{:name, "Dave"}] == [name: "Dave"]
# [1, fred: 1, dave: 2] == [1, {:fred, 1}, {:dave, 2}]
# {1, fred: 1, dave: 2} == {1, [fred: 1, dave: 2]}

# Maps
# -> A map is a collection of key/value pairs.
# -> Maps allow only one entry for a particular key, whereas keyword lists allow the key to be repeated.
my_map = %{ "AL" => "Alabama", "WI" => "Wisconsin" }
IO.inspect my_map
responses = %{ { :error, :enoent } => :fatal, { :error, :busy } => :retry }
IO.inspect responses
colors = %{ :red => 0xff0000, :green => 0x00ff00, :blue => 0x0000ff }
IO.inspect colors
diff_key_types = %{ "one" => 1, :two => 2, {1,1,1} => 3 }
IO.inspect diff_key_types
# -> If the key is an atom, you can use the same shortcut that you use with keyword lists
colors = %{red: 0xff0000, green: 0x00ff00, blue: 0x0000ff }
IO.inspect colors
name = "Desmond Miles"
IO.inspect %{ String.downcase(name) => name }

# Accessing a Map
IO.inspect my_map["AL"]
IO.inspect my_map["TX"]
IO.inspect responses[{:error, :busy}]
# -> If the keys are atoms, you can also use a dot notation
IO.inspect colors[:red]
IO.inspect colors.green
# -> It’ll throw a KeyError if there’s no matching key when you use the dot notation.

# Binaries
# -> Elixir supports this with the binary data type. Binary literals are enclosed between << and >>.
bin = << 1, 2 >>
IO.puts byte_size(bin)
# -> You can add modifiers to control the type and size of each individual field.
# -> Here’s a single byte that contains three fields of widths 2, 4, and 2 bits.
# -> Elixir uses binaries to represent UTF strings.
bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2)>>
IO.inspect bin
IO.inspect :io.format("~8.2b~n", :binary.bin_to_list(bin))
IO.puts byte_size bin

# Dates and Times
{:ok, d1} = Date.new(2018, 12, 25)
IO.inspect d1
d2 = ~D[2018-12-25]
IO.puts d1 == d2
IO.puts Date.day_of_week(d1)
IO.inspect Date.add(d1, 7)
IO.inspect inspect d1, structs: false
d1 = ~D[2018-01-01]
d2 = ~D[2018-06-30]
first_half = Date.range(d1, d2)
IO.inspect first_half
IO.puts Enum.count(first_half)
IO.puts ~D[2018-03-15] in first_half
# -> The Time type contains an hour, a minute, a second, and fractions of a second.
# -> The fraction is stored as a tuple containing microseconds and the number of significant digits.
{:ok, t1} = Time.new(12, 34, 56)
t2 = ~T[12:34:56.78]
IO.puts t1 == t2
IO.inspect Time.add(t1, 3600)
IO.inspect Time.add(t1, 3600, :millisecond)

# Elixir comparision works in this order
# number < atom < reference < function < port < pid < tuple < map < list < binary
# a === b # strict equality   (so 1 === 1.0 is false)
# a !== b # strict inequality (so 1 !== 1.0 is true)
# a ==  b # value equality    (so 1 ==  1.0 is true)
# a !=  b # value inequality  (so 1 !=  1.0 is false)
# a  >  b # normal comparison
# a >=  b #   :
# a  <  b #   :
# a <=  b #   :

# Boolean operators
# These operators expect true or false as their first argument.
# a or b  # true if a is true; otherwise b
# a and b # false if a is false; otherwise b
# not a   # false if a is true; true otherwise

# Relaxed Boolean operators
# These operators take arguments of any type.
# Any value apart from nil or false is interpreted as true.
# a || b    # a if a is truthy; otherwise b
# a && b    # b if a is truthy; otherwise a
# !a        # false if a is truthy; otherwise true

# Join operators
# binary1 <> binary2 # concatenates two binaries
# list1 ++ list2       # concatenates two lists
# list1 -- list2       # removes elements of list 2 from a copy of list 1

# The in operator
# a in enum            # tests if a is included in enum (for example, a list, a range, or a map). For maps, a should be a {key, value} tuple.

# Variable Scope
# Elixir is lexically scoped.
# The basic unit of scoping is the function body.
# Variables defined in a function (including its parameters) are local to that function.
# In addition, modules define a scope for local variables, but these are accessible only at the top level of that module, and not in functions defined in the module.

content = "Now is the time"
lp  =  with {:ok, file}   = File.open("/etc/passwd"),
  content       = IO.read(file, :all),  # note: same name as above
  :ok           = File.close(file),
  [_, uid, gid] = Regex.run(~r/^lp:.*?:(\d+):(\d+)/m, content)
  do
   "Group: #{gid}, User: #{uid}"
  end
 	
IO.puts lp             #=> Group: 26, User: 26
IO.puts content        #=> Now is the time
IO.inspect with [a|_] <- [1,2,3], do: a
IO.inspect with [a|_] <- nil, do: a

result  =  with {:ok, file} = File.open("/etc/passwd"),
    content =  IO.read(file, :all),
 	:ok =  File.close(file),
    [_, uid, gid] <- Regex.run(~r/^xxx:.*?:(\d+):(\d+)/, content)
    do
        "Group: #{gid}, User: #{uid}"
    end
IO.puts inspect(result)       #=> nil

# Underneath the covers, with is treated by Elixir as if it were a call to a function or macro.
# This means that you cannot write this
# mean = with
#    count = Enum.count(values),
# 	 sum   = Enum.sum(values)
# 	 do
#     	 sum/count
# 	 end

mean = with count = Enum.count(values),
            sum   = Enum.sum(values)
    do
     	sum/count
 	end

mean = with(
        count = Enum.count(values),
        sum   = Enum.sum(values)
 	do
     	sum/count
 	end)

mean = with count = Enum.count(values),
 	        sum   = Enum.sum(values),
 	   do:  sum/count

