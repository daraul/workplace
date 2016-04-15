var workplace = angular.module('workplace', ['ngRoute']);

$(document).on('ready', function()  {
    angular.bootstrap(document.getElementsByTagName('body'), ['workplace']);
});