module ApplicationHelper
  def avatar_url(employee)
    if employee.avatar.exists?  
       employee.avatar.url(:medium)
    else
      employee.gravatar_url
    end
  end
end
