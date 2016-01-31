require 'test_helper'

class ChecklistTest < ActiveSupport::TestCase
    test "there should be 4 checklists" do 
        assert Checklist.count == 4, "There are #{Checklist.count} checklists"
    end 
    
    test "adding checklist child adds relevant parent reference" do 
        first = checklists('one')
        first.children << checklists('three')
        first.children << checklists('two')
        
        checklists('two').children << checklists('three')
        
        assert first.children.count == 2, "First checklist has #{first.children.count} children"
        assert first.children[0] == checklists('three'), "First checklist's first child is #{first.children[0].title}"
        assert first.children[1] == checklists('two'), "First checklist's second child is #{first.children[1].title}"
        
        assert checklists('two').children.count == 1, "Second checklist has #{checklists('two').children.count} children"
        assert checklists('two').parents.count == 1, "Second checklist has #{checklists('two').parents.count} parents"
        
        assert checklists('three').parents.count == 2, "Third checklist has #{checklists('three').parents.count} parents"
        assert checklists('three').children.count == 0, "Third checklist has #{checklists('three').children.count} children"
    end 
end
