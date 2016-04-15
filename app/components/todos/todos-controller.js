workplace.controller('todosController', function($scope, $http) {
    $scope.loading = true;
    
    $scope.getTodos = function() {
        $scope.loading = true;
        
        $http.jsonp(
            'https://work-place.herokuapp.com/todos', {
            method: 'POST',
        }).then(function successCallback(response) {
            window.response = response;
        }, function errorCallback(response) {
            window.response = response;
        }).finally(function(){
            console.log("Done.");
        });
    };
    
    $scope.getTodos();
});