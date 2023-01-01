defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_fn do
    sleep 500
    exit(:boom)
  end

  def run do
    Process.flag(:trap_exit, true) # without this line it would crash without receving any messgae
    spawn_link(Link1, :sad_fn, [])
    receive do
      msg ->
        IO.puts "Message redceived #{inspect msg}"
      after 1000 ->
        IO.puts "Timed Out"
    end
  end
end

defmodule Monitor do
  import :timer, only: [sleep: 1]

  def sad_fn do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor, :sad_fn, [])
    IO.puts "Response => #{inspect res}"
    receive do
      msg ->
        IO.puts "Msg => #{inspect msg}"
      after 1000 ->
        IO.puts "Timed Out"
    end
  end
end

Link1.run
Monitor.run

# So, when do you use links and when should you choose monitors?
# If the intent is that a failure in one process should terminate another,
  # then you need links.
# If instead you need to know when some other process exits for any reason,
  # choose monitors.
