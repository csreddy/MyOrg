class AddBioToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :bio, :text
  end
end
