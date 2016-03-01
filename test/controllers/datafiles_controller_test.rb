require 'test_helper'

class DatafilesControllerTest < ActionController::TestCase
    setup do
        @datafile = datafiles(:one)
        @todo = todos(:one)
        session[:user_id] = users(:one).id
    end
    
    test "should destroy datafile" do
        request.env["HTTP_REFERER"] = "back"
        
        assert_difference('Datafile.count', -1) do
            delete :destroy, id: @datafile, todo_id: @todo
        end
        
        assert_redirected_to "back"
    end
end
