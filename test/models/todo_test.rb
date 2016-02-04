require 'test_helper'

class TodoTest < ActiveSupport::TestCase
    test "there should be 4 todos" do 
        assert Todo.count == 4, "There are #{Todo.count} todos"
    end 
    
    test "adding todo child adds relevant parent reference" do 
        todos(:one).children << todos(:three)
        todos(:one).children << todos(:two)
        
        todos(:two).children << todos(:three)
        
        assert todos(:one).children.count == 2, "First checklist has #{todos(:one).children.count} children"
        assert todos(:one).children[0] == todos(:three), "First checklist's first child is #{todos(:one).children[0].title}"
        assert todos(:one).children[1] == todos(:two), "First checklist's second child is #{todos(:one).children[1].title}"
        
        assert todos(:two).children.count == 1, "Second checklist has #{todos('two').children.count} children"
        assert todos(:two).parents.count == 1, "Second checklist has #{todos('two').parents.count} parents"
        
        assert todos(:three).parents.count == 2, "Third checklist has #{todos('three').parents.count} parents"
        assert todos(:three).children.count == 0, "Third checklist has #{todos('three').children.count} children"
    end 
    
    test "completing all child todos completes parent" do 
        todos(:one).children << todos(:two)
        todos(:one).children << todos(:three)
        
        assert todos(:one).children.count == 2, "First todo has #{todos(:one).children.count} children"
        
        todos(:two).completed = true 
        todos(:three).completed = true 
        
        assert todos(:two).completed == true, "Second todo completed is #{todos(:two).completed.to_s}"
        assert todos(:three).completed == true, "Third todo completed is #{todos(:three).completed.to_s}"
        
        todos(:two).send(:complete_parents_if_siblings_completed)
        
        assert_equal(todos(:two).send(:complete_parents_if_siblings_completed)[0].completed, true)
    end 
    
    test "uncompleting child todo uncompletes parent" do 
        todos(:two).completed = true 
        todos(:one).completed = true 
        
        todos(:one).children << todos(:two)
        
        todos(:two).completed = false 
        
        assert_equal(todos(:two).send(:uncomplete_parents_if_uncompleted)[0].completed, false)
    end 
    
    test "todo title and description allow apostrophes" do 
        todo = Todo.new(:title => "That's not right", :description => "Apostrophe's apostrophy is useful", :user => users(:one), :completed => false)
        
        assert todo.save, "Todo saved with title \"#{todo.title}\""
    end 
    
    test "todo description allows 0 characters" do 
        todo = Todo.new(:title => "That's not right", :description => "", :user => users(:one), :completed => false)
        
        assert todo.save, "Todo did not save with empty description"
    end 
end
