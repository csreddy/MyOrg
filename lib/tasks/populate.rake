namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
   Rake::Task["db:add_depts"].invoke
    Employee.delete_all
    Role.delete_all
    @roles = Array["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
    @roles.each do |role|
      r = Role.create :title => role
      r.save 
      Employee.populate(1..3) do |emp|      
      emp.name = Faker::Name.name  
      emp.bio = Populator.sentences(2..10)
    #  emp.role_ids = Role.last.id
      emp.department_id = Department.find(1+rand(9)).id
      emp.email = Faker::Internet.email
    end
        
    end
   
   
  #  Role.populate(7) do |role|      
  #  role.title = ["Developer", "QA", "Manager", "Director", "Product Manager", "Sales Engineer", "Vice President"]  
  #end
  # Rake::Task["db:add_employees"].invoke    
end

task :add_roles => :environment do
  
   Role.delete_all
   @roles = Array["Developer", "QA Engineer", "Lead Engineer","QA Manager","Manager", "IT Admin", "Director", "Product Manager", "Project Manager", "Sales Engineer", "Vice President", "Founder", "Chief Financial Officer", "Senior Vice President", "Chief Marketing Officer", "CEO"]
   @roles.each do |role|
     r = Role.create :title => role
     r.save   
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

  task :add_managers => :environment do
    require 'populator'
    require 'faker'
    
    @employees = Employee.all
    @employees.each do |employee|
      employee.reportsto =  Employee.find(1+rand(6)).name
    end
 
end


end

