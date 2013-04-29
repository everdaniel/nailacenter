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

  def tr_group_class(resource)
    if !resource.errors.empty?
      return "error".html_safe
    else
      return "".html_safe
    end
  end

  def format_with_no_decimals(number)
    number_with_precision number, :precision => 0
  end

  def format_with_two_decimals(number)
    number_with_precision number, :precision => 2
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => "btn btn-small btn-danger")
  end

  def link_to_add_fields1(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"))
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => "btn btn-small btn-success")
  end

end