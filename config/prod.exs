use Mix.Config

config :hedwig_weather,
  location: System.get_env("LOCATION"),
  darksky_key: System.get_env("DARKSKY_KEY")

config :hedwig_youtube,
  youtube_key: System.get_env("YOUTUBE_KEY")
