module ApplicationHelper

  def full_title(page_title)
    base_title = 'Naila Center'
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def control_group_class(resource, field_name)
    if !resource.errors[field_name].empty?
      return "control-group error".html_safe
    else
      return "control-group".html_safe
    end
  end

end