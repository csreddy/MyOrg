module EmployeesHelper
  def get_manager
	   @employee.employees.each do |m| 
     m.name  
   end
  end
end
