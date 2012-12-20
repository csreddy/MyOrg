class AddAvatarColumnsToEmployees < ActiveRecord::Migration
  def change
    add_attachment :employees, :avatar
  end
end
