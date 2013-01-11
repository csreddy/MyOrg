class Employee < ActiveRecord::Base
  include Gravtastic
  gravtastic  :default => "http://cdn1.iconfinder.com/data/icons/dragon/128/User.png",
              :size => 160
              
            # http://cdn1.iconfinder.com/data/icons/dragon/128/User.png  
            #  http://s3.amazonaws.com/twitvid-channel-avatars/4f8daf56e6438.1.jpg  
            #  http://www.techinasia.com/techinasia/wp-content/uploads/2009/11/facebook-avatar.png
   
  attr_accessible :name, :role, :role_ids, :email, :bio, :avatar, :employee_ids, :address, :department_id, :dob, :joined_on, :address_attributes, :phones_attributes
  validates :name, 
            :presence => true, 
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/,
                         :message => "Only letters allowed" 
                       }
  
    validates :email,   
              :presence => true,   
              :uniqueness => true,   
              :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
                                             
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :employees, 
                          :join_table => "employees_connections",
                          :foreign_key => "employee_a_id",
                          :association_foreign_key => "employee_b_id"

  belongs_to :department
  has_one :address,  :dependent => :destroy
  has_many :phones, :dependent => :destroy
  accepts_nested_attributes_for :address, :reject_if => lambda { |a| a[:street_name].blank? },  :allow_destroy => true
  accepts_nested_attributes_for :phones, :reject_if => lambda { |p| p[:phone_number].blank? }, :allow_destroy => true
  
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  

  self.per_page = 10
  
  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
 
  
 
end
