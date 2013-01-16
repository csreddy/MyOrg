# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :employees, :dependent => :nullify
  
  self.per_page = 30
end
