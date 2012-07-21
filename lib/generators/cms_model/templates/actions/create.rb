def create
  @<%= class_name.underscore.downcase %>.save!
  flash[:notice] = "<%= class_name.underscore.humanize.downcase.titleize %> created"
  redirect_to(:action => :index)
rescue ActiveRecord::RecordInvalid
  flash.now[:error] = 'Failed to create <%= class_name.underscore.humanize.downcase.titleize %>'
  render :action => :new
end