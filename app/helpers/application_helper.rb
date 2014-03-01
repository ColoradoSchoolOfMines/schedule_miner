module ApplicationHelper
  def navbar_controller_entry(name, options)
    if Rails.application.routes.recognize_path(options)[:controller] == params[:controller]
      start = '<li class="active">'
    else
      start = '<li>'
    end

    raw(start + (link_to name, options) + '</li>')
  end
end
