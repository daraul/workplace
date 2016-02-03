class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :set_new_todo, only: [:create]
  before_action :set_todos, only: [:index, :new, :edit, :create, :update]
    before_action :assign_user, only: [:create]
    before_action :verify_user, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    respond_to do |format|
      if @todo.save
        format.html { redirect_to @todo, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.html { render :new }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to todos_url, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
      @parents = @todo.parents 
      @children = @todo.children 
    end
    
    def set_todos 
        @todos = current_user.todos
    end 
    
    def set_new_todo
        @todo = Todo.new(todo_params)
    end 
    
    def assign_user
        @todo.user = current_user
    end 
    
    def verify_user
        if current_user != @todo.user 
            redirect_to todos_path
            flash.notice = "You're not allowed to do that!"
        end 
    end 

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:title, :description, :completed, child_ids: [], parent_ids: [] )
    end
end
