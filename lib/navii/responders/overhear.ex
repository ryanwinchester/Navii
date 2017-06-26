defmodule Navii.Responders.Overhear do
  @moduledoc """
  Listends for specific patterns in order to respond with something whimsical.

  ### Examples

      User> (╯°□°）╯︵ ┻━┻
      alfred> ┬──┬◡ﾉ(° -°ﾉ)

      User> Seriously guys, this is important
      alfred> http://i.imgur.com/0lyao5E.gif

  """

  use Hedwig.Responder

  hear ~r/^\^5 (.+)$/, msg do
    recipient = msg.matches[1]
    emote msg, "high fives #{recipient}"
  end

  hear ~r/^just do it,?(?: (\w+))?$/, msg do
    if msg.matches[1] do
      send msg, "#{msg.matches[1]}: https://www.youtube.com/watch?v=hAEQvlaZgKY"
    else
      send msg, "https://www.youtube.com/watch?v=hAEQvlaZgKY"
    end
  end

  hear ~r/┻━┻/, msg do
    send msg, "┬──┬◡ﾉ(° -°ﾉ)"
  end

  hear ~r/srsly guise|seriously,? guys/, msg do
    send msg, Enum.random([
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/0lyao5E.gif",
      "http://i.imgur.com/xU7AhQh.gif",
      "http://i.imgur.com/dpFlIMx.gif",
      "http://i.imgur.com/mE2oDmm.gif",
      "http://i.imgur.com/ersspRE.gif",
    ])
  end
end