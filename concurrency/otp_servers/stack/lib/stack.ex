defmodule Stack do

  @server Stack.Server

  def start_link(current_number) do
    GenServer.start_link(@server, current_number, name: @server)
  end

  def add_to_stack(val) do
    GenServer.call(@server, {:push, val})
  end

  def remove_from_stack do
    GenServer.call(@server, :pop)
  end

end
