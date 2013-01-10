class AddIdToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :employee_id, :integer
  end
end
