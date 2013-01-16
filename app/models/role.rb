# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Role < ActiveRecord::Base
  attr_accessible :title, :employee_ids
  validates :title, 
            :presence => true, 
            :uniqueness => true,
            :format => { :with => /^[^`!@#\$%\^&*+_=]+$/,
                         :message => "No speacial characters allowed" 
                       }
  
  has_and_belongs_to_many :employees
  
  self.per_page = 30
end
