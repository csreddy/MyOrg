class RenameColumnEmailIdInEmployees < ActiveRecord::Migration
  def change
      rename_column :employees, :emailId, :email
    end
end
