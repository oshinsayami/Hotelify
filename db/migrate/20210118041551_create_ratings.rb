class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.string :description
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :hotel, null: false, foreign_key: true

      t.timestamps
    end
  end
end
