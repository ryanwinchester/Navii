defmodule Navii.Robot do
  use Hedwig.Robot, otp_app: :navii

  def handle_connect(%{name: name} = state) do
    if :undefined == :global.whereis_name(name) do
      :yes = :global.register_name(name, self())
    end

    {:ok, state}
  end

  def handle_disconnect(_reason, state) do
    {:reconnect, 5000, state}
  end

  def handle_in([_cmd, "\r\n"] = cmd, state) do
    {:dispatch, cmd, state}
  end

  def handle_in(%Hedwig.Message{} = msg, state) do
    {:dispatch, msg, state}
  end

  def handle_in(_msg, state) do
    {:noreply, state}
  end

  @doc """
  Send an emote message via the robot.
  """
  def emote(pid, msg) do
    GenServer.cast(pid, {:command, msg})
  end

  def handle_cast({:command, msg}, %{adapter: adapter} = state) do
    __adapter__().command(adapter, msg)
    {:noreply, state}
  end
end
