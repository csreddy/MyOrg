module ApplicationHelper
  def avatar_url(employee)
    if employee.avatar.exists?  
       employee.avatar.url(:thumb)
    else
      employee.gravatar_url
    end
  end
end
