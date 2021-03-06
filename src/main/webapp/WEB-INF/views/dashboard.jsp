<%--
  Created by IntelliJ IDEA.
  User: Sebastian Adamo
  Date: 5/24/2020
  Time: 1:01 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Sprint</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">

    <!-- jQuery -->
    <script
            src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
            crossorigin="anonymous">
    </script>
    <!-- jQuery UI -->
    <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous">
    </script>
    <!-- Popper JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous">
    </script>
    <!-- Bootstrap -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous">
    </script>

    <!-- jQuery Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>

    <link href='https://fonts.googleapis.com/css?family=Permanent+Marker' rel='stylesheet' type='text/css'>

    <script src="<c:url value="/resources/scripts/main.js"/>"></script>
    <script src="<c:url value="/resources/scripts/dashboard_my-boards.js"/>"></script>
    <script src="<c:url value="/resources/scripts/dashboard_teams.js"/>"></script>
    <!-- Calendar File HERE -->
    <script src="<c:url value="/resources/scripts/dashboard_user-settings.js"/>"></script>
</head>
<body>
<div class="page-wrapper chiller-theme">
    <!-- Sidebar -->
    <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content">
            <div class="sidebar-brand">
                <a href="${pageContext.request.contextPath}/dashboard">Sprint</a>
            </div>
            <!-- Dashboard Navigation -->
            <div class="sidebar-menu">
                <ul>
                    <li class="header-menu">
                        <span>NAVIGATION</span>
                    </li>
                    <li>
                        <a onclick="displayDashboard()">
                            <i class="fa fa-home"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a onclick="displayMyBoards()">
                            <i class="fa fa-th-list"></i>
                            <span>My Boards</span>
                        </a>
                    </li>
                    <li>
                        <a onclick="displayTeams()">
                            <i class="fa fa-users"></i>
                            <span>Teams</span>
                        </a>
                    </li>
                    <li>
                        <a onclick="">
                            <i class="fa fa-calendar"></i>
                            <span>Calendar</span>
                        </a>
                    </li>
                    <li>
                        <a onclick="displaySettings()">
                            <i class="fa fa-cog"></i>
                            <span>Settings</span>
                        </a>
                    </li>
                </ul>
            </div>
            <!-- !Dashboard Navigation -->

            <!-- Recent Boards -->
            <div class="sidebar-menu">
                <ul>
                    <li class="header-menu">
                        <span>RECENT BOARDS</span>
                    </li>
                    <c:forEach items="${user.recentBoards}" var="recentBoard">
                        <li>
                            <a href="${pageContext.request.contextPath}/tasks?id=${recentBoard.id}">
                                <i class="fa fa-th-list"></i>
                                <span>${recentBoard.name}</span>
                            </a>
                        </li>
                    </c:forEach>
                </ul>
            </div>
            <!-- !Recent Boards -->
        </div>
    </nav>
    <!-- !Sidebar -->

    <!-- Main Wrapper -->
    <main class="page-content">
        <!-- Navbar -->
        <nav id="navbar" class="navbar navbar-expand-sm bg-dark navbar-dark">
            <!-- Logo -->
            <a style="padding-top: 25px;" id="logo" class="navbar-brand" href="${pageContext.request.contextPath}/dashboard"><img src="<c:url value="/resources/images/logo.svg"/>" style="width: 120px; height: 60px;" alt="logo"/></a>
            <!-- !Logo -->
            <!-- Left Side -->
            <ul class="navbar-nav">
                <!-- Menu -->
                <li class="nav-item">
                    <a id="show-sidebar" class="nav-link" onclick="toggleSidebar()"><i class="material-icons">menu</i></a>
                </li>
                <!-- !Menu -->
                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="material-icons">home</i></a>
                </li>
                <!-- !Home -->
            </ul>
            <!-- !Left Side -->
            <!-- Right Side -->
            <ul class="navbar-nav ml-auto">
                <!-- Notifications -->
                <li id="notifications-dropdown" class="nav-item dropdown">
                    <a class="nav-link" href="#" id="notifications" data-toggle="dropdown">
                        <i class="material-icons">notifications</i>
                            <span class="badge badge-pill badge-danger notification">
                            </span>
                    </a>
                    <div style="width: 500px !important;" class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-header">Notifications</a>
                        <div class="dropdown-divider"></div>
                        <a data-toggle="modal" data-target="#notification-modal" class="dropdown-item">View all notifications</a>
                    </div>
                </li>
                <!-- !Notifications -->
                <!-- User -->
                <li class="nav-item dropdown">
                    <a class="nav-link" id="navbardrop" data-toggle="dropdown">
                        <i class="material-icons">account_circle</i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-header">Account</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" onclick="displaySettings()">Edit Details</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" onclick="displaySettings()">Settings</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </li>
                <!-- !User -->
            </ul>
            <!-- !Right Side -->
        </nav>
        <!-- !Navbar -->
        <!-- Main Content -->
        <div style="padding-left: 25%; padding-right: 25%" id="content-container" class="container-fluid">

            <!-- Dashboard -->
            <div id="dashboard-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <div style="padding-top: 56px" id="board-grid" class="grid">
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displayMyBoards()">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">view_list</i></p>
                                        <p class="card-text">My Boards</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displayTeams()">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">group</i></p>
                                        <p class="card-text">Teams</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displayCalendar()">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">calendar_today</i></p>
                                        <p class="card-text">Calendar</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displaySettings()">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">settings</i></p>
                                        <p class="card-text">Settings</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- !Dashboard -->

            <!-- MyBoards -->
            <div style="display: none" id="my-boards-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <i style="color: #818896; padding: 1rem" class="material-icons" onmouseover="this.style.cursor='pointer';" onclick="displayDashboard()">arrow_back</i>

                    <div id="my-boards-grid" class="grid">
                        <c:forEach items="${user.myBoards}" var="board">
                            <div class="module">
                                <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                    <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="updateRecent('${board.id}')" href="${pageContext.request.contextPath}/board?id=${board.id}">
                                        <div style="height: 75%; text-align: center; padding-top: 30%" class="card-body">
                                            <p class="card-text">${board.name}</p>
                                        </div>
                                    </a>
                                    <div class="card-footer">
                                        <a class="material-icons" style="text-decoration: none; color: black" href="#edit-my-board-modal" rel="modal:open" onclick="getMyBoard('${board.id}')" data-toggle="tooltip" data-placement="bottom" title="Edit Details"><i class="material-icons">create</i></a>
                                        <i class="material-icons" onclick="deleteMyBoard('${board.id}')" data-toggle="tooltip" data-placement="bottom" title="Delete">delete</i>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Create Board -->
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#my-board-modal" rel="modal:open">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">add</i></p>
                                        <p class="card-text">Create Board</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <!-- !Create Board -->
                    </div>
                </div>
            </div>
            <!-- !MyBoards -->

            <!-- Teams -->
            <div style="display: none" id="teams-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <i style="color: #818896; padding: 1rem" class="material-icons" onmouseover="this.style.cursor='pointer';" onclick="displayDashboard()">arrow_back</i>
                    <div id="team-grid" class="grid">
                        <c:forEach items="${user.teamRoles}" var="teamRole">
                            <div class="module">
                                <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                    <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displayTeamDetails('${teamRole.team.id}')">
                                        <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                            <p class="card-text"><i class="material-icons">group</i></p>
                                            <p class="card-text">${teamRole.team.name}</p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>

                        <!-- Create Team -->
                        <div class="module">
                            <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#create-team-modal" rel="modal:open">
                                    <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                        <p class="card-text"><i class="material-icons">add</i></p>
                                        <p class="card-text">Create Team</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                        <!-- !Create Team -->
                    </div>
                </div>
            </div>
            <!-- !Teams -->

            <!-- Team Details -->
            <div style="display: none" id="team-details-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <i style="color: #818896; padding: 1rem" class="material-icons" onmouseover="this.style.cursor='pointer';" onclick="displayTeams()">arrow_back</i>
                    <ul class="nav nav-tabs nav-justified" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="team-boards-tab" data-toggle="tab" href="#team-boards" role="tab" aria-controls="home" aria-selected="true"><i class="material-icons">view_list</i></a>
                        </li>
                        <li class="nav-item">
                            <a onclick="getTeamDetails()" class="nav-link" id="team-details-tab" data-toggle="tab" href="#team-details" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">description</i></a>
                        </li>
                        <li class="nav-item">
                            <a onclick="getTeamMembers()" class="nav-link" id="team-members-tab" data-toggle="tab" href="#team-members" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">group_add</i></a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!-- Team Boards -->
                        <div class="tab-pane fade show active" id="team-boards" role="tabpanel" aria-labelledby="team-boards-tab">
                            <div style="padding-top: 2rem" id="team-boards-grid" class="grid">
                                <!-- Team Boards Prepended Here -->
                                <!-- Create Team Board -->
                                <div class="module">
                                    <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                        <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#create-team-board-modal" rel="modal:open">
                                            <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                                <p class="card-text"><i class="material-icons">add</i></p>
                                                <p class="card-text">Create Board</p>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <!-- !Create Team Board -->
                            </div>
                        </div>
                        <!-- !Team Boards -->
                        <!-- Team Details -->
                        <div class="tab-pane fade" id="team-details" role="tabpanel" aria-labelledby="team-details-tab" >
                            <div class="form-container">
                                <form class="text-center p-5">
                                    <label for="team-name">Team Name</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="team-name" class="form-control mb-4" readonly>
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="team-description">Team description</label>
                                        <textarea class="form-control rounded-0" id="team-description" rows="5" name="description" placeholder="Enter a description..." onfocusout="saveTeamDetails()"></textarea>
                                    </div>
                                    <hr/>
                                    <button style="margin-top: 2rem" class="btn btn-info btn-block btn-danger" type="button" onclick="deleteTeam()">Delete Team</button>
                                </form>

                            </div>
                        </div>
                        <!-- !Team Details -->
                        <!-- Team Members -->
                        <div class="tab-pane fade" id="team-members" role="tabpanel" aria-labelledby="team-members-tab" >
                            <div class="form-container">
                                <!-- User Search -->
                                <form class="form-inline d-flex md-form form-sm mt-0">
                                    <i style="margin-left: 22.5%" class="fas fa-search" aria-hidden="true"></i>
                                    <input id="user-search" class="form-control form-control-sm ml-3 w-50" type="text" placeholder="Search" aria-label="Search" onchange="searchUser()">
                                </form>
                                <ul id="user-search-result" style="list-style: none">

                                </ul>
                                <!-- !User Search -->
                                <!-- User Table -->
                                <table style="width: 80%; margin-left: 7.5%" class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th scope="col"></th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Username</th>
                                        <th scope="col">Role</th>
                                        <th scope="col">Status</th>
                                    </tr>
                                    </thead>
                                    <tbody id="team-members-table">

                                    </tbody>
                                </table>
                                <!-- !User Table -->
                            </div>
                        </div>
                        <!-- !Team Members -->
                    </div>
                </div>
            </div>
            <!-- !Team Details -->

            <!-- Settings -->
            <div style="display: none" id="settings-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <i style="color: #818896; padding: 1rem" class="material-icons" onmouseover="this.style.cursor='pointer';" onclick="displayDashboard()">arrow_back</i>
                    <ul class="nav nav-tabs nav-justified" id="account-overlay-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="details-tab" data-toggle="tab" href="#details" role="tab" aria-controls="home" aria-selected="true"><i class="material-icons">portrait</i></a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="settings-tab" data-toggle="tab" href="#settings" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">settings</i></a>
                        </li>
                    </ul>
                    <div class="tab-content" id="account-overlay-tab-content">
                        <div class="tab-pane fade show active" id="details" role="tabpanel" aria-labelledby="details-tab">
                            <div class="form-container">
                                <form id="account-form" class="text-center p-5">
                                    <label for="account-username">Username</label>
                                    <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="account-username" class="form-control mb-4" value="${user.username}" readonly>
                                    <label for="account-name">Name</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="account-name" name="name" class="form-control mb-4" value="${user.name}" placeholder="Enter your name..." onfocusout="updateName()">
                                    <label for="account-company">Company</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px;" type="text" id="account-company" name="company" class="form-control mb-4" value="${user.company}" placeholder="Enter your company name..." onfocusout="updateCompany()">
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="account-bio">Bio</label>
                                        <textarea class="form-control rounded-0" id="account-bio" rows="3" name="bio" placeholder="Enter a bio..." onfocusout="updateBio()">${user.bio}</textarea>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings-tab" >
                            <div class="form-container">
                                <div class="change-container" id="change-email">
                                    <div id="change-email-text">
                                        <span class="change-text" onclick="$('#change-email').load(' #change-email-form > *')">Change Email?</span>
                                    </div>
                                    <div style="display: none" id="change-email-form">
                                        <form class="text-center p-5">
                                            <label for="account-email">Email</label>
                                            <input style="margin-bottom: 10px !important; margin-top: 8px; width: 350px" type="text" id="account-email" class="form-control mb-4" name="email" value="${user.email}" placeholder="Enter an email address..." readonly>
                                            <button id="login-button" class="btn btn-info btn-block" type="button">Change</button>
                                            <button style="margin-top: 1rem" class="btn btn-info btn-block btn-danger" type="button" onclick="$('#change-email').load(' #change-email-text > *')">Cancel</button>
                                        </form>
                                    </div>
                                </div>
                                <div class="change-container" id="change-password">
                                    <div id="change-password-text">
                                        <span class="change-text" onclick="$('#change-password').load(' #change-password-form > *')">Change Password?</span>
                                    </div>
                                    <div style="display: none;" id="change-password-form">
                                        <form class="text-center p-5">
                                            <label for="account-new-password">New Password</label>
                                            <input style="margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="password" id="account-new-password" class="form-control mb-4" placeholder="Enter new password...">
                                            <label for="account-confirm-password">Confirm Password</label>
                                            <input style="margin-bottom: 14px !important; margin-top: 8px;" type="password" id="account-confirm-password" class="form-control mb-4" placeholder="Confirm password...">
                                            <button id="login-button" class="btn btn-info btn-block" type="button" onclick="savePassword()">Save</button>
                                            <button style="margin-top: 1rem" class="btn btn-info btn-block btn-danger" type="button" onclick="$('#change-password').load(' #change-password-text > *')">Cancel</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- !Settings -->

        </div>
        <!-- !Main Content -->

        <!-- Modals -->

        <!-- Edit Board Modal -->
        <div style="width: 70%; height: 60%" id="edit-my-board-modal" class="modal">
            <form style="padding-top: 1rem !important;" id="edit-board-form" class="text-center p-5">
                <label for="edit-my-board-name">Name</label>
                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="edit-my-board-name" class="form-control mb-4" placeholder="Enter a name..." onfocusout="updateMyBoard()">
                <div style="margin-top: 8px;" class="form-group">
                    <label for="edit-my-board-description">Description</label>
                    <textarea class="form-control rounded-0" id="edit-my-board-description" rows="3" name="description" placeholder="Enter a description..." onfocusout="updateMyBoard()"></textarea>
                </div>
                <div style="margin-top: 8px;" class="form-group">
                    <label for="edit-my-board-dod">Definition of Done</label>
                    <textarea class="form-control rounded-0" id="edit-my-board-dod" rows="3" name="dod" placeholder="Enter a definition of done..." onfocusout="updateMyBoard()"></textarea>
                </div>
            </form>
        </div>
        <!-- !Edit Board Modal -->


        <!-- My Board Modal -->
        <div style="width: 70%; height: 60%" id="my-board-modal" class="modal">
            <input id="my-board-id" style="display: none">
            <form style="padding-top: 1rem !important;" id="create-board-form" class="text-center p-5">
                <label for="my-board-name">Name</label>
                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="my-board-name" class="form-control mb-4" placeholder="Enter a name...">
                <div style="margin-top: 8px;" class="form-group">
                    <label for="my-board-description">Description</label>
                    <textarea class="form-control rounded-0" id="my-board-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                </div>
                <div style="margin-top: 8px;" class="form-group">
                    <label for="my-board-dod">Definition of Done</label>
                    <textarea class="form-control rounded-0" id="my-board-dod" rows="3" name="dod" placeholder="Enter a definition of done..."></textarea>
                </div>
                <button id="create-my-board" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="addMyBoard()">Create</button>
            </form>
        </div>
        <!-- !My Board Modal -->

        <!-- Create Team Modal -->
        <div style="width: 70%; height: 60%" id="create-team-modal" class="modal">
            <form style="padding-top: 1rem !important;" id="create-team-form" class="text-center p-5">
                <label for="create-team-name">Name</label>
                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="create-team-name" class="form-control mb-4" placeholder="Enter a team name...">
                <div style="margin-top: 8px;" class="form-group">
                    <label for="create-team-description">Description</label>
                    <textarea class="form-control rounded-0" id="create-team-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                </div>
                <button id="create-team" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="createTeam()">Create</button>
            </form>
        </div>
        <!-- !Create Team Modal -->

        <!-- Create Team Board Modal -->
        <div style="width: 70%; height: 60%" id="create-team-board-modal" class="modal">
            <form style="padding-top: 1rem !important;" id="create-team-board-form" class="text-center p-5">
                <label for="create-team-board-name">Name</label>
                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="create-team-board-name" class="form-control mb-4" placeholder="Enter a name...">
                <div style="margin-top: 8px;" class="form-group">
                    <label for="create-team-board-description">Description</label>
                    <textarea class="form-control rounded-0" id="create-team-board-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                </div>
                <div style="margin-top: 8px;" class="form-group">
                    <label for="create-team-board-dod">Definition of Done</label>
                    <textarea class="form-control rounded-0" id="create-team-board-dod" rows="3" name="dod" placeholder="Enter a definition of done..."></textarea>
                </div>
                <button id="create-team-board" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="createTeamBoard()">Create</button>
            </form>
        </div>
        <!-- !Create Team Board Modal -->

        <!-- !Modals -->
    </main>

</div>
</body>

<script>
    function displayDashboard() {
        $('#content-container').load(' #dashboard-row > *');
    }

    function displayMyBoards() {
        $('#content-container').load(' #my-boards-row > *');
    }

    function displayTeams() {
        $('#content-container').load(' #teams-row > *');
    }

    function displaySettings() {
        $('#content-container').load(' #settings-row > *');
    }
</script>
</html>
