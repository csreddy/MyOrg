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
#

class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street_name, :apt, :zip, :country, :employee_id
  belongs_to :employee
            
  validates :zip, 
            :format => { :with => /^[0-9]{5}(-[0-9]{4})?$/,
                         :message => "Invalid zip code format" 
                       }
  acts_as_gmappable           
  
  def gmaps4rails_address
  #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki
    "#{self.street_name}, #{self.city}, #{self.country}" 
  end
           
           
  def gmaps4rails_infowindow
    # add here whatever html content you desire, it will be displayed when users clicks on the marker
    "<table>
      <tr>
        <td align=\"center\"><a class='thumbnail'><img src=#{show_avatar}'></a></td>
        <td align=\"center\">
        <a href=\"http://localhost:3000/employees/#{self.employee_id}\">#{self.employee.name}<br/></a>
        #{self.employee.address.city}, #{self.employee.address.state}
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
