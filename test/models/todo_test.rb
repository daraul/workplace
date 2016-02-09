require 'test_helper'

class TodoTest < ActiveSupport::TestCase
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
        todo = Todo.new(:title => "That's not right", :description => "Apostrophe's apostrophy is useful", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        
        assert todo.save, "Todo saved with title \"#{todo.title}\""
    end 
    
    test "todo description allows 0 characters" do 
        todo = Todo.new(:title => "That's not right", :description => "", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        
        assert todo.save, "Todo did not save with empty description"
    end 
    
    test "todo title length" do 
        todo = Todo.new(:title => "A0123456789012345678901234567890123456789012345678", :description => "", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        
        assert todo.save, "Todo title is #{todo.title.length} characters long."
    end 
    
    test "child due date is before parent" do
        todo = Todo.new(:title => "Test Title", :description => "", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        child = Todo.new(:title => "Child Title", :description => "", :user => users(:one), :completed => false, :due => Time.now + 2.days)
        
        todo.children << child
        
        assert_not todo.save, "Todo saved despite child being due after parent"
    end
    
    test "parent due date is after parent" do 
        todo = Todo.new(:title => "Early Title", :description => "", :user => users(:one), :completed => false, :due => Time.now + 2.days)
        parent = Todo.new(:title => "Test Title", :description => "", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        
        todo.parents << parent 
        
        assert_not todo.save, "Todo saved despite parent being due before child"
    end 
    
    test "parents and children can have same due date" do 
        parent = Todo.new(:title => "Parent todo", :description => "", :user => users(:one), :completed => false, :due => Time.now + 1.day)
        child = Todo.new(:title => "Child todo", :description => "", :user => users(:one), :completed => false, :due => parent.due)
        
        parent.save 
        child.save 
        
        child.parents << parent  
        
        assert child.save, "Todo not saved"
    end 
end
