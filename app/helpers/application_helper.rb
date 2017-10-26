module ApplicationHelper
  
  def tab_active?(controller_name, action_name)
    return 'active' if (controller.controller_name == controller_name) and (controller.action_name == action_name)
  end
  
  
end
