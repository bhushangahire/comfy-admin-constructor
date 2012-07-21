require 'rails/generators/migration'
require 'rails/generators/generated_attribute'

class CmsAdminGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  no_tasks { attr_accessor :scaffold_name, :model_attributes, :controller_actions }

  source_root File.expand_path('../templates', __FILE__)

  argument :model_name, :type => :string, :required => true
  argument :args_for_c_m, :type => :array, :required => true

  def initialize(*args, &block)
    super

    @model_attributes = []

    args_for_c_m.each do |arg|
      if arg.include?(':')
        @model_attributes << Rails::Generators::GeneratedAttribute.new(*arg.split(':'))
      end
    end

    @model_attributes.uniq!
  end

  def create_model
    template 'model.rb', "app/models/#{model_path}.rb"
  end

  def create_migration
    migration_template 'migration.rb', "db/migrate/create_#{model_path.pluralize.gsub('/', '_')}.rb"
  end

  def create_controller
    template 'controller.rb', "app/controllers/admin/#{plural_name}_controller.rb"
  end

  def create_form
    template "views/_form.html.haml", "app/views/admin/#{plural_name}/_form.html.haml"
  end

  def create_views
    %w[edit index new].each do |action|
      template "views/#{action}.html.haml", "app/views/admin/#{plural_name}/#{action}.html.haml"
    end
  end

  def create_route
    namespaces = ["admin", class_name.underscore.downcase.pluralize]
    resource = namespaces.pop
    route namespaces.reverse.inject("resources :#{resource}, :except => [:show]") { |acc, namespace|
      "namespace(:#{namespace}){ #{acc} }"
    }
  end

  def create_nav_template_if_needed
    if !File.exist? destination_path("app/views/admin/_navigation.html.haml")
      template "partials/_navigation.html.haml", "app/views/admin/_navigation.html.haml"
    end
  end

  def append_to_nav_template
    File.open(destination_path("app/views/admin/_navigation.html.haml"), "a") {|f| f.write("\n%li= link_to class_name.underscore.humanize.downcase.titleize.pluralize, admin_#{class_name.underscore.downcase}_path\n")}
  end

  private

  def model_path
    model_name.underscore
  end

  def plural_name
    model_name.underscore.pluralize
  end

  def class_name
    model_name.camelize
  end

  def table_name
    plural_name.gsub('/', '_')
  end

  def attributes_accessible
    model_attributes.inspect
  end

  # FIXME: Should be proxied to ActiveRecord::Generators::Base
  # Implement the required interface for Rails::Generators::Migration.
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
  end

  def plural_class_name
    plural_name.camelize
  end

  def controller_methods(dir_name)
    %w[index new create edit update destroy].map do |action|
      read_template("#{dir_name}/#{action}.rb")
    end.join("\n\n").strip
  end

  def protected_controller_methods(dir_name)
    %w[load build].map do |action|
      read_template("#{dir_name}/#{action}.rb")
    end.join("\n\n").strip
  end

  def read_template(relative_path)
    ERB.new(File.read(find_in_source_paths(relative_path)), nil, '-').result(binding)
  end

  def destination_path(path)
    File.join(destination_root, path)
  end

end
