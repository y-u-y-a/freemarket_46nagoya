class ShippingMethod < ActiveHash::Base
  self.data = [
      {id: 0, name: 'すべて'},  {id: 1, name: '未定'},
      {id: 2, name: 'クロネコヤマト'}, {id: 3, name: 'ゆうパック'}, {id: 4, name: 'ゆうメール'},
    ]
end
