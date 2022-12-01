print_float  = fn n ->
  :io_lib.format("~.2f", [n])
end

IO.inspect print_float.(52.678)
IO.inspect System.get_env("GOPATH")

get_extension = fn filename ->
  Path.extname(filename)
end

IO.inspect get_extension.("hello.exs")
IO.inspect File.cwd

IO.inspect System.cmd "ls", ["-l"]
