class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string     :postage_code,  null: false
      t.integer    :prefecture_id, null: false
      t.string     :municipality,  null: false
      t.string     :house_num,     null: false
      t.string     :building_name
      t.string     :telephone_num, null: false
      t.references :buy,           null: false, foreign_key: true
      t.timestamps
    end
  end
end
