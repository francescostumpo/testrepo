snamApp.controller("overviewFornitoreController", ['$scope', '$http', '$location', '$rootScope', 'DTOptionsBuilder', function($scope, $http, $location,$rootScope, DTOptionsBuilder) {
    console.log("[INFO] Hello World from overviewFornitoreController");

    $scope.cig = 7600013696
    $scope.subject = "Fornitura ed installazione in opera di attuatori elettrici per il terminale di Palmi"
    $scope.documents = [{
            id: "0001",
            name: "12.1 Documentazione di gara",
            uploadedAt: new Date('2020-06-23T15:18'),
            conformity: 0,
        },
        {
            id: "0002",
            name: "12.2 Patto etico di integrita'",
            uploadedAt: new Date('2020-06-23T15:16'),
            conformity: 0,
        },
        {
            id: "0003",
            name: "12.3 Modello 2",
            uploadedAt: new Date('2020-06-23T15:17'),
            conformity: 0,
        },
        {
            id: "0004",
            name: "12.5 Modello 3",
            uploadedAt: new Date('2020-06-23T15:19'),
            conformity: 1,
        },
        {
            id: "0005",
            name: "12.6 Modello 5",
            uploadedAt: new Date('2020-06-23T15:18'),
            conformity: 1,
        },
        {
            id: "0006",
            name: "12.9 White-List",
            uploadedAt: new Date('2020-06-23T15:19'),
            conformity: 2,
        },
        {
            id: "0007",
            name: "12.8 Situazioni di controllo",
            uploadedAt: new Date('2020-06-23T15:18'),
            conformity: 0,
        },
        {
            id: "0008",
            name: "MAM019",
            uploadedAt: new Date('2020-06-23T15:18'),
            conformity: 0,
        }
    ]

    $scope.sort = {
        name: '',
        uploadedAt: '',
        conformity: '',
    }
    $scope.showDocument = false;
    $scope.selectedDocuments = []

    $scope.dtOptionsSearchView = DTOptionsBuilder.newOptions()
        .withDOM('t')

    $scope.setDocument = function(data) {
        // When receiving a byte array
        //var file = new File([data], 'my_document.pdf', { type: 'application/pdf' });
        //var urlDocument = window.URL.createObjectURL(file);
        const urlDocument = mainController.getHost() + '/document.pdf'
        $("object.document-container").attr("data", urlDocument);
        $("embed.document-container").attr("src", urlDocument);
    }

    $scope.checkDocument = function (document) {
        for(i = 0;i < $scope.selectedDocuments.length; i++){
            var id = document.id;
            if(id === $scope.selectedDocuments[i].id){
                return true;
            }
        }
        return false;
    }

    $scope.selectDocument = function (document) {
        let found = false;
        for(i = 0;i < $scope.selectedDocuments.length; i++){
            var id = document.id;
            if(id === $scope.selectedDocuments[i].id){
                found = true;
                $scope.selectedDocuments.splice(i, 1)
            }
        }
        if (!found) {
            $scope.selectedDocuments.push(document)
        }
    }

    $scope.show = function(document) {
        $scope.showDocument = true;

        const urlDocument = mainController.getHost() + '/document.pdf'

        $http.get(urlDocument).then(function(res) {
            setTimeout(function(){
                $scope.setDocument(res);
            }, 500)
        });
    }

    $scope.sortCardsByColumnName = function(column){
        for (key in $scope.sort) {
            if (key != column){
                $scope.sort[key] = ''
            }
        }
        $scope.sort[column] = $scope.revertSortingOrder($scope.sort[column]);
        $scope.documents.sort((a, b) => $scope.customSort(a, b, column, $scope.sort[column]));
    }

    $scope.customSort = function(a, b, column, order) {
        if (a[column] > b[column]) {
            return order === 'asc'? 1: -1;
        } else if (a[column] < b[column]) {
            return order === 'asc'? -1: 1;
        } else {
            return 0;
        }
    }

    $scope.revertSortingOrder = function(sortOrder){
        if (sortOrder === 'asc') {
            return 'desc'
        } else {
            return 'asc'
        }
    }

}]);