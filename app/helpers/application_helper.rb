module ApplicationHelper
  def avatar_url_index_page(employee)
    if employee.avatar.exists?  
       employee.avatar.url(:thumb)
    else
      employee.gravatar_url
    end
  end
  
  def avatar_url_show_page(employee)
    if employee.avatar.exists?  
       employee.avatar.url(:medium)
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
     content_tag :span , "not assigned", :class => 'label'
    else
      link_to employee.department.name, department_path(employee.department)
  end
end


def employee_manager(employee)
  @managers = employee.employees
  if employee.manager.nil?
    "manager not assigned"   
  else
   employee.manager.name
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


def employee_address(employee)
	 if employee.address.nil? 
	  content_tag :span , "address not provided", :class => 'label' 
	 else 
     employee.address.street_name
     employee.address.city 
     employee.address.state
     employee.address.zip 
end 
end



def autocomplete
  @employees= Employee.select("id, name").where("name LIKE ?", "#{params[:term]}%").limit(20)
  @hash = []
  @employees.each do |employee|
    @hash << {"label" => employee.name, "id" => employee.id}
  end

  render :json => @hash

  end
  
  
  module BootstrapFlashHelper
    ALERT_TYPES = [:error, :info, :success, :warning]

    def bootstrap_flash
      flash_messages = []
      flash.each do |type, message|
        # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
        next if message.blank?
      
        type = :success if type == :notice
        type = :error   if type == :alert
        next unless ALERT_TYPES.include?(type)

        Array(message).each do |msg|
          text = content_tag(:div,
                             content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                             msg.html_safe, :class => "alert fade in alert-#{type}")
          flash_messages << text if message
        end
      end
      flash_messages.join("\n").html_safe
    end
  end
  
  

end



