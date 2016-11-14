module ApplicationHelper
  # => define method that takes two arguments, array of errors and block. & turns block into a prc
  def form_group_tag(errors, &block)
    css_class = 'form-group'
    css_class << ' has-error' if errors.any?
    # => used to build the html and css to dosplay the form element and any associated errors
    content_tag :div, capture(&block), class: css_class
  end
end
