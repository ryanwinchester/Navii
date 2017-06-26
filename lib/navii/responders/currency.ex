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
    {amount, _} = Decimal.new(msg.matches[1])
    from = String.upcase(msg.matches[2])
    to = String.upcase(msg.matches[3])

    converted = get_converted(amount, fetch_rates(from, to))
    amount = Decimal.round(amount, 2) |> Decimal.to_string()

    send msg, "#{amount} #{from} is #{converted} #{to}"
  end

  # Fetch the exchange rates
  defp fetch_rates(from, to) do
    url = "http://www.ecb.europa.eu/stats/eurofxref/eurofxref-daily.xml"
    headers = [{"User-Agent", "Mozilla/5.0"}]

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        [from_rate | _] = Regex.run(~r/currency='#{from}' rate='(.+)'/, body, capture: :all_but_first)
        [to_rate | _] = Regex.run(~r/currency='#{to}' rate='(.+)'/, body, capture: :all_but_first)
        {Decimal.new(from_rate), Decimal.new(to_rate)}
      {_, res} ->
        Logger.warn inspect(res)
        :error
    end
  end

  defp get_converted(amount, {from_rate, to_rate}) do
    amount
    |> Decimal.div(from_rate)
    |> Decimal.mult(to_rate)
    |> Decimal.round(2)
    |> Decimal.to_string()
  end
end