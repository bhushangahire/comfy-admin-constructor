class Admin::<%= plural_class_name %>Controller < CmsAdmin::BaseController

  before_filter :load_<%= class_name.underscore.downcase %>, :except => [ :index, :new, :create ]
  before_filter :build_<%= class_name.underscore.downcase %>, :only => [ :new, :create ]

  <%= controller_methods :actions %>

protected

  <%= protected_controller_methods :protected %>

end
