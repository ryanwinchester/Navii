defmodule Navii.Responders.Weather do
  @moduledoc """
  Responds to 'weather :location' with the weather for that location.
  """

  use Hedwig.Responder
  require Logger

  defmodule Geo do
    defstruct [
      lat: 49.06454489999999,
      lng: -122.2556566,
      text: "Abbotsford, BC, Canada",
    ]
  end

  defmodule Weather do
    defstruct [:geo, :temperature, :humidity, :currently, :hourly, :daily]
  end

  respond ~r/weather(?: (.+))?$/i, msg do
    weather =
      msg.matches[1]
      |> get_geo()
      |> get_weather()
      |> format_weather()
      |> replace_temps()

      send msg, weather
  end

  # Get the geographic info from Google Maps
  defp get_geo(nil), do: %Geo{}
  defp get_geo([loc | _]), do: get_geo(loc)
  defp get_geo(loc) do
    geo_url = "http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=#{URI.encode(loc)}"

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
        Logger.debug inspect(weather["currently"])
        %Weather{
          geo: geo,
          temperature: weather["currently"]["temperature"],
          humidity: weather["currently"]["humidity"],
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
    Weather for #{weather.geo.text}: #{weather.currently}. #{weather.temperature}°F #{round(weather.humidity * 100)}% humidity. #{weather.hourly} #{weather.daily}
    """
  end

  # Replace temps in F in a string to C/F
  defp replace_temps(str) do
    Regex.replace(~r/(\d+(?:\.\d+)?) ?°F/, str, fn _, temp ->
      {deg_f, _} = Float.parse(temp)
      deg_c = ((deg_f - 32) * (5/9)) |> round()
      deg_f = round(deg_f)
      "#{deg_c}°C (#{deg_f}°F)"
    end)
  end
end