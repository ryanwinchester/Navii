defmodule Navii.Responders.Debugger do
  use Hedwig.Responder

  require Logger

  respond ~r/what channel( is (this|it))?\??/i, msg do
    reply msg, "We are in #{msg.room}."
  end

  respond ~r/who ?am ?i\??/i, msg do
    reply msg, "You are #{msg.user.name} (#{msg.user.id})."
  end
end
