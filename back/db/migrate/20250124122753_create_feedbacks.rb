class CreateFeedbacks < ActiveRecord::Migration[7.2]
  def change
    create_table :feedbacks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.decimal :rating_value, precision: 3, scale: 2, null: false, default: 0.0
      t.text :comment

      t.timestamps
    end
  end
end
