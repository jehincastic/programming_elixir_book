defmodule SpawnBasic do
  def greet do
    receive do
      { sender, msg } ->
        send(sender, {:ok, "Hello, #{msg}"})
        greet()
    end
  end
end

pid = spawn(SpawnBasic, :greet, [])
send pid, { self(), "World!" }

receive do
  {:ok, msg} -> IO.puts msg
end

send pid, { self(), "There" }

receive do
  {:ok, msg} -> IO.puts msg
  after 1500 -> IO.puts "The greeter has timedout"
end
