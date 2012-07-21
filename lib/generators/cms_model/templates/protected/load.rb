def load_<%= class_name.underscore.downcase %>
  @<%= class_name.underscore.downcase %> = <%= class_name %>.find(params[:id])
rescue ActiveRecord::RecordNotFound
  flash[:error] = '<%= class_name.underscore.humanize.downcase.titleize %> not found'
  redirect_to :action => :index
end