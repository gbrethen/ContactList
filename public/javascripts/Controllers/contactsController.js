(function () {
    'use strict';

    angular.module("ContactsApp").controller("ContactsController", ContactsController);

    ContactsController.$inject = ['$scope', '$resource', "$http", 'ContactsData', '$location', 'DTOptionsBuilder'];

    function ContactsController($scope, $resource, $http, ContactsData, $location, DTOptionsBuilder) {
        /* jshint validthis:true */
        var vm = this;
        vm.title = 'ContactsController';
        vm.dtOptions = DTOptionsBuilder.newOptions().withPaginationType('full_numbers').withDisplayLength(2);
        var contactsList = ContactsData.GetContacts();
        $scope.contacts = contactsList.query();
        console.log("contacts list: " + $scope.contacts);
       
        $scope.IsFormSubmitted = false;
        $scope.IsFormValid = false;

        $scope.contact = {};

        $scope.$watch('contactForm.$valid', function (newValue) {
            $scope.IsFormValid = newValue;
        });

        $scope.Submit = function () {
            //debugger;
            $scope.IsFormSubmitted = true;

            if ($scope.IsFormValid) {
                var Contact = new Object();
                Contact.name = $scope.contact.firstName + ' ' + $scope.contact.lastName;
                Contact.address = $scope.contact.address;
                Contact.city = $scope.contact.city;
                Contact.state = $scope.contact.state;
                Contact.zip = $scope.contact.zip;
                Contact.email_address = $scope.contact.email_address;
                Contact.phone_number = $scope.contact.phone_number;

                ContactsData.SaveContact(Contact).then(function (result) {
                    
                    if (result.data === "SUCCESS") {
                        toastr.success('Contact was successfully saved!');
                                  
                        $scope.contact = {};
                        $scope.contactForm.$setPristine();
                        $scope.contactForm.$setUntouched();
                        $scope.IsFormSubmitted = false;

                        $scope.contacts = [];
                        $scope.contacts = contactsList.query();
                        
                                
                    }
                    else {
                        toastr.warning('Error! Please try again.');
                        console.log(result);
                    }
                });
            }
        };

        $scope.RemoveContact = function (id) {
                        
            ContactsData.DeleteContact(id).then(function (result) {
                if (result.data === "SUCCESS") {
                    toastr.error('Contact was successfully removed!');

                    $scope.contacts = [];
                    $scope.contacts = contactsList.query();
                    
                }
                else {
                    toastr.warning('Error! Please try again.');
                    console.log(result);
                }
            });
        };

        activate();

        function activate() { }
    }
})();
