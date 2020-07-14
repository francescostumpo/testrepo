<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="snamApp"%>
<!-- Sidebar Toggle (Topbar) -->
<button id="sidebarToggleTop" ng-click="toggleSideBar()" class="btn btn-link rounded-circle mr-3">
	<i class="fa fa-bars"></i>
</button>
<div id="homepage" class="d-md-none mr-3">
	<img class="navbar-brand" src="webapp/img/snam-logo.png" height="10%"
		width="10%" style="cursor: pointer;" ></img>
</div>

	<div class="d-none d-md-block">
		<img class="navbar-brand" src="webapp/img/snam-logo.png"
			width="5%" style="cursor: pointer;" ng-click="goToViewNavigation('/dashboard')"></img>
		<a class=""	style="cursor: pointer; color: white; letter-spacing: 0.2px; font-weight: bold; font-size: 18px"	>
			INTELLIGENT DOCUMENT MANAGEMENT
		</a>
	</div>

	<ul class="navbar-nav ml-auto">
		<button style="width: 70%" type="button" class="my-auto btn button-primary-buyer" >
			<i class="fas fa-plus"></i>
			<span>Nuova gara</span>
		</button>
		<li class="nav-item dropdown ml-4 no-arrow mx-1">
			<a class="nav-link dropdown-toggle"  id="alertsDropdown"
			role="button" data-toggle="dropdown" aria-haspopup="true"
			aria-expanded="false"> <i style="color:white;cursor:pointer;" class="fas fa-bell fa-1point5 "></i> <!--  Counter - Alerts -->
				<div>
					<span class="badge badge-danger badge-counter">1</span>
				</div>
			</a>
			<div style="width: 450px!important;"
				class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="alertsDropdown">
				<h6 class="dropdown-header" style="font-size:16px; color: #004B9C; background-color: white !important; border: 1px solid #CFD6DB !important;">NOTIFICHE</h6>
				<div>
					<div class="card">
						<div class="card-body">
							Nessuna notifica
						</div>
					</div>
				</div>
			</div>
		</li>
	<li class="nav-item dropdown no-arrow mx-1">

</li>

	<div class="topbar-divider d-none d-sm-block"></div>
	<li class="nav-item dropdown no-arrow">
		<div
			class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
			aria-labelledby="userDropdown">
			<!--<a style="cursor:pointer;" class="dropdown-item" href="/settings"> <i
				class="text-primary fas fa-cogs fa-sm fa-fw mr-2 "></i> <snamApp:out value="${currentDictionary.settingsTitle}"></snamApp:out>
			</a>
			<div class="dropdown-divider"></div>-->
			<a style="cursor:pointer;" class="dropdown-item">
				<i	class="text-primary fas fa-sign-out-alt fa-sm fa-fw mr-2 "></i>
				Logout
			</a>
		</div>
		<a
				class="nav-link dropdown-toggle"  id="userDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false">
			<i style="cursor:pointer; color: white" class="far fa-user-circle fa-1point5 fa-sm fa-fw mr-2" style="color:white;"></i>
			<span class="mr-2 d-none d-lg-inline"	style="color: white" id="userName">
				Luca Santamaria
			</span>
		</a>
	</li>
</ul>