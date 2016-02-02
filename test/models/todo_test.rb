require 'test_helper'

class TodoTest < ActiveSupport::TestCase
    test "there should be 4 todos" do 
        assert Todo.count == 4, "There are #{Todo.count} todos"
    end 
    
    test "adding todo child adds relevant parent reference" do 
        first = todos('one')
        first.children << todos('three')
        first.children << todos('two')
        
        todos('two').children << todos('three')
        
        assert first.children.count == 2, "First checklist has #{first.children.count} children"
        assert first.children[0] == todos('three'), "First checklist's first child is #{first.children[0].title}"
        assert first.children[1] == todos('two'), "First checklist's second child is #{first.children[1].title}"
        
        assert todos('two').children.count == 1, "Second checklist has #{todos('two').children.count} children"
        assert todos('two').parents.count == 1, "Second checklist has #{todos('two').parents.count} parents"
        
        assert todos('three').parents.count == 2, "Third checklist has #{todos('three').parents.count} parents"
        assert todos('three').children.count == 0, "Third checklist has #{todos('three').children.count} children"
    end 
end
