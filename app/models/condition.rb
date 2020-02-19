class Condition < ActiveHash::Base
  self.data = [
      {id: 1, type: '新品、未使用'}, {id: 2, type: '未使用に近い'},
      {id: 3, type: '目立った傷や汚れなし'}, {id: 4, type: 'やや傷や汚れあり'},
      {id: 5, type: '傷や汚れあり'}, {id: 6, type: '全体的に状態が悪い'}
  ]
end
