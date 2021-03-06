require 'test_helper'

class TodosControllerTest < ActionController::TestCase
  setup do
    @todo = todos(:one)
    session[:user_id] = users(:one).id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:todos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create todo" do
    assert_difference('Todo.count') do
      post :create, todo: { completed: @todo.completed, description: @todo.description, title: @todo.title, due: Time.now + 1.day }
    end

    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should show todo" do
    get :show, id: @todo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @todo
    assert_response :success
  end

  test "should update todo" do
    patch :update, id: @todo, todo: { completed: true, description: "New description is long", title: "New Title", due: Time.now + 1.day }
    assert_redirected_to todo_path(assigns(:todo))
  end

  test "should destroy todo" do
    assert_difference('Todo.count', -1) do
      delete :destroy, id: @todo
    end

    assert_redirected_to todos_path
  end
  
  test "should not edit completed todo" do 
      todo = todos(:five)
      
      patch :update, id: todo, todo: { completed: '1', description: todo.description, title: todo.title, due: Time.now + 1.day }
      assert_redirected_to edit_todo_path(assigns(:todo))
  end 
end
