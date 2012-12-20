class Role < ActiveRecord::Base
  attr_accessible :title, :employee_ids
    has_and_belongs_to_many :employees
end
