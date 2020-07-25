<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="snamApp"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SNAM - IDM</title>

    <jsp:include page="subviews/cssSheets.jsp"></jsp:include>
</head>

<body ng-controller="commonController" id="page-top" class="background-snam text-lato-snam" ng-app="snamApp">

<nav id="dashboardNavbar" ng-if="!sidebarIsClosed" ng-controller="navbarController" ng-if="!sidebarIsClosed" class="navbar navbar-expand navbar-light bg-white topbar navbar-background-snam shadow" >
    <jsp:include page="subviews/dashboardNavbar.jsp"></jsp:include>
</nav>
<jsp:include page="subviews/dashboardSidebar.jsp"></jsp:include>

<div ng-controller="overviewFornitoreController">
    <div id="content-wrapper" class="d-flex flex-column" >
        <!-- Header Section -->
        <div class="header-section">
            <div class="container-fluid">
                <div class="col-lg-12 col-md-12 col-sm-12 mt-3">
                    <jsp:include page="subviews/breadcrumb.jsp"></jsp:include>
                    <div class="col-md-12 col-sm-12 col-lg-12 row">
                        <h3 class="my-auto font-bold">{{fornitoreOverview.name}}</h3>
                        <div class="ml-2 my-auto col-lg-1 col-md-1 col-sm-1">
                            <i class="text-primary fa fa-ellipsis-h" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="cursor: pointer;"></i>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                                <p class="text-primary dropdown-item no-margin-bottom" style="cursor: pointer;">
                                    <i class="far fa-edit fa-fw fa-lg pointer"></i>
                                    <span class="ml-2">Modifica</span>
                                </p>
                                <div class="dropdown-divider"></div>
                                <p class="text-primary dropdown-item no-margin-bottom" style="cursor: pointer;">
                                    <i class="far fa-trash-alt fa-fw fa-lg pointer"></i>
                                    <span class="ml-2">Elimina</span>
                                </p>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12 col-md-12 col-sm-12 mb-2" style="padding-left: 0rem !important;">
                        <div class="row mt-4">
                            <div class="col-lg-2 col-md-2 col-sm-12">
                                <div class="form-group">
                                    <label class="label-item">CIG</label>
                                    <p class="font-bold">{{bandoGara.cig}}</p>
                                </div>
                            </div>
                            <div class="col-lg-9 col-md-9 col-sm-12">
                                <div class="form-group">
                                    <label class="label-item">OGGETTO</label>
                                    <p class="font-bold">{{bandoGara.oggetto}}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End Header Section -->
        <!-- Main Section -->
        <div class="progress" style="height:.5rem;">
            <div class="pg-presence progress-bar bg-info" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
            <div class="pg-check progress-bar bg-danger" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
        <div class="container-fluid">
            <div class="col-lg-12 col-md-12 col-sm-12 mb-5 mt-3">
                <div class="row mt-2">
                    <!-- Show list -->
                    <div ng-hide="showDocument" class="col-lg-12 col-md-12 col-sm-12">
                        <div class="d-flex justify-content-end">
                            <button ng-click="openModalUploadDocument('uploadDocumentModalOverviewFornitore','fileselect2','filedrag2','imageUpload2')" class="btn button-primary-buyer m-1">
                                <i class="fas fa-plus"></i>
                                <span class="ml-1 text-size-14">AGGIUNGI DOCUMENTI</span>
                            </button>
                        </div>
                        <div class="card mt-2 no-border">
                            <div class="card-header d-flex justify-content-center">
                                <div class="col-lg-1 col-md-1 col-sm-1"></div>
                                <div ng-click="sortCardsByColumnName('name')" class="col-lg-5 col-md-5 col-sm-5 text-size-14 no-select">
                                    DOCUMENTO
                                    <i ng-if="sort.name === 'desc'" class="fas fa-sort-down hoverable sort-chev"></i>
                                    <i ng-if="sort.name === 'asc'" class="fas fa-sort-up hoverable sort-chev"></i>
                                </div>
                                <div ng-click="sortCardsByColumnName('uploadedAt')" class="col-lg-2 col-md-2 col-sm-2 text-size-14 no-select">
                                    CARICATO IL
                                    <i ng-if="sort.uploadedAt === 'desc'" class="fas fa-sort-down hoverable sort-chev"></i>
                                    <i ng-if="sort.uploadedAt === 'asc'" class="fas fa-sort-up hoverable sort-chev"></i>
                                </div>
                                <div ng-click="sortCardsByColumnName('conformity')" class="col-lg-2 col-md-2 col-sm-2 text-size-14 no-select">
                                    CONFORMITA
                                    <i ng-if="sort.conformity === 'desc'" class="fas fa-sort-down hoverable sort-chev"></i>
                                    <i ng-if="sort.conformity === 'asc'" class="fas fa-sort-up hoverable sort-chev"></i>
                                </div>
                                <div class="col-lg-2 col-md-2 col-sm-2"></div>
                            </div>
                        </div>
                        <div class="card" ng-repeat="document in documents">
                            <div class="card-body">
                                <div class="row">
                                    <div class="my-auto col-lg-1 col-md-1 col-sm-1">
                                        <input ng-checked="checkDocument(document)" ng-click="selectDocument(document)" type="checkbox" class="my-auto col-lg-7 col-md-7 col-sm-12 pointer">
                                        <i ng-if="document.presence === -1" class="my-auto ml-2 fas fa-exclamation-triangle pointer" style="color: red;"></i>
                                        <i ng-if="document.presence === 0" class="my-auto ml-2 fa fa-check-circle pointer" style="color: limegreen;"></i>
                                        <i ng-if="document.presence === 1" class="my-auto ml-2 fas fa-exclamation pointer" style="color: orange"></i>
                                    </div>
                                    <div class="my-auto  col-lg-5 col-md-5 col-sm-5">
                                        <div class="row flex-long-text">
                                            <i class="my-auto  ml-2 mr-2 fas fa-file-pdf fa-2x" style="color: red;"></i>
                                            <p class="my-auto  no-margin-bottom text-size-16 text-bold crop">{{document.name}}</p>
                                        </div>
                                    </div>
                                    <div class="my-auto col-lg-2 col-md-2 col-sm-2">
                                        <p class="my-auto  no-margin-bottom text-size-16 text-bold">{{document.uploadedAt | date: 'dd/MM/yyyy - HH:mm'}} </p>
                                    </div>
                                    <div class="my-auto col-lg-2 col-md-2 col-sm-2 text-size-14">
                                        <div ng-if="document.conformity === 0" class="my-auto col-lg-10 col-md-10 col-sm-10 conformity-box conformity-box-green"><i class="mr-2 fas fa-check"></i>CONFORME</div>
                                        <div ng-if="document.conformity === 1" class="my-auto col-lg-10 col-md-10 col-sm-10 conformity-box conformity-box-red"><i class="mr-2 fas fa-times"></i>NON CONFORME</div>
                                        <div ng-if="document.conformity === 2" class="my-auto col-lg-10 col-md-10 col-sm-10 conformity-box conformity-box-orange"><i class="mr-2 fas fa-times"></i>NON PREVISTO</div>
                                    </div>
                                    <div class="my-auto col-lg-2 col-md-2 col-sm-2">
                                        <div class="row icon-group" ng-if="document.presence >= 0">
                                            <!--<div class="m-1"><i class="my-auto  far fa-edit fa-fw fa-lg pointer"></i></div>-->
                                            <div class="m-1"><i class="my-auto  fas fa-sync fa-flip-horizontal fa-fw fa-lg pointer"></i></div>
                                            <div class="m-1"><i class="my-auto  far fa-trash-alt fa-fw fa-lg pointer"></i></div>
                                        </div>
                                        <div class="row icon-group fa-stack" ng-if="document.presence === -1">
                                            <div class="m-1"><i class="my-auto  fas fa-plus fa-fw fa-stack-1x pointer"></i></div>
                                            <div class="m-1"><i class="my-auto  far fa-circle fa-fw fa-stack-2x pointer"></i></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Show Document -->
                    <div class="col-lg-12 col-md-12 col-sm-12 mb-5" ng-show="showDocument">
                        <div class="row">
                            <div class="col-lg-5 col-md-5 col-sm-5">
                                <div class="d-flex justify-content-end">
                                    <button class="btn button-neutral-compare-advise m-1">
                                        <i class="fas fa-sync fa-flip-horizontal"></i>
                                        <span class="ml-1 text-size-12">SOSTITUISCI</span>
                                    </button>
                                    <button class="btn button-neutral-compare-advise m-1">
                                        <i class="far fa-trash-alt fa-fw fa-lg pointer"></i>
                                        <span class="ml-1 text-size-12">ELIMINA</span>
                                    </button>
                                </div>
                                <div class="card mt-2 no-border">
                                    <div class="card-header d-flex">
                                        <div class="col-lg-2 col-md-2 col-sm-2"></div>
                                        <div ng-click="sortCardsByColumnName('name')" class="col-lg-5 col-md-5 col-sm-5 text-size-14 no-select">
                                            DOCUMENTO
                                            <i ng-if="sort.name === 'desc'" class="fas fa-sort-down hoverable sort-chev"></i>
                                            <i ng-if="sort.name === 'asc'" class="fas fa-sort-up hoverable sort-chev"></i>
                                        </div>
                                        <div ng-click="sortCardsByColumnName('conformity')"  class="col-lg-3 col-md-3 col-sm-3 text-size-14">
                                            CONFORMITA
                                            <i ng-if="sort.conformity === 'desc'" class="fas fa-sort-down hoverable sort-chev"></i>
                                            <i ng-if="sort.conformity === 'asc'" class="fas fa-sort-up hoverable sort-chev"></i>
                                        </div>
                                        <div class="col-lg-2 col-md-2 col-sm-2"></div>
                                    </div>
                                </div>
                                <div class="card" ng-repeat="document in documents">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-lg-2 col-md-2 col-sm-2">
                                                <input ng-checked="checkDocument(document)" ng-click="selectDocument(document)" type="checkbox" class="my-auto col-lg-7 col-md-7 col-sm-12 pointer">
                                                <i ng-if="document.presence === -1" class="my-auto ml-2 fas fa-exclamation-triangle pointer" style="color: red;"></i>
                                                <i ng-if="document.presence === 0" class="my-auto ml-2 fa fa-check-circle pointer" style="color: limegreen;"></i>
                                                <i ng-if="document.presence === 1" class="my-auto ml-2 fas fa-exclamation pointer" style="color: orange"></i>
                                            </div>
                                            <div class="col-lg-5 col-md-5 col-sm-5">
                                                <div class="row flex-long-text">
                                                    <i class="my-auto  ml-2 mr-2 fas fa-file-pdf fa-lg" style="color: red;"></i>
                                                    <p class="my-auto no-margin-bottom text-size-16 text-bold crop">{{document.name}}</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-3 col-md-3 col-sm-3">
                                                <div ng-if="document.conformity === 0" class="my-auto  col-lg-12 col-md-12 col-sm-12 conformity-box conformity-box-green text-size-12"><i class="mr-2 fas fa-check"></i>CONFORME</div>
                                                <div ng-if="document.conformity === 1" class="my-auto col-lg-12 col-md-12 col-sm-12 conformity-box conformity-box-red text-size-12"><i class="mr-2 fas fa-times"></i>NON CONFORME</div>
                                                <div ng-if="document.conformity === 2" class="my-auto col-lg-12 col-md-12 col-sm-12 conformity-box conformity-box-orange text-size-12"><i class="mr-2 fas fa-times"></i>NON PREVISTO</div>
                                            </div>
                                            <div class="col-sm-2 col-lg-2 col-md-2 row icon-group">
                                                <!--<div class="m-1"><i class="my-auto  far fa-edit fa-fw fa-lg pointer"></i></div>-->
                                                <div class="m-1"><i class="my-auto  fas fa-sync fa-flip-horizontal fa-fw fa-lg pointer"></i></div>
                                                <div class="m-1"><i class="my-auto  far fa-trash-alt fa-fw fa-lg pointer"></i></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-7 col-md-7 col-sm-7">
                                <div class="card">
                                    <div class="card-header card-header-document-viewer">
                                        <div class="row text-size-14">
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group document-viewer-br">
                                                    <label class="label-item">DATA</label>
                                                    <p>Presente</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group document-viewer-br">
                                                    <label class="label-item">FIRMA</label>
                                                    <p>Presente</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group document-viewer-br">
                                                    <label class="label-item">TIMBRO</label>
                                                    <p>Presente</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group document-viewer-br">
                                                    <label class="label-item">CIG</label>
                                                    <p>Presente</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group">
                                                    <label class="label-item">NUMERO GARA</label>
                                                    <p>Presente</p>
                                                </div>
                                            </div>
                                            <div class="col-lg-2 col-md-2 col-sm-12">
                                                <div class="form-group expand-document-button">
                                                    <a class="document-fullview" target="_blank" href="">
                                                        <i class="fas fa-expand-arrows-alt fa-2x"></i>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <object class="document-container" data="" type="application/pdf" width="100%" style="height: 150vh">
                                            <embed class="document-container" src="" type="application/pdf"></embed>
                                        </object>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- End of Main Section -->
    </div>
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>
    <jsp:include page="subviews/modal/uploadDocumentModalOverviewFornitore.jsp"></jsp:include>
</div>

</body>
<jsp:include page="subviews/scripts.jsp"></jsp:include>
<script type="text/javascript" src="./webapp/AngularJS/controllers/overviewFornitoreController.js"></script>