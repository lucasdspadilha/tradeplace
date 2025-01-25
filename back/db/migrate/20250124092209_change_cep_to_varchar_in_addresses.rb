class ChangeCepToVarcharInAddresses < ActiveRecord::Migration[7.2]
  def change
    change_column :addresses, :cep, :string
  end
end
