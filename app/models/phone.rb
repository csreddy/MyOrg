class Phone < ActiveRecord::Base
  attr_accessible :employee_id, :phone_type, :phone_number, :phone
  belongs_to :employee
  validates :phone_number,
            :format => { :with => /^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/,
                        :message => "Invalid phone number" 
                      }  
end
