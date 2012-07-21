def destroy
  @<%= class_name.underscore.downcase %>.destroy
  flash[:notice] = '<%= class_name.underscore.humanize.downcase.titleize %> removed'
  redirect_to(:action => :index)
end