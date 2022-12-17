defmodule Exercise do
    def span(from, to) when from > to, do: []
    def span(from, to), do: [from | span(from + 1, to)]
end

list = for x <- Exercise.span(1, 100),
    Enum.all?(
        Exercise.span(2, Enum.max([2, x-1])),
        fn v -> rem(x, v) > 0 end
    ),
    do: x


IO.inspect list

tax_rates = [ NC: 0.075, TX: 0.08 ]
orders = [
    [ id: 123, ship_to: :NC, net_amount: 100.00 ],
    [ id: 124, ship_to: :OK, net_amount:  35.50 ],
    [ id: 125, ship_to: :TX, net_amount:  24.00 ],
    [ id: 126, ship_to: :TX, net_amount:  44.80 ],
    [ id: 127, ship_to: :NC, net_amount:  25.00 ],
    [ id: 128, ship_to: :MA, net_amount:  10.00 ],
    [ id: 129, ship_to: :CA, net_amount: 102.00 ],
    [ id: 130, ship_to: :NC, net_amount:  50.00 ]
]

add_total_amount = fn (order = [id: _ , ship_to: state , net_amount: net], tax_rates) ->
    tax_rate = Keyword.get(tax_rates, state, 0)
    total = net*(1.0+tax_rate)
    Keyword.put(order, :total_amount, total)
end

calc_tax = fn (orders_list, tax_values) ->
    orders
    |> Enum.map(&(add_total_amount.(&1, tax_rates)))
end

IO.inspect calc_tax.(orders, tax_rates)
