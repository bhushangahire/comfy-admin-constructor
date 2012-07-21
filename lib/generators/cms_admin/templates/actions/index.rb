def index
  @<%= class_name.underscore.downcase.pluralize %> = <%= class_name %>.all
end