class CreateBrands < ActiveRecord::Migration[6.1]
  def change
    create_table :brands do |t|
      t.string :name
      t.boolean :in_stock
      t.belongs_to :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
