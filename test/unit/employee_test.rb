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
#  personal_email      :string(255)
#  manager_id          :integer
#  sex                 :string(255)
#

require 'test_helper'

class EmployeeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
