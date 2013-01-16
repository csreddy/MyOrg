# == Schema Information
#
# Table name: phones
#
#  id           :integer          not null, primary key
#  employee_id  :integer
#  phone_number :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  phone_type   :string(255)
#

require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
