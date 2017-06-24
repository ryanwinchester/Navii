defmodule Navii.Weather do
  defmodule Geo do
    defstruct [
      lat: 49.06454489999999,
      lng: -122.2556566,
      text: "Abbotsford, BC, Canada",
    ]
  end

  defmodule Weather do
    defstruct [:geo, :currently, :hourly, :daily]
  end

  use Kuma.Handler

  @doc """
  Get the current weather for a location.
  """
  def handle_info({:mentioned, msg, %SenderInfo{nick: _nick}, channel}, conn) do
    regex = ~r/^Navii.? weather(?: (.+))?$/i

    if Regex.match? regex, msg do
      regex
      |> Regex.run(msg, capture: :all_but_first)
      |> get_geo()
      |> get_weather()
      |> format_weather()
      |> Bot.send(channel)
    end

    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn), do: {:noreply, conn}

  # Get the geographic info from Google Maps
  defp get_geo(nil), do: %Geo{}
  defp get_geo(loc) do
    geo_url = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{loc}"

    case HTTPoison.get(geo_url) do
      {:ok, %{status_code: 200, body: body}} ->
        %{"results" => [res | _]} = Poison.decode!(body)
        %Geo{
          lat: res["geometry"]["location"]["lat"],
          lng: res["geometry"]["location"]["lng"],
          text: res["formatted_address"],
        }
      {_, _} ->
        %Geo{lat: nil, lng: nil}
    end
  end

  # Get the weather info from Darksky
  defp get_weather(%Geo{lat: lat, lng: lng} = geo) do
    key = System.get_env("DARKSKY_KEY")
    darksky_url = "https://api.darksky.net/forecast/#{key}/#{lat},#{lng}"

    case HTTPoison.get(darksky_url) do
      {:ok, %{status_code: 200, body: body}} ->
        weather = Poison.decode!(body)
        %Weather{
          geo: geo,
          currently: weather["currently"]["summary"],
          hourly: weather["hourly"]["summary"],
          daily: weather["daily"]["summary"],
        }
      {_, res} ->
        Logger.warn inspect(res)
        %Weather{}
    end
  end

  # Format the weather info into a nice string
  defp format_weather(%Weather{currently: nil}), do: "No idea..."
  defp format_weather(%Weather{} = weather) do
    """
    Weather for #{weather.geo.text}: #{weather.currently}. #{weather.hourly} #{weather.daily}
    """
  end
end
