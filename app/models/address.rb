# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  street_name :string(255)
#  apt         :string(255)
#  city        :string(255)
#  state       :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  employee_id :integer
#  zip         :string(255)
#  latitude    :float
#  longitude   :float
#  gmaps       :boolean
#  country     :string(255)
#

class Address < ActiveRecord::Base
  validate  :validate_address, :on => :create
  attr_accessible :city, :state, :street_name, :apt, :zip, :country, :employee_id
  belongs_to :employee

  validates_format_of :street_name, :with => /^(?:[^\W_]|\s)*$/u , :message => "Invalid Street"     
 # validates_format_of :apt, :with => /^[-a-z]+$/,  :message => "Invalid Apt number"     
  validates_format_of :city, :with => /^(?:[^\W_]|\s)*$/u,  :message => "Invalid City"              

  validates :zip, 
            :format => { :with => /^[0-9]{5}(-[0-9]{4})?$/,
                         :message => "Invalid zip code format" 
                       }
  acts_as_gmappable :check_process => false, :validation => true          
  
  
  def validate_address
    require 'net/http'
   street = self.street_name.gsub(" ", "%20") unless self.street_name.blank?
   apt = self.apt.gsub(" ", "%20") unless self.apt.blank?
   city = self.city.gsub(" ", "%20") unless self.city.blank?
   state =  self.state.gsub(" ", "%20") unless self.state.blank?
   zip = self.zip.gsub(" ", "20") unless self.zip.blank?
   country = self.country.gsub(" ", "%20") unless self.country.blank?
 
   # "http://maps.googleapis.com/maps/api/geocode/json?language=en&address=#{street}&sensor=false"
  
    url = Net::HTTP.get(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?language=en&address=#{street}#{city}#{state}#{zip}#{country}&sensor=false")) 
    result = JSON[url]
   if (result["status"] == "ZERO_RESULTS")
      errors.add(:street_name, "Invalid address! Please check")       
   else
     return true
   end
  end

  
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.street_name}, #{self.city}, #{self.zip}, #{self.country}" 
  end
           
           
  def gmaps4rails_infowindow
    # add here whatever html content you desire, it will be displayed when users clicks on the marker
    "<table>
      <tr>
        <td align=\"center\"><a class='thumbnail'><img src=#{show_avatar}'></a></td>
        <td align=\"center\">
        <a href=\"http://localhost:3000/employees/#{self.employee_id}\">#{self.employee.name}<br/></a>
        #{self.employee.address.city}, #{self.employee.address.state} <br/> #{self.employee.address.country}
        </td>
      </tr>
  
    </table>"
#    "<a href=\"http://localhost:3000/employees/#{self.employee_id}\">#{self.employee.avatar.url(:thumb)}</a>"
      end
      
    
      def gmaps4rails_title
           # add here whatever text you desire
           "test"
         end
           
         def show_avatar
           if self.employee.avatar.exists?  
              self.employee.avatar.url(:thumb)
           else
             self.employee.gravatar_url
           end
         end
          
         
                 
end
