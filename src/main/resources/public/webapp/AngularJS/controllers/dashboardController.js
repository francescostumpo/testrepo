snamApp.controller("dashboardController", ['$scope', '$http', '$location', '$rootScope', function($scope, $http, $location,$rootScope) {
    console.log("[INFO] Hello World from dashboardController");

    mainController.startProgressIndicator('#loading')



    $scope.recentTenders = [
        {
            "cig" : "821367BD9",
            "supplier" : "Stogit",
            "description" : "Servizio di manutenzione e riparazione di compressori aria, sistemi di produzione azoto, gruppi elettrogeni emotopompe antincendio per i siti Stogit in ITALIA",
            "endDate" : "15/07/2020",
            "endWorkingDate" : "28/07/2020",
            "MAM" : "MAM019-023C"
         },
        {
            "cig" : "7924253471",
            "supplier" : "Stogit",
            "description" : "Fornitura di tubi senza saldatura",
            "endDate" : "24/07/2020",
            "endWorkingDate" : "04/07/2020",
            "MAM" : "MAM023-198A"
        },
        {
            "cig" : "8207265156",
            "supplier" : "Stogit",
            "description" : "Accordo quadro per la fornitura di automezzi ad uso aziendale",
            "endDate" : "30/07/2020",
            "endWorkingDate" : "24/08/2020",
            "MAM" : "MAM107-101F"
        }
    ]

    $scope.events = [
        {
            title  : 'SERVIZIO DI MANUTENZ...',
            start  : '2020-07-28',
            color : '#FF6C00'
        }
    ]

    $scope.showCalendarCard = true;

    $scope.toggleCalendarCard = function(){
        $scope.showCalendarCard = !$scope.showCalendarCard
    }

    $scope.initCalendar = function (language, contracts) {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: [ 'interaction', 'dayGrid', 'timeGrid' , 'bootstrap'],
            initialView: 'dayGridMonth',
            minTime: '09:00:00',
            maxTime: '24:00:00',
            defaultDate: new Date(),
            aspectRatio: 3,
            fixedWeekCount: false,
            locale: 'it',
            headerToolbar: {
                start: 'prev,next today',
                center: 'title',
                end: 'dayGridMonth,timeGridWeek'
            },
            eventColor: '#FF6C00',
            eventTextColor: '#FFF',
            events: $scope.events
        });
        calendar.render();
    }

    $scope.initCalendar()
    mainController.stopProgressIndicator('#loading')

}]);