namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
   Rake::Task["db:add_depts"].invoke
    Employee.delete_all
    Role.delete_all
#    @roles = Array["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
 #   @roles.each do |role|
  #    r = Role.create :title => role
  #    r.save 
      
      Employee.populate(10) do |employee|      
      employee.name = Faker::Name.name  
      employee.bio = Populator.sentences(2..10)
    #  employee.role_ids = Role.last.id
      employee.department_id = Department.find(1+rand(9)).id
      employee.email = Faker::Internet.email
      employee.joined_on = Time.at(rand * Time.now.to_i).strftime("%m-%d-%Y")
      employee.dob = Time.at(rand * Time.now.to_i).strftime("%m-%d-%Y")
    #  employee.phones.create(:phone_type => 'Home', :phone_number => Faker::PhoneNumber.phone_number)
    #  employee.phones.create(:phone_type => 'Mobile', :phone_number => Faker::PhoneNumber.phone_number)
    
    Phone.populate(1..3) do |phone|
        phone.employee_id = employee.id
        phone.phone_type = ["Home", "Office", "Mobile"]
        phone.phone_number = Faker::PhoneNumber.cell_phone
      end
      
      Address.populate(1) do |address|
        address.employee_id = employee.id
        address.street_name = Faker::Address.street_address 
        address.apt =  Faker::Address.building_number
        address.city = Faker::Address.city
        address.state = Faker::Address.state_abbr
        address.zip = Faker::Address.zip_code
      end
      
#      Role.populate(1) do |role|
#        role.id = employee.id
#        role.title = ["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
#     end
      Rake::Task["db:add_roles"].invoke 
     Rake::Task["db:assign_roles"].invoke
      Rake::Task["db:assign_managers"].invoke
    
    end
        
    
   
   
  #  Role.populate(7) do |role|      
  #  role.title = ["Developer", "QA", "Manager", "Director", "Product Manager", "Sales Engineer", "Vice President"]  
  #end
  # Rake::Task["db:add_employees"].invoke    
end

task :add_addresses => :environment do 
  require 'populator'
  require 'faker'
 
  employee_ids = []
  Employee.all.each do |e|
      employee_ids << e.id
  end
  Employee.all.each do |a|
    address = Address.create(:employee_id => Employee.find(a.id), 
    :street_name =>  Faker::Address.street_address,
    :apt => Faker::Address.building_number,
    :city => Faker::Address.city,
    :state => Faker::Address.state_abbr,
    :zip => Faker::Address.zip_code
    )
   # a.employee_id = Employee.find(a.id)
   # a.street_name = Faker::Address.street_address
   # a.apt = Faker::Address.building_number
   # a.city = Faker::Address.city
   # a.state = Faker::Address.state_abbr
   # a.zip = Faker::Address.zip_code
  end
  
end


task :add_roles => :environment do
  
   Role.delete_all
   @roles = Array["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
   @roles.each do |role|
     r = Role.create :title => role
     r.save   
   end 
end

task :assign_roles => :environment do
  
   roles = Array["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
   @employees = Employee.all
   @employees.each do |e|
     e.role = roles[rand(10)+1]
     e.save
   end  
end



  task :add_depts => :environment do
    require 'populator'
    require 'faker'
    
    Department.delete_all
    Department.populate(10) do |dept|      
    dept.name = Faker::Company.name 
  end
end


  task :add_employees => :environment do
    require 'populator'
    require 'faker'
    
    Employee.delete_all
    Employee.populate(10) do |emp|      
    emp.name = Faker::Name.name  
    emp.bio = Populator.sentences(2..10)
    emp.role = Role.find(1+rand(6)).title
    emp.department_id = Department.find(1+rand(9)).id
    emp.email = Faker::Internet.email
  end
end

  task :assign_managers => :environment do
    require 'populator'
    require 'faker'
    
    @employees = Employee.all
    @employees.each do |employee|
      if (employee.role == "CEO")
        employee.manager_id =  employee.id
      else
        employee.manager_id =  random_num(employee)
      end
        employee.save
    end
 
  end
  
  
  def random_num(employee)
      id = rand(Employee.all.count)+1
      if (employee.id != id )
        id
      else
        random_num(employee)
      end
  end
  
end




