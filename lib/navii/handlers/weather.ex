defmodule Navii.Weather do
  use Kuma.Handler

  def handle_info({:mentioned, msg, %SenderInfo{nick: nick}, channel}, conn) do
    location = Regex.run(~r/Navii.? (.+)/, capture: :all_but_first)
    key = System.get_env("OPENWEATHER_KEY")

    res = :httpc.request("http://api.openweathermap.org/data/2.5/weather?q=#{location}&APPID=#{key}")

    Logger.debug res

    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn), do: {:noreply, conn}
end
