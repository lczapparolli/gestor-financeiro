module BreadcrumbHelper

  def breadcrumb
    #if is home page, we do not need breadcrumbs
    unless current_page? root_path
      content_tag(:div, class: "breadcrumbs") do
        link_to("Home", root_path, class: "link link-default") <<
        controller_tag() <<
        current_action_tag()
      end
    end

  end

  def controller_tag
    #if is de index action of any controller, only show as current item
    if action_name == "index"
      sanitize(" > ") << content_tag(:span, controller.controller_name.capitalize, class: "current")
    elsif controller.respond_to?(:index) #if contains a 'index' method treat like a resource controller
      sanitize(" > ") << link_to(controller.controller_name.capitalize, controller: controller.controller_name, action: "index")
    else
      sanitize(" > ") << content_tag(:span, action_name.tr("_", " ").capitalize, class: "current")
    end
  end

  def current_action_tag
    if action_name == "edit" #when the action is edit, link to show item
      sanitize(" > ") << link_to(controller.resource_description, controller: controller.controller_name, action: "show") <<
      sanitize(" > ") << content_tag(:span, "Edit", class: "current")
    elsif action_name == "show"
      sanitize(" > ") << content_tag(:span, controller.resource_description, class: "current")
    elsif action_name == "new"
      sanitize(" > ") << content_tag(:span, "New", class: "current")
    end
  end

end
