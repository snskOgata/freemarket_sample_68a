class PrepDays < ActiveHash::Base
  self.data = [
      {id: 1, type: '1~2日で発送'}, {id: 2, type: '2~3日で発送'},
      {id: 3, type: '4~7日で発送'}
  ]
end
