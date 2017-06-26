defmodule Navii.Responders.Currency do
  use Hedwig.Responder
  require Logger

  @currencies [
    "EUR", "USD", "JPY", "BGN", "CZK", "DKK", "GBP", "HUF", "LTL", "PLN", "RON",
    "SEK", "CHF", "NOK", "HRK", "RUB", "TRY", "AUD", "BRL", "CAD", "CNY", "HKD",
    "IDR", "ILS", "INR", "KRW", "MXN", "MYR", "NZD", "PHP", "SGD", "THB", "ZAR",
  ]

  @currency_choices Enum.join(@currencies, "|")

  respond ~r/convert ?([0-9.]+) ?(#{@currency_choices}) (?:into|in|to)? ?(#{@currency_choices})/i, msg do
    {_amount, _} = Float.parse(msg.matches[1])
    from = String.upcase(msg.matches[2])
    to = String.upcase(msg.matches[3])

    _exchange = fetch_rates(from, to)

    send msg, "TODO"
  end

  defp fetch_rates(_from, _to) do
    url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
    headers = [{"User-Agent", "Mozilla/5.0"}]

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        Logger.warn inspect(body)
      {_, res} ->
        Logger.warn inspect(res)
    end
  end
end