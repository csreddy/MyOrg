class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.integer :employee_id
      t.string :phone_number

      t.timestamps
    end
  end
end
