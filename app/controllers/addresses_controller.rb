class AddressesController < ApplicationController
   
  def show_map
    @json = Address.all.to_gmaps4rails do |address, marker|
       marker.json({ :street_name => address.street_name, :city => address.city, :state => address.state, :zip => address.zip, :country => address.country })
    end    
  end
  
  def validate_address
    require 'net/http'
  #  address = [employee.street_name, employee.apt, employee.city, employee.state, employee.zip, employee.country]
  #  address.each do |a|
  #    a.gsub(" ", "%20")
  #  end
 
   street = self.street_name.gsub(" ", "%20") unless self.street_name.blank?
   apt = self.apt.gsub(" ", "%20") unless self.apt.blank?
   city = self.city.gsub(" ", "%20") unless self.city.blank?
   state =  self.state.gsub(" ", "%20") unless self.state.blank?
   zip = self.zip.gsub(" ", "20") unless self.zip.blank?
   country = self.country.gsub(" ", "%20") unless self.country.blank?
 
   # "http://maps.googleapis.com/maps/api/geocode/json?language=en&address=#{street}&sensor=false"
  
    url = Net::HTTP.get(URI.parse("http://maps.googleapis.com/maps/api/geocode/json?language=en&address=#{street}&sensor=false")) 
    result = JSON[url]
   if (result["status"] == "ZERO_RESULTS")
     # errors.add(:name, "Invalid address") 
  "Invalid address"         
   else
     return true
   end
  end
end
