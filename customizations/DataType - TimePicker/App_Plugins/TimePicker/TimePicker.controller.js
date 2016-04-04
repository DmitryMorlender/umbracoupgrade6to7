angular.module("umbraco").controller("Umbraco.TimePicker",
//inject umbracos assetsService
function ($scope, notificationsService, assetsService, angularHelper, $element) {
	//setup the default config
    var config = {
        pickDate: false,
        pickTime: true,
		useSeconds: false,
        format: "HH:mm",
		icons: {
                    time: "icon-time",
                    date: "icon-calendar",
                    up: "icon-chevron-up",
                    down: "icon-chevron-down"
                }

    };
    //map the user config
    $scope.model.config = angular.extend(config, $scope.model.config);
	
	var filesToLoad = ["/Umbraco/lib/moment/moment-with-locales.js",
			"/Umbraco/lib/datetimepicker/bootstrap-datetimepicker.js"];
    
    //plugin folder
    assetsService
        .load(filesToLoad)
        .then(function () {
            var element = $element;
			
			
			// Open the datepicker and add a changeDate eventlistener
			element.datetimepicker(angular.extend({ useCurrent: false }, $scope.model.config));
			element.bind("blur", function() {
				$scope.model.value = element.val();
			});
			//Ensure to remove the event handler when this instance is destroyted
			$scope.$on('$destroy', function () {
				element.unbind("blur");
				element.datetimepicker("destroy");
			});
        });

    //load the seperat css for the editor to avoid it blocking our js loading
    assetsService.loadCss('/Umbraco/lib/datetimepicker/bootstrap-datetimepicker.min.css');
});