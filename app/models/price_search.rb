class PriceSearch < ActiveHash::Base
  self.data = [
      {id: 1, name: '300 ~ 1000', price_gl: "q[price_gteq: 300], q[price_lteq: 1000]"},
      {id: 2, name: '1000 ~ 5000', price_gl: "q[price_gteq: 1000], q[price_lteq: 5000]"},
      {id: 3, name: '5000 ~ 10000', price_gl: "q[price_gteq: 5000], q[price_lteq: 10000]"},
      {id: 4, name: '10000 ~ 30000', price_gl: "q[price_gteq: 10000], q[price_lteq: 30000]"},
      {id: 5, name: '30000 ~ 50000', price_gl: "q[price_gteq: 30000], q[price_lteq: 50000]"},
      {id: 6, name: '50000 ~', price_gl: "q[price_gteq: 50000]"}
  ]
end
