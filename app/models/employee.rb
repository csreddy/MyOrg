# == Schema Information
#
# Table name: employees
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  role                :string(255)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  email               :string(255)
#  bio                 :text
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  reportsto           :string(255)
#  department_id       :integer
#  joined_on           :date
#  dob                 :date
#

class Employee < ActiveRecord::Base
 
  
  include Gravtastic
  gravtastic  :default => "http://cdn1.iconfinder.com/data/icons/dragon/128/User.png",
              :size => 120
              
            # http://cdn1.iconfinder.com/data/icons/dragon/128/User.png  
            #  http://s3.amazonaws.com/twitvid-channel-avatars/4f8daf56e6438.1.jpg  
            #  http://www.techinasia.com/techinasia/wp-content/uploads/2009/11/facebook-avatar.png
   
  attr_accessible :name, :role, :role_ids, :email, :personal_email, :bio, :avatar, :employee_ids, :address, :department_id, :dob, :joined_on, :address_attributes, :phones_attributes
  
  validates :name, 
            :presence => true, 
            :format => { :with => /^[^0-9`!@#\$%\^&*+_=]+$/,
                         :message => "Only letters allowed" 
                       }
  
    validates :email,   
              :presence => true,   
              :uniqueness => true,   
              :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }  
  
  
  # validates :personal_email,   
  #           :uniqueness => true,   
  #           :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }              
                                             
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
  
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" , :stamp => "20x20>"}
  

  self.per_page = 25
  

  
  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
  
 
end
