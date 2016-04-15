workplace.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider
        .when('/', {
            templateUrl: 'app/components/todos/todos.html',
            controller: 'todosController'
        })
        .otherwise({
            redirectTo: '/'
        });
    }
]);