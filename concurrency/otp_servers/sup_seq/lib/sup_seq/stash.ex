defmodule SupSeq.Stash do
  use GenServer

  @me __MODULE__

  def start_link(initital_num) do
    GenServer.start_link(@me, initital_num, name: @me)
  end

  def get do
    GenServer.call(@me, { :get })
  end

  def update_number(new_number) do
    GenServer.cast(@me, { :update, new_number })
  end

  def init(initial_num) do
    { :ok, initial_num }
  end

  def handle_call({ :get }, _from, curr_num) do
    { :reply, curr_num, curr_num }
  end

  def handle_cast({ :update, new_num }, _state) do
    { :noreply, new_num }
  end
end
