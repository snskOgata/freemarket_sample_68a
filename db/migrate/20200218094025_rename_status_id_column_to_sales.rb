class RenameStatusIdColumnToSales < ActiveRecord::Migration[5.2]
  def change
    rename_column :sales, :status_id, :status
  end
end
