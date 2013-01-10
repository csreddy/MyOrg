class AddPhoneTypeToPhones < ActiveRecord::Migration
  def change
    add_column :phones, :phone_type, :string
  end
end
