defmodule ExecutionOrder do
  use GenServer
  require Logger

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def do_something(pid) do
    GenServer.cast(pid, :do)
  end

  def do2_something(pid) do
    GenServer.cast(pid, :do2)
  end

  def get_something(pid) do
    GenServer.call(pid, :get)
  end

  def init([]) do
    {:ok, pid} = Callback.start_link();
    {:ok, %{val1: 0, val2: 0, callback: pid}}
  end

  def handle_cast(:do, state) do
    Callback.go_loopy(state.callback, self())
    Logger.debug fn -> to_stringy(state) end
    {:noreply, Map.put(state, :val1, state.val1+1)}
  end

  def handle_cast(:do2, state) do
    Logger.debug fn -> to_stringy(state) end
    {:noreply, Map.put(state, :val2, state.val2+1)}
  end

  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  def to_stringy(state) do
    "val1: #{state.val1}: val2: #{state.val2}"
  end
end
