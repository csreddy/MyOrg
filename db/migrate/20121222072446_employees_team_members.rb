class EmployeesTeamMembers < ActiveRecord::Migration
  def up
    create_table :employees_teammembers, :id => false do |t|
      t.integer :employee_b_id, :null => false
      t.integer :employee_a_id, :null => false
    end
  end

  def down
    drop_table :employees_teammembers
  end
end
  