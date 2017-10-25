defmodule Callback do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok)
  end

  def go_loopy(pid, other_pid) do
    GenServer.cast(pid, {:go_loopy, pid, other_pid})
  end

  def go_loopier(pid, other_pid) do
    GenServer.cast(pid, {:go_loopier, other_pid})
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast({:go_loopy, pid, other_pid}, state) do
    go_loopier(pid, other_pid)
    {:noreply, state}
  end

  def handle_cast({:go_loopier, other_pid}, state) do
    ExecutionOrder.do2_something(other_pid)
    {:noreply, state}
end

end