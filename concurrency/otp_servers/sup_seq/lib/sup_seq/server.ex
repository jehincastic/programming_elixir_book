defmodule SupSeq.Server do

  use GenServer

  # External API
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def next_number do
    GenServer.call __MODULE__, :next_number
  end

  def increment_number(delta) do
    GenServer.cast __MODULE__, { :increment_number, delta }
  end

  def init(_) do
    { :ok, SupSeq.Stash.get }
  end

  def handle_call(:next_number, _from, curr_number) do
    { :reply, curr_number, curr_number + 1 }
  end

  def handle_call({ :set_number, new_number }, _from, _curr_number) do
    { :reply, new_number, new_number }
  end

  def handle_cast({ :increment_number, delta }, curr_number) do
    { :noreply, curr_number + delta }
  end

  def format_status(_reason, [_pdict, state]) do
    [data: [{'State', "My current state is '#{inspect state}', and I'm happy"}]]
  end

  def terminate(_reason, curr_num) do
    SupSeq.Stash.update_number(curr_num)
  end
end
