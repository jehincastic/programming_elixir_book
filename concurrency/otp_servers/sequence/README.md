# Sequence

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sequence` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sequence, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/sequence>.

# To start
```elixir
  {:ok, pid} = GenServer.start_link(Sequence.Server, 100)
  GenServer.call(pid, :next_number) # 100
  GenServer.call(pid, :next_number) # 101
  GenServer.call(pid, :next_number) # 102
  GenServer.call(pid, :next_number) # 103
  GenServer.call(pid, :next_number) # 104
  GenServer.call(pid, :next_number) # 105
  GenServer.cast(pid, {:increment_number, 10}) # :ok
  GenServer.call(pid, :next_number) # 116
```

# To start with a name
```elixir
  {:ok, _pid} = GenServer.start_link(Sequence.Server, 100, name: :seq)
  GenServer.call(:seq, :next_number) # 100
  GenServer.call(:seq, :next_number) # 101
  GenServer.call(:seq, :next_number) # 102
  GenServer.call(:seq, :next_number) # 103
  GenServer.call(:seq, :next_number) # 104
  GenServer.call(:seq, :next_number) # 105
  GenServer.cast(:seq, {:increment_number, 10}) # :ok
  GenServer.call(:seq, :next_number) # 116
```

# To trace data of genserver
```elixir
  {:ok, pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
  :sys​.trace pid, true # trace can be enabled for an existing server
  :sys​.trace pid, false # trace can be disabled for an existing server
  :sys​.get_status pid # to get current status of Genserver (this output can be updated by this fn format_status)
```

# To get statistics of genserver
```elixir
  {:ok, pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:statistics]])
  :sys.statistics pid, :get
  """
  {:ok,
    [
      start_time: {{2017, 12, 23}, {14, 6, 7}},
      current_time: {{2017, 12, 23}, {14, 6, 24}},
      reductions: 36,
      messages_in: 2,
      messages_out: 0
    ]
  }
  # Time stamp format {{y,m,d},{h,m,s}}
  # reductions is the measure of the amount of work the server does. It is used in process scheduling as a way of making sure all processes get a fair share of the available CPU
  """
```