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

require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
