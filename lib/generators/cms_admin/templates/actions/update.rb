def update
  @<%= class_name.underscore.downcase %>.update_attributes!(params[:<%= class_name.underscore.downcase %>])
  flash[:notice] = '<%= class_name.underscore.humanize.downcase.titleize %> updated'
  redirect_to(:action => :index)
end