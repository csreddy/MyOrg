class Role < ActiveRecord::Base
  attr_accessible :title, :employee_ids
  validates :title, 
            :presence => true, 
            :uniqueness => true,
            :format => { :with => /\A[a-zA-Z]+\z/,
                         :message => "Only letters allowed" 
                       }
  
  has_and_belongs_to_many :employees
    
end
