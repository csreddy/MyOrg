class AddDobToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :dob, :date
  end
end
