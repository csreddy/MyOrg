class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_name
      t.string :apt
      t.string :city
      t.string :state
      t.string :apt

      t.timestamps
    end
  end
end
