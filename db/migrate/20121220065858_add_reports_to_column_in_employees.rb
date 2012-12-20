class AddReportsToColumnInEmployees < ActiveRecord::Migration
  def change
    add_column :employees, :reportsto, :string
  end
end
