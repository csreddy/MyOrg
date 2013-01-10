class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street_name, :apt, :zip
  belongs_to :employee
            
  validates :zip, 
            :format => { :with => /^[0-9]{5}(-[0-9]{4})?$/,
                         :message => "Invalid zip code format" 
                       }
                       
                     
end
