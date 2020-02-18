class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string      :lastname,	     null:false
      t.string      :firstname,      null:false
      t.string      :lastname_kana,	 null:false
      t.string      :firstname_kana, null:false
      t.date        :birthday,	     null:false
      t.references  :user,        	 foreign_key: true
      t.timestamps
    end
  end
end
