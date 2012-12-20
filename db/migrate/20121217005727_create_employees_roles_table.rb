class CreateEmployeesRolesTable < ActiveRecord::Migration
  def up
     create_table :employees_roles, :id => false do |t|
         t.integer :role_id
          t.integer :employee_id
        end
   end

   def down
     drop_table :employees_roles
   end
 end
  