defmodule Navii.Responders.Admin do
  use Hedwig.Responder

  require Logger

  respond ~r/deploy now$/, msg do
    if is_admin?(msg.user) do
      Logger.warn "Deploying now..."
      System.cmd "curl", [Config.get_env(:navii, :deployhook)]
      send msg, "Yes, sir. (╭ರᴥ•́)"
    else
      Logger.warn "Loser trying to deploy..."
      send msg, "No, sir. ಠ_ರೃ"
    end
  end

  respond ~r/kick ([^\s]+) from #([^\s]+)$/, msg do
    if is_admin?(msg.user) do
      kickee = msg.matches[1]
      channel = msg.matches[2]
      pmsg = %{msg | room: "Chanserv"}
      cmsg = %{msg | room: channel}
      send msg, "kicking #{kickee} from ##{channel} ᕕ( ᐛ )ᕗ"
      send pmsg, "op ##{channel}"
      :timer.sleep(1000)
      send cmsg, "/kick #{kickee}"
      send pmsg, "deop ##{channel}"
    else
      send msg, "No, sir. ಠ_ರೃ"
    end
  end

  @doc """
  Check if the user is an admin.
  """
  @spec is_admin?(Hedwig.User.t | String.t) :: boolean
  def is_admin?(%{id: id}) do
    id
    |> String.split("@")
    |> Enum.at(0)
    |> is_admin?()
  end

  def is_admin?(user) when is_binary(user) do
    Config.get_env(:navii, :admins, "")
    |> String.split(",")
    |> Enum.any?(&String.equivalent?(&1, user))
  end
end
