class ChangeProductImgToText < ActiveRecord::Migration[7.2]
  def change
    change_column :products, :product_img, :text
  end
end
