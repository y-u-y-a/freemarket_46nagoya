class BusinessStatus < ActiveHash::Base
  self.data = [
      {id: 0, name: 'すべて'},  {id: 1, name: '販売中'},
      {id: 3, name: '売り切れ'}
    ]
end
