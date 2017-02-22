(function () {
    'use strict';

    var ContactService = angular.module('ContactService', ['ngResource']);

    ContactService.factory('ContactsData', ['$resource', '$q', '$http', function ($resource, $q, $http) {
        var fac = {};
        
        fac.GetContacts = function () {
            return $resource('/contacts/', {}, {
                query: { method: 'GET', params: {}, isArray: false }
            });
            /*var defer = $q.defer();
            $http({
                method: 'GET',
                url : '/contacts'
            }).then(function(response){ defer.resolve(response.data); });
            return defer.promise;*/
        };

        fac.SaveContact = function (contact) {
            //console.log("data: " + contact);
            var defer = $q.defer();
            $http({
                method: "post",
                url: "/contacts/",
                data: contact
            }).then(function (response) {
                defer.resolve(response.data);
            });
            return defer.promise;
        };

        fac.DeleteContact = function (id) {
            var defer = $q.defer();
            $http.delete("/contacts/" + id)
                .then(function (response) {
                defer.resolve(response.data);
            });
            return defer.promise;
        };

        return fac;
    }]);
})();