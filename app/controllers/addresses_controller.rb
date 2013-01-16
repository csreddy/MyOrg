class AddressesController < ApplicationController
  def show_map
    @json = Address.all.to_gmaps4rails do |address, marker|
       marker.json({ :street_name => address.street_name, :city => address.city })
    end    
  end
  
  
end
