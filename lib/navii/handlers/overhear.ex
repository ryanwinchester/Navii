defmodule Navii.Overhear do
  use Kuma.Handler

  def handle_info({:received, msg, _sender_info, channel}, conn) do
    cond do
      match? ~r/srsly guise|seriously,? guys/, msg ->
        Bot.send srsly_guise_img(), channel
      match? ~r/^just do it,?(?: \w+)?/, msg ->
        Bot.send "https://www.youtube.com/watch?v=hAEQvlaZgKY", channel
      match? ~r/┻━┻/, msg ->
        Bot.send "┬──┬◡ﾉ(° -°ﾉ)", channel
    end
    {:noreply, conn}
  end

  # Catch-all for messages you don't care about
  def handle_info(_msg, conn), do: {:noreply, conn}

  defp srsly_guise_img() do
    Enum.random([
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
