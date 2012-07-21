def build_<%= class_name.underscore.downcase %>
  @<%= class_name.underscore.downcase %> = <%= class_name %>.new(params[:<%= class_name.underscore.downcase %>])
end