class AddDefaultValueToRatingValueInProducts < ActiveRecord::Migration[7.2]
  def change
    change_column_default :products, :rating_value, 0.0
  end
end
