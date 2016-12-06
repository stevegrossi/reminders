defmodule Reminders.Client do
  use GenServer
  alias Reminders.Store

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(state) do
    run_clock()
    {:ok, state}
  end

  def remind_me(message, seconds_in_future) do
    GenServer.cast(__MODULE__, {:new, message, seconds_in_future})
  end

  defp run_clock do
    Process.send_after(self(), :tick, :timer.seconds(1))
  end

  # Callbacks

  def handle_cast({:new, message, seconds_in_future}, state) do
    remind_at = :os.system_time(:seconds) + seconds_in_future
    Store.save({message, remind_at})
    {:noreply, state}
  end

  def handle_info(:tick, state) do
    Enum.each(Store.pop_past_reminders, fn({message, _timestamp}) ->
      IO.puts("REMINDER: #{message}")
    end)
    run_clock()
    {:noreply, state}
  end

end
