require 'test_helper'

class ChecklistsControllerTest < ActionController::TestCase
  setup do
    @checklist = checklists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:checklists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create checklist" do
    assert_difference('Checklist.count') do
      post :create, checklist: { description: @checklist.description, title: @checklist.title }
    end

    assert_redirected_to checklist_path(assigns(:checklist))
  end

  test "should show checklist" do
    get :show, id: @checklist
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @checklist
    assert_response :success
  end

  test "should update checklist" do
    patch :update, id: @checklist, checklist: { description: @checklist.description, title: @checklist.title }
    assert_redirected_to checklist_path(assigns(:checklist))
  end

  test "should destroy checklist" do
    assert_difference('Checklist.count', -1) do
      delete :destroy, id: @checklist
    end

    assert_redirected_to checklists_path
  end
end
