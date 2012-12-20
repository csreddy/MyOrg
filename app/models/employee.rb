class Employee < ActiveRecord::Base
  include Gravtastic
  gravtastic  :default => "http://cdn1.iconfinder.com/data/icons/dragon/128/User.png",
              :size => 160
              
            # http://cdn1.iconfinder.com/data/icons/dragon/128/User.png  
            #  http://s3.amazonaws.com/twitvid-channel-avatars/4f8daf56e6438.1.jpg  
            #  http://www.techinasia.com/techinasia/wp-content/uploads/2009/11/facebook-avatar.png
   
  attr_accessible :name, :role, :role_ids, :email, :bio, :avatar
  has_and_belongs_to_many :roles
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end
