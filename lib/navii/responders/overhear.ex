defmodule Navii.Responders.Overhear do
  use Hedwig.Responder

  hear ~r/^just do it,?(?: \w+)?$/, msg do
    send msg, "https://www.youtube.com/watch?v=hAEQvlaZgKY"
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