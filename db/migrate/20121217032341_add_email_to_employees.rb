class AddEmailToEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :emailId, :string
  end  
end
