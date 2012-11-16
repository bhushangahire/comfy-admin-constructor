require 'rails/generators/migration'
require 'rails/generators/generated_attribute'

class CmsAdminGenerator < Rails::Generators::Base
  include Rails::Generators::Migration
  no_tasks { attr_accessor :scaffold_name, :model_attributes, :controller_actions }

  source_root File.expand_path('../templates', __FILE__)

  argument :model_name, :type => :string, :required => true
  argument :do_migration, :type => :string, :required => true
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

    if do_migration == "migrate"
      @do_migration = "migrate"
    end
  end

  def create_model
    template 'model.rb', "app/models/#{model_path}.rb"
  end

  def create_migration
    migration_template 'migration.rb', "db/migrate/create_#{model_path.pluralize.gsub('/', '_')}.rb"
  end

  def create_controller
    template 'controller.rb', "app/controllers/#{admin_prefix}/#{plural_name}_controller.rb"
  end

  def create_form
    template "views/_form#{template_file_type}", "app/views/#{admin_prefix}/#{plural_name}/_form#{template_file_type}"
  end

  def create_views
    %w[edit index new].each do |action|
      template "views/#{action}#{template_file_type}", "app/views/#{admin_prefix}/#{plural_name}/#{action}#{template_file_type}"
    end
  end

  def create_route
    namespaces = [admin_prefix, class_name.underscore.downcase.pluralize]
    resource = namespaces.pop
    route namespaces.reverse.inject("resources :#{resource}, :except => [:show]") { |acc, namespace|
      "namespace(:#{namespace.underscore}, :path => '#{namespace}'){#{acc}}"
    }
  end

  def create_nav_template_if_needed
    if !File.exist? destination_path("app/views/#{admin_prefix}/_navigation#{template_file_type}")
      template "partials/_navigation#{template_file_type}", "app/views/#{admin_prefix}/_navigation#{template_file_type}"
    end
  end

  def append_to_nav_template
    if haml_present?
      append = "\n%li= link_to '#{class_name.underscore.humanize.downcase.titleize.pluralize}', #{admin_prefix.underscore}_#{class_name.underscore.downcase.pluralize}_path\n"
    else
      append = "\n<li><%= link_to '#{class_name.underscore.humanize.downcase.titleize.pluralize}', #{admin_prefix.underscore}_#{class_name.underscore.downcase.pluralize}_path %></li>"
    end
    File.open(destination_path("app/views/#{admin_prefix}/_navigation#{template_file_type}"), "a") {|f| f.write(append)}
  end

  def do_migration_if_needed
    if @do_migration == "migrate"
      exec "rake db:migrate"
    end
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

  def haml_present?
    defined?(Haml)
  end

  def template_file_type
    if haml_present?
      ".html.haml"
    else
      ".html.erb"
    end
  end

  def admin_prefix
    ComfortableMexicanSofa.config.admin_route_prefix
  end

end
