require 'test_helper'

class CmsAdmin::ProjectsControllerTest < ActionController::TestCase
  def setup
    @request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      ComfortableMexicanSofa::HttpAuth.username, 
      ComfortableMexicanSofa::HttpAuth.password
    )
  end

  def test_index
    get :index, :project_category_id => project_categories(:one), :project_id => projects(:one)
    assert_response :success
    assert_template 'index'
    assert assigns( :projects)
  end

  def test_index_failure
    get :index, :project_category_id => 'invalid', :project_id => 'invalid'
    assert_equal 'Project Category not found', flash[:error]
    assert_redirected_to cms_admin_project_categories_path
  end

  def test_new
    get :new, :project_category_id => project_categories(:one), :project_id => projects(:one)
    assert_response :success
    assert_template 'new'
    assert assigns( :project)
  end

  def test_create
    assert_difference 'Project.count', 1 do
      post :create, :project_category_id => project_categories(:one), :project => project_params
    end
    assert_equal 'Project created', flash[:notice]
    assert_redirected_to cms_admin_project_category_projects_path
  end

  def test_create_fail
    assert_no_difference 'Project.count' do
      post :create, :project_category_id => project_categories(:one), :project => {}
    end
    assert_response :success
    assert_template 'new'
  end

  def test_edit
    get :edit, :project_category_id => project_categories(:one),  :id => projects(:one)
    assert_response :success
    assert_template 'edit'
  end

  def test_edit_failure
    get :edit, :project_category_id => project_categories(:one),  :id => 'invalid'
    assert_response :redirect
    assert_equal 'Project not found', flash[:error]
    assert_redirected_to cms_admin_project_category_projects_path
  end

  def test_update
    project = projects(:one)
    put :update, :project_category_id => project_categories(:one), :id => project, :project => { :title => 'New title' }
    project.reload
    assert_equal 'New title', project.title
    assert_equal 'Project updated', flash[:notice]
    assert_redirected_to cms_admin_project_category_projects_path
  end
    
  def test_update_fail
    put :update, :project_category_id => project_categories(:one), :id => projects(:one), :project => { :title => '' }
    assert_response :success
    assert_equal 'Failed to update Project', flash[:error]
  end

  def test_destroy
    assert_difference 'Project.count', -1 do
      delete :destroy, :project_category_id => project_categories(:one), :id => projects(:one)
    end
    assert_equal 'Project removed', flash[:notice]
    assert_redirected_to cms_admin_project_category_projects_path
  end
  
protected
  
  def project_params(options={})
    {
      :client_name => 'sample name',
      :title => 'title',
      :hover_text => 'hover text',
      :headline => 'headline',
      :intro_text => 'intro text',
      :description => 'description'
    }.merge(options)
  end
end
