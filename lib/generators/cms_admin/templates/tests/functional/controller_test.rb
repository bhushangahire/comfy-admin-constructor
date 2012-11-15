require 'test_helper'

class <%= admin_prefix.underscore.camelize %>::<%= plural_class_name %>ControllerTest < ActionController::TestCase
  def setup
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      ComfortableMexicanSofa::HttpAuth.username, 
      ComfortableMexicanSofa::HttpAuth.password
    )
  end

  def test_index
    get :index
    assert_response :success
    assert_template 'index'
    assert assigns(:<%= class_name.underscore.downcase.pluralize %>)
  end

  def test_new
    get :new
    assert_response :success
    assert_template 'new'
    assert assigns(:<%= class_name.underscore.downcase %>)
  end

  def test_create
    assert_difference '<%= class_name %>.count', 1 do
      post :create, :<%= class_name.underscore.downcase %> => <%= class_name.underscore.downcase %>_params
    end
    assert_equal '<%= class_name %> created', flash[:notice]
    assert_redirected_to <%= "#{admin_prefix.underscore}_#{class_name.underscore.downcase.pluralize}_path" %>
  end

  def test_create_fail
    assert_no_difference '<%= class_name %>.count' do
      post :create, :<%= class_name.underscore.downcase %> => {}
    end
    assert_response :success
    assert_template 'new'
#   end

#   def test_edit
#     get :edit, :id => employees(:one)
#     assert_response :success
#     assert_template 'edit'
#   end

#   def test_edit_failure
#     get :edit, :id => 'invalid'
#     assert_response :redirect
#     assert_equal 'Employee not found', flash[:error]
#     assert_redirected_to cms_admin_employees_path
#   end

#   def test_update
#     employee = employees(:one)
#     put :update, :id => employee, :employee => { :first_name => 'New first name' }
#     employee.reload
#     assert_equal 'New first name', employee.first_name
#     assert_equal 'Employee updated', flash[:notice]
#     assert_redirected_to cms_admin_employees_path
#   end
    
#   def test_update_fail
#     put :update, :id => employees(:one), :employee => { :first_name => '' }
#     assert_response :success
#     assert_equal 'Failed to create Employee', flash[:error]
#   end

#   def test_destroy
#     assert_difference 'Employee.count', -1 do
#       delete :destroy, :id => employees(:one)
#     end
#     assert_equal 'Employee removed', flash[:notice]
#     assert_redirected_to cms_admin_employees_path
#   end
  
# protected
  
#   def employee_params(options={})
#     {
#       :first_name => 'Default first name 2',
#       :last_name => 'Default last name 2',
#       :title => 'bla',
#       :email => 'someemail@emai.com',
#       :bio => 'my bio'
#     }.merge(options)
#   end
end
