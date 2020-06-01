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
    <title>${board.name} - Sprint</title>

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
    <!-- Tether JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
    <!-- Bootstrap Datepicker -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css"/>

    <!-- Sortable JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.1/Sortable.min.js"
            integrity="sha256-9D6DlNlpDfh0C8buQ6NXxrOdLo/wqFUwEB1s70obwfE="
            crossorigin="anonymous">
    </script>

    <link href='https://fonts.googleapis.com/css?family=Permanent+Marker' rel='stylesheet' type='text/css'>

    <script src="<c:url value="/resources/scripts/main.js"/>"></script>
    <script src="<c:url value="/resources/scripts/tasks-task-overlay.js"/>"></script>
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
                        <a  href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa fa-home"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li>
                        <a  href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa fa-th-list"></i>
                            <span>My Boards</span>
                        </a>
                    </li>
                    <li>
                        <a  href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa fa-users"></i>
                            <span>Teams</span>
                        </a>
                    </li>
                    <li>
                        <a  href="${pageContext.request.contextPath}/dashboard">
                            <i class="fa fa-calendar"></i>
                            <span>Calendar</span>
                        </a>
                    </li>
                    <li>
                        <a  href="${pageContext.request.contextPath}/dashboard">
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
                                <a data-toggle="modal" data-target="#notification-modal" onmouseover="refreshNotification(${notification.id})" class="dropdown-item">${notification.description}</a>
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
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">Edit Details</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/dashboard">Settings</a>
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
        <div id="content-container" class="container-fluid">

            <div id="list-row" class="row">
                <!-- Backlog List -->
                <div style="height: 750px" class="col-lg-3">
                    <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 0;" class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <h1 class="display-4">Backlog</h1>
                        </div>
                        <div class="lists">
                            <ul id="backlog-list" class="ul-list">
                                <c:forEach items="${board.backlog}" var="task">
                                    <li style="padding-left: 7.5%; padding-top: 5%">
                                        <div onmouseover="setMoveTaskId('${task.id}')" style="width: 90%; height: 25%" class="card list-card boards-card">
                                            <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#task-modal" rel="modal:open" onclick="getTaskDetails(${task.id}); getTaskProgress(); getTaskActivity()">
                                                <div style="height: 75%; text-align: center; padding-top: 4rem" class="card-body">
                                                    <p class="card-text">${task.name}</p>
                                                    <div class="progress md-progress" style="width: 80%;height: 10px; margin-top: 1rem; margin-left: 10%">
                                                        <div id="task-card-progress-bar" class="progress-bar" role="progressbar" style="width: ${task.progress}%; height: 20px; background-color: #66bb6a" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </a>
                                            <div class="card-footer">
                                                <c:choose>
                                                    <c:when test="${task.usersVoted.contains(user)}">
                                                        <i class="material-icons" style="color: #66bb6a; float: left;" onclick="unvoteTask('${task.id}')">thumb_up</i>
                                                        <span class="date sub-text" style="float: left; margin-left: 0.5rem; font-size: 16px">${fn:length(task.usersVoted)}</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <i class="material-icons" style="float: left" onclick="voteOnTask('${task.id}')">thumb_up</i>
                                                    </c:otherwise>
                                                </c:choose>
                                                <i class="material-icons" style="float: right"  onclick="deleteTask('${task.id}')">delete</i>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                            <div style="margin: 10%; width: 81.5%; height: 10%; " class="card list-card">
                                <div style="text-align: center;" class="card-body">
                                    <input class="new-card-box" placeholder="Enter new task" id="new-backlog-task" type="text" onfocusout="addTask('backlog')">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- !Backlog List -->

                <!-- TODO List -->
                <div style="height: 750px" class="col-lg-3">
                    <div class="container">
                        <h1 class="display-4">TODO</h1>
                    </div>
                    <div class="lists">
                        <ul id="todo-list" class="ul-list">
                            <c:forEach items="${board.todo}" var="task">
                                <li style="padding-left: 7.5%; padding-top: 5%">
                                    <div onmouseover="setMoveTaskId('${task.id}')" style="width: 90%; height: 25%" class="card list-card boards-card">
                                        <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#task-modal" rel="modal:open" onclick="getTaskDetails(${task.id}); getTaskProgress(); getTaskActivity()">
                                            <div style="height: 75%; text-align: center; padding-top: 4rem" class="card-body">
                                                <p class="card-text">${task.name}</p>
                                                <div class="progress md-progress" style="width: 80%;height: 10px; margin-top: 1rem; margin-left: 10%">
                                                    <div id="task-card-progress-bar" class="progress-bar" role="progressbar" style="width: ${task.progress}%; height: 20px; background-color: #66bb6a" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${task.usersVoted.contains(user)}">
                                                    <i class="material-icons" style="color: #66bb6a; float: left;" onclick="unvoteTask('${task.id}')">thumb_up</i>
                                                    <span class="date sub-text" style="float: left; margin-left: 0.5rem; font-size: 16px">${fn:length(task.usersVoted)}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="material-icons" style="float: left" onclick="voteOnTask('${task.id}')">thumb_up</i>
                                                </c:otherwise>
                                            </c:choose>
                                            <i class="material-icons" style="float: right" onclick="deleteTask('${task.id}')">delete</i>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div style="margin: 10%; width: 81.5%; height: 10%; " class="card list-card">
                            <div style="text-align: center;" class="card-body">
                                <input class="new-card-box" placeholder="Enter new task" id="new-todo-task" type="text" onfocusout="addTask('todo')">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- !TODO List -->

                <!-- In Progress List -->
                <div style="height: 750px" class="col-lg-3">
                    <div class="container">
                        <h1 class="display-4">In Progress</h1>
                    </div>
                    <div class="lists">
                        <ul id="inprogress-list" class="ul-list">
                            <c:forEach items="${board.inprogress}" var="task">
                                <li style="padding-left: 7.5%; padding-top: 5%">
                                    <div onmouseover="setMoveTaskId('${task.id}')" style="width: 90%; height: 25%" class="card list-card boards-card">
                                        <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#task-modal" rel="modal:open" onclick="getTaskDetails(${task.id}); getTaskProgress(); getTaskActivity()">
                                            <div style="height: 75%; text-align: center; padding-top: 4rem" class="card-body">
                                                <p class="card-text">${task.name}</p>
                                                <div class="progress md-progress" style="width: 80%;height: 10px; margin-top: 1rem; margin-left: 10%">
                                                    <div id="task-card-progress-bar" class="progress-bar" role="progressbar" style="width: ${task.progress}%; height: 20px; background-color: #66bb6a" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${task.usersVoted.contains(user)}">
                                                    <i class="material-icons" style="color: #66bb6a; float: left;" onclick="unvoteTask('${task.id}')">thumb_up</i>
                                                    <span class="date sub-text" style="float: left; margin-left: 0.5rem; font-size: 16px">${fn:length(task.usersVoted)}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="material-icons" style="float: left" onclick="voteOnTask('${task.id}')">thumb_up</i>
                                                </c:otherwise>
                                            </c:choose>
                                            <i class="material-icons" style="float: right" onclick="deleteTask('${task.id}')">delete</i>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div style="margin: 10%; width: 81.5%; height: 10%; " class="card list-card">
                            <div style="text-align: center;" class="card-body">
                                <input class="new-card-box" placeholder="Enter new task" id="new-inprogress-task" type="text" onfocusout="addTask('inprogress')">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- !In Progress List -->

                <!-- Complete List -->
                <div style="height: 750px" class="col-lg-3">
                    <div class="container">
                        <h1 class="display-4">Complete</h1>
                    </div>
                    <div class="lists">
                        <ul id="complete-list" class="ul-list">
                            <c:forEach items="${board.complete}" var="task">
                                <li style="padding-left: 7.5%; padding-top: 5%">
                                    <div onmouseover="setMoveTaskId('${task.id}')" style="width: 90%; height: 25%" class="card list-card boards-card">
                                        <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="#task-modal" rel="modal:open" onclick="getTaskDetails(${task.id}); getTaskProgress(); getTaskActivity()">
                                            <div style="height: 75%; text-align: center; padding-top: 4rem" class="card-body">
                                                <p class="card-text">${task.name}</p>
                                                <div class="progress md-progress" style="width: 80%;height: 10px; margin-top: 1rem; margin-left: 10%">
                                                    <div class="progress-bar" role="progressbar" style="width: ${task.progress}%; height: 20px; background-color: #66bb6a" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                                                </div>
                                            </div>
                                        </a>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${task.usersVoted.contains(user)}">
                                                    <i class="material-icons" style="color: #66bb6a; float: left;" onclick="unvoteTask('${task.id}')">thumb_up</i>
                                                    <span class="date sub-text" style="float: left; margin-left: 0.5rem; font-size: 16px">${fn:length(task.usersVoted)}</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="material-icons" style="float: left" onclick="voteOnTask('${task.id}')">thumb_up</i>
                                                </c:otherwise>
                                            </c:choose>
                                            <i class="material-icons" style="float: right"  onclick="deleteTask('${task.id}')">delete</i>
                                        </div>
                                    </div>
                                </li>
                            </c:forEach>
                        </ul>
                        <div style="margin: 10%; width: 81.5%; height: 10%; " class="card list-card">
                            <div style="text-align: center;" class="card-body">
                                <input class="new-card-box" placeholder="Enter new task" id="new-complete-task" type="text" onfocusout="addTask('complete')">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- !Complete List -->
            </div>

                <!-- Task Modal -->
                <div style="width: 70%; height: 77.5% !important;" id="task-modal" class="modal">
                    <ul class="nav nav-tabs nav-justified" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="task-details-tab" data-toggle="tab" href="#task-details" role="tab" aria-controls="home" aria-selected="true"><i class="material-icons">notes</i></a>
                        </li>
                        <li class="nav-item">
                            <a onclick="getTaskProgress()" class="nav-link" id="task-progress-tab" data-toggle="tab" href="#task-progress" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">done_all</i></a>
                        </li>
                        <li class="nav-item">
                            <a onclick="getTaskActivity()" class="nav-link" id="task-comments-tab" data-toggle="tab" href="#task-comments" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">share</i></a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!-- Task Details -->
                        <div class="tab-pane fade show active" id="task-details" role="tabpanel" aria-labelledby="task-details-tab-tab">
                            <div class="form-container">
                                <form style="padding-top: 1rem !important;" id="task-details-form" class="text-center p-5">
                                    <label for="task-name">Name</label>
                                    <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="task-name" class="form-control mb-4" onfocusout="saveTaskName()" placeholder="Enter a name...">
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="task-description">Description</label>
                                        <textarea class="form-control rounded-0" id="task-description" rows="3" name="description" placeholder="Enter a description..." onfocusout="saveTaskDescription()"></textarea>
                                    </div>
                                    <div class="round">
                                        <input type="checkbox" id="task-dod"/>
                                        <label onclick="updateDod()" for="task-dod"></label>
                                        <span style="float: left; margin-left: 2.5rem; padding-top: 3px">Definition of Done</span>
                                    </div>
                                    <label for="task-due-date">Due Date</label>
                                    <div class="input-append date form_datetime">
                                        <input id="task-due-date" style="width: 70%; margin-left: 15%" class="form-control" name="date" placeholder="Enter a due date..." type="text" onchange="setTaskDueDate()"/>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- !Task Details -->
                        <!-- Task Progress -->
                        <div class="tab-pane fade" id="task-progress" role="tabpanel" aria-labelledby="task-progress-tab" >
                            <div class="form-container">
                                <form style="padding-top: 1rem !important; padding-bottom: 0 !important;" id="task-progress-form" class="text-center p-5">
                                    <label style="padding-top: 1rem" for="task-progress-bar">Progress</label>
                                    <div class="progress md-progress" style="width: 350px;height: 20px; margin-top: 1rem; margin-bottom: 1rem;">
                                        <div id="task-progress-bar" class="progress-bar" role="progressbar" style="width: 25%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
                                    </div>
                                </form>
                                <div style="padding: 0" class="modal-body">
                                    <ul style="list-style: none" id="task-todo-list">
                                        <!-- TODO list appended here -->
                                    </ul>
                                    <ul style="list-style: none">
                                        <li>
                                            <div style="padding-left: 2.3rem" class="round">
                                                <input style="margin-bottom: 10px !important; margin-top: 3rem; width: 350px;" type="text" id="new-task-todo" class="form-control mb-4" placeholder="Add a new TODO" onfocusout="addTaskTodo()">
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- !Task Progress -->
                        <!-- Task Activity -->
                        <div class="tab-pane fade" id="task-comments" role="tabpanel" aria-labelledby="task-comments-tab" >
                            <div class="form-container">
                                <form style="padding-top: 1rem !important; padding-bottom: 0 !important;" id="task-activity-form" class="text-center">
                                    <label for="task-activity-comment">Activity</label>
                                    <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 500px;" type="text" id="task-activity-comment" class="form-control mb-4" placeholder="Add a comment...">
                                    <button id="add-task-comment" style="background: #31353D; border-color: #31353D; width: 25%; margin-left: 75%" class="btn btn-info btn-block" type="button" onclick="addTaskComment()">Comment</button>
                                </form>
                                <div style="padding: 0" class="modal-body">
                                    <div class="actionBox">
                                        <ul id="task-comment-list" class="commentList">

                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- !Task Activity -->
                    </div>
                </div>
                <!-- !Task Modal -->
        </div>
        <!-- !Main Content -->
    </main>
    <!-- !Main Wrapper -->
</div>
</body>
<script>

    $("#task-due-date").datepicker({
        orientation: "bottom auto",
    });

    function addTask(list) {
        let task;
        switch (list) {
            case "backlog":
                task = $('#new-backlog-task');
                $.ajax({
                    url: "/tasks/add?name=" + task.val() + "&list=" + list,
                    success: function () {
                        task.val('');
                        $('#list-row').load(' #list-row > *');
                    }
                });
                break;
            case "todo":
                task = $('#new-todo-task');
                $.ajax({
                    url: "/tasks/add?name=" + task.val() + "&list=" + list,
                    success: function () {
                        task.val('');
                        $('#list-row').load(' #list-row > *');
                    }
                });
                break;
            case "inprogress":
                task = $('#new-inprogress-task');
                $.ajax({
                    url: "/tasks/add?name=" + task.val() + "&list=" + list,
                    success: function () {
                        task.val('');
                        $('#list-row').load(' #list-row > *');
                    }
                });
                break;
            case "complete":
                task = $('#new-complete-task');
                $.ajax({
                    url: "/tasks/add?name=" + task.val() + "&list=" + list,
                    success: function () {
                        task.val('');
                        $('#list-row').load(' #list-row > *');
                    }
                });
                break;
        }
    }

    function deleteTask(id) {
        $.ajax({
            url: "/tasks/delete?id=" + id,
            success: function() {
                $('#list-row').load(' #list-row > *');
            }
        })
    }


    function voteOnTask(id) {
        $.ajax({
            url: "/tasks/vote?id=" + id,
            success: function () {
                $('#list-row').load(' #list-row > *');
            }
        })
    }

    function unvoteTask(id) {
        $.ajax({
            url: "/tasks/unvote?id=" + id,
            success: function () {
                $('#list-row').load(' #list-row > *');
            }
        })
    }

    function setMoveTaskId(id) {
        $(".ul-list").attr('spid', id);
    }

    $('#list-row').hover(function() {
        var backlog, todo, inprogress, complete;

        backlog = document.getElementById("backlog-list");
        todo = document.getElementById("todo-list");
        inprogress = document.getElementById("inprogress-list");
        complete = document.getElementById("complete-list");

        var sortable = Sortable.create(backlog, {
            group: "lists",
            animation: 300,
            onEnd: function (evt) {
                var id, from, to, pos;

                id = $('.ul-list').attr('spid');
                from = evt.from.id;
                to = evt.to.id;
                pos = evt.newIndex;

                if (from === to) {
                    movePosition(id, pos, to);
                } else {
                    moveTask(id, pos, to);
                }
            }
        });
        var sortable1 = Sortable.create(todo, {
            group: "lists",
            animation: 300,
            onEnd: function (evt) {
                var id, from, to, pos;

                id = $('.ul-list').attr('spid');
                from = evt.from.id;
                to = evt.to.id;
                pos = evt.newIndex;

                if (from === to) {
                    movePosition(id, pos, to);
                }
                else {
                    moveTask(id, pos, to);
                }
            }
        });
        var sortable2 = Sortable.create(inprogress, {
            group: "lists",
            animation: 300,
            onEnd: function (evt) {
                var id, from, to, pos;

                id = $('.ul-list').attr('spid');
                from = evt.from.id;
                to = evt.to.id;
                pos = evt.newIndex;

                if (from === to) {
                    movePosition(id, pos, to);
                }
                else {
                    moveTask(id, pos, to);
                }
            }
        });
        var sortable3 = Sortable.create(complete, {
            group: "lists",
            animation: 300,
            onEnd: function (evt) {
                var id, from, to, pos;

                id = $('.ul-list').attr('spid');
                from = evt.from.id;
                to = evt.to.id;
                pos = evt.newIndex;

                if (from === to) {
                    movePosition(id, pos, to);
                }
            }
        });
    });

    function movePosition(id, pos, list) {
        $.ajax({
            url: "/tasks/position?id=" + id + "&position=" + pos + "&list=" + list,
            success: function () {
                $('#list-row').load(' #list-row > *');
            }
        })
    }

    function moveTask(id, pos, list) {
        $.ajax({
            url: "/tasks/move?id=" + id + "&position=" + pos + "&list=" + list,
            success: function() {
                $('#list-row').load(' #list-row > *');
            }
        })
    }
</script>
</html>
