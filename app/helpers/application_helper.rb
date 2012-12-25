module ApplicationHelper
  def avatar_url(employee)
    if employee.avatar.exists?  
       employee.avatar.url(:thumb)
    else
      employee.gravatar_url
    end
  end
  
  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
  
    
  def employee_department(employee)
    if employee.department_id.nil?
     "dept not assigned"
    else
      link_to employee.department.name, department_path(employee.department)
  end
end


def employee_manager(employee)
  @managers = employee.employees
  if @managers.empty?
    "manager not assigned"   
  else
    @managers.collect do |manager|
      manager.name
    end
  end
end


def employee_roles(employee)
  @roles = employee.roles
  if @roles.empty?
    "no roles assigned"
  else
    @roles.each do |role|
     role.title
    end
  end
end



end



