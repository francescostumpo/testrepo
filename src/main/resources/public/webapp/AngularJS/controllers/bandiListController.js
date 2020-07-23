snamApp.controller("bandiListController", ['$scope', '$http', '$location', '$rootScope', function($scope, $http, $location,$rootScope) {
    console.log("[INFO] Hello World from bandiListController");

    var url = mainController.getHost() + '/tender/getAllTenders'
    $http.get(url).then(function (response) {
        console.log('response from ', url, ' : ', response)
    })


    $scope.bandiGaraList = [
        {
            "cig": "5100001260",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di componenti hardware",
            "lavorazione": new Date("2020-06-23T15:18"),
            "endDate": new Date("2020-06-23T15:18"),
            "fornitori": 12,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001259",
            "supplier": "Stogit",
            "object": "Fornitura di tubi senza saldatura",
            "lavorazione": new Date("2020-08-15T15:18"),
            "endDate": new Date("2020-08-15T15:18"),
            "fornitori": 15,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001263",
            "supplier": "Stogit",
            "object": "Fornitura di materiali di primo soccorso",
            "lavorazione": new Date("2020-06-23T15:18"),
            "endDate": new Date("2020-06-23T15:18"),
            "fornitori": 8,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001262",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di componenti elettronici",
            "lavorazione": new Date("2020-06-14T15:18"),
            "endDate": new Date("2020-06-14T15:18"),
            "fornitori": 18,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001265",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2021-06-25T15:18"),
            "endDate": new Date("2021-06-25T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001261",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di telecamere di sicurezza",
            "lavorazione": new Date("2020-06-23T15:18"),
            "endDate": new Date("2020-06-23T15:18"),
            "fornitori": 15,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001266",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-11-10T15:18"),
            "endDate": new Date("2020-11-10T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001267",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-10-11T15:18"),
            "endDate": new Date("2020-10-11T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001268",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-06-22T15:18"),
            "endDate": new Date("2020-06-22T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001269",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-07-17T15:18"),
            "endDate": new Date("2020-07-17T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001270",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-05-23T15:18"),
            "endDate": new Date("2020-05-23T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        },
        {
            "cig": "5100001271",
            "supplier": "Snam Rete e Gas",
            "object": "Fornitura di materiali di sicurezza",
            "lavorazione": new Date("2020-06-24T15:18"),
            "endDate": new Date("2020-06-24T15:18"),
            "fornitori": 11,
            "id" : "5f180b8cf1e23e6344b70aa8"
        }
    ]

    $scope.bandiSelected = [];

    $scope.openModalEditTender = function (bando) {
        $('#datepickerModify').datepicker({
            locale: 'it-it',
            uiLibrary: 'bootstrap4',
            format: 'dd/mm/yyyy'
        });
        $scope.tenderModified = {}
        $scope.bandoSelected = bando
        $('#editTenderModal').modal()
    }

    $scope.modifyBando = function(){
        console.log('Bando ' , $scope.bandoSelected, ' modified')
        var url = mainController.getHost() + '/tender/updateTenderFields'
        var input = {
            "object" : $scope.tenderModified.object,
            "description" : $scope.tenderModified.description,
            "endDate" : $scope.tenderModified.endDate,
            "cig": $scope.tenderModified.cig,
            "id" : $scope.bandoSelected.id
        }
        $http.post(url, input).then(function (response) {
            console.log('response from ', url, ' : ', response)
            if(response.data.status === 200){
                mainController.showNotification('bottom', 'right', response.data.message, '', 'info')
            }
            else{
                mainController.showNotification('bottom', 'right', response.data.message, '', 'danger')
            }
        })
    }

    $scope.selectBando = function(bando){
        if(!$scope.bandiSelected.includes(bando)){
            $scope.bandiSelected.push(bando)
        }
        else{
            var tmp = [];
            var k = 0;
            for(var i=0;i<$scope.bandiSelected.length;i++){
                if(bando.cig !== $scope.bandiSelected[i].cig){
                    tmp[k] = $scope.bandiSelected[i];
                    k++;
                }
            }
            $scope.bandiSelected = tmp;
        }
        console.log($scope.bandiSelected)
    }

    $scope.highlightCard = function(bando){
        for(var i = 0; i < $scope.bandiSelected.length ; i++){
            if(bando.cig === $scope.bandiSelected[i].cig){
                return {'background-color' : '#DCF4F2'}
            }
        }
    }

    $scope.goToView = function (path, bandoGara) {

        sessionStorage.setItem('bandoGara', JSON.stringify(bandoGara));
        sessionStorage.setItem('bandoGaraOggetto', bandoGara.object)
        location.href = path;
    }

}]);

