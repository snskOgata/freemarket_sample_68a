class DeliveryPayer < ActiveHash::Base
  self.data = [
      {id: 1, type: '送料込み(出品者負担)'}, {id: 2, type: '着払い(購入者負担)'}
  ]
end
