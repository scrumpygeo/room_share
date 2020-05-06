class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :rooms, :address, :street
  end
end
