module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Ruby on Rails Tutorial Sample App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  # returns list element of active class or not with link inside.
  def active_list_link_to(text, path )
   list_class = ((path == request.env['PATH_INFO']) ? ' class="active" ' : nil)
   ("<li#{list_class}>" + (link_to text, path) + "</li>").html_safe
  end
end
#Check name of controller
#def controller?(*controller)
#  controller.include?(params[:controller])
#end
#Check name of action
#def action?(*action)
#  action.include?(params[:action])
#end