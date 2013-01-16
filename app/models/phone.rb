# == Schema Information
#
# Table name: phones
#
#  id           :integer          not null, primary key
#  employee_id  :integer
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phone_type   :string(255)
#

class Phone < ActiveRecord::Base
  attr_accessible :employee_id, :phone_type, :phone_number, :phone
  belongs_to :employee
  validates :phone_number,
            :format => { :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
                        :message => "Invalid phone number" 
                      }  
end
