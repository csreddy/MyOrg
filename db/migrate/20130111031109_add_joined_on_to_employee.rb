class AddJoinedOnToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :joined_on, :date
  end
end
