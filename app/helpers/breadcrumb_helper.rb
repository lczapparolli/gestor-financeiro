module BreadcrumbHelper

  def breadcrumb
    #if is home page, we do not need breadcrumbs
    unless current_page? root_path
      html = "<ul class=\"breadcrumbs\">"

      html << "<li>" << link_to("Home", root_path, class: "link link-default") << "</li>"

      #if is de index action of any controller, only show as current item
      if action_name == "index"
        html << "<li class=\"current\" >" << controller.controller_name.capitalize << "</li>"
      elsif controller.respond_to?(:index) #if contains a 'index' method treat like a resource controller
        html << "<li>" << link_to(controller.controller_name.capitalize, controller: controller.controller_name, action: "index") << "</li>"

        if action_name == "edit" #when the action is edit, link to show item
          html << "<li>" << link_to(controller.resource_description, controller: controller.controller_name, action: "show") << "</li>"
          html << "<li class=\"current\" >Edit</li>"
        elsif action_name == "show"
          html << "<li class=\"current\" >" << controller.resource_description << "</li>"
        elsif action_name == "new"
          html << "<li class=\"current\" >New</li>"
        end

      else #if does not contain a 'index' method, it is not a resource controller, just show the action
        html << "<li class=\"current\" >" << action_name.tr("_", " ").capitalize << "</li>"
      end

      html << "</ul>"
      html.html_safe
    end
    #controller.controller_name
  end

end
