class Department < ActiveRecord::Base
  attr_accessible :name
  has_many :employees, :dependent => :nullify
  
  self.per_page = 30
end
