<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>${board.name} - Sprint</title>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">
    <link type="text/css" href="../../../resources/style/tasks.css" rel="stylesheet">

    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">

    <script
            src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
            crossorigin="anonymous">
    </script>
    <script
            src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30="
            crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous">

    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous">
    </script>

<%--    Sortable JS--%>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.10.1/Sortable.min.js"
            integrity="sha256-9D6DlNlpDfh0C8buQ6NXxrOdLo/wqFUwEB1s70obwfE="
            crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"
            integrity="sha256-R4pqcOYV8lt7snxMQO/HSbVCFRPMdrhAFMH+vr9giYI="
            crossorigin="anonymous">
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css"/>
</head>
<body>
<div class="page-wrapper chiller-theme">
    <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content">
            <div class="sidebar-brand">
                <a href="#">Sprint</a>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li class="header-menu">
                        <span>Board</span>
                    </li>
                    <li>
                        <a href="#" onclick="tasks()">
                            <i class="fa fa-tasks"></i>
                            <span>Tasks</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" onclick="polls()">
                            <i class="fa fa-chart-bar"></i>
                            <span>Polls</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" onclick="documents()">
                            <i class="fa fa-book"></i>
                            <span>Documents</span>
                        </a>
                    </li>
                    <li class="header-menu">
                        <span>Social</span>
                    </li>
                    <li>
                        <a href="#" onclick="$('#new-comment').val('')" data-toggle="modal" data-target="#activity-modal">
                            <i class="fa fa-comment"></i>
                            <span>Activity</span>
                        </a>
                    </li>
                    <li>
                        <a href="#" data-toggle="modal" data-target="#users-modal">
                            <i class="fa fa-users"></i>
                            <span>Users</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <main class="page-content">
        <nav id="navbar" class="navbar navbar-expand-sm bg-dark navbar-dark">
            <!-- Sidebar -->
            <a style="padding-top: 25px;" id="logo" class="navbar-brand" href="${pageContext.request.contextPath}/boards"><img src="<c:url value="/resources/images/logo.svg"/>" style="width: 120px; height: 60px;" alt="logo"/></a>
            <!-- Links -->
            <ul class="navbar-nav">
                <!-- Home -->
                <li class="nav-item">
                    <a id="show-sidebar" class="nav-link" href="#" onclick="toggleSidebar()"><i class="material-icons">menu</i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/boards"><i class="material-icons">home</i></a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link" href="#" id="navbardrop" data-toggle="dropdown">
                        <i class="material-icons">apps</i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-header">Boards</a>
                        <div class="dropdown-divider"></div>
                        <c:forEach items="${boards}" var="board">
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/tasks?id=${board.id}">${board.name}</a>
                        </c:forEach>
                    </div>
                </li>
            </ul>

            <!-- Right Bar -->
            <ul class="navbar-nav ml-auto">
                <li id="notifications-dropdown" class="nav-item dropdown">
                    <a class="nav-link" href="#" id="notifications" data-toggle="dropdown">
                        <i class="material-icons">notifications</i>
                        <c:if test="${notificationsLength > 0}">
                            <span class="badge badge-pill badge-danger notification">
                                    ${notificationsLength}
                            </span>
                        </c:if>
                    </a>
                    <div style="width: 500px !important;" class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-header">Notifications</a>
                        <c:forEach items="${notifications}" var="notification">
                            <c:if test="${notification.seen == false}">
                                <div class="dropdown-divider"></div>
                                <a data-toggle="modal" data-target="#notification-modal" onmouseover="refreshNotification(${notification.id})" class="dropdown-item">${notification.description}</a>
                            </c:if>
                        </c:forEach>
                        <div class="dropdown-divider"></div>
                        <a data-toggle="modal" data-target="#notification-modal" class="dropdown-item">View all notifications</a>
                    </div>
                </li>
                <!-- User -->
                <li class="nav-item dropdown">
                    <a class="nav-link" id="navbardrop" data-toggle="dropdown">
                        <i class="material-icons">account_circle</i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-header">Account</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/account">Edit Details</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/account">Settings</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">Logout</a>
                    </div>
                </li>
            </ul>
        </nav>


        <div id="content-container" class="container-fluid">

            <div id="list-row" class="row">

                <div style="height: 900px"  class="col-lg-3">
                    <div class="lists" id="backlog-list-wrapper">
                        <span class="list-header">Backlog</span>
                        <div class="sortable-list">
                            <ul id="backlog-list" class="ul-list">
                                <c:forEach items="${board.backlog}" var="backlog">
                                    <li>
                                        <c:choose>
                                            <c:when test="${boardRole.role == 'Product Owner'}">
                                                <div class="card list-card" onmousedown="getTaskId('${backlog.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${backlog.id}')">
                                                        <p class="card-text">${backlog.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${backlog.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
<%--                                                        <i class="material-icons task-icons" onclick="getDependencies('${backlog.id}', 'Backlog')" data-toggle="modal" data-target="#dependencies-modal">timeline</i>--%>
                                                        <i class="material-icons task-icons" onclick="deleteTask('${backlog.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                                <div class="card list-card" onmousedown="getTaskId('${backlog.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${backlog.id}')">
                                                        <p class="card-text">${backlog.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${backlog.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${backlog.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                            <div class="card list-card" onmousedown="getTaskId('${backlog.id}')">
                                                <div class="card-body" onclick="taskOverlayViewOnly('${backlog.id}')">
                                                    <p class="card-text">${backlog.name}</p>
                                                    <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                        <div class="progress-bar" role="progressbar" style="width: ${backlog.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                    </div>
                                                </div>
                                            </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${boardRole.role == 'Product Owner'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-backlog-task" type="text" onfocusout="addToBacklog()">
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-backlog-task" type="text" onfocusout="addToBacklog()">
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>

                <div style="height: 900px" class="col-lg-3">
                    <div class="lists" id="todo-list-wrapper">
                        <span class="list-header">TODO</span>
                        <div id="todo-list-container" class="sortable-list">
                            <ul id="todo-list" class="ul-list">
                                <c:forEach items="${board.todo}" var="todo">
                                    <li>
                                        <c:choose>
                                            <c:when test="${boardRole.role == 'Product Owner'}">
                                                <div class="card list-card" onmousedown="getTaskId('${todo.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${todo.id}')">
                                                        <p class="card-text">${todo.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${todo.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${todo.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                                <div class="card list-card" onmousedown="getTaskId('${todo.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${todo.id}')">
                                                        <p class="card-text">${todo.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${todo.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${todo.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="card list-card" onmousedown="getTaskId('${todo.id}')">
                                                    <div class="card-body" onclick="taskOverlayViewOnly('${todo.id}')">
                                                        <p class="card-text">${todo.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${todo.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${boardRole.role == 'Product Owner'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-todo-task" type="text" onfocusout="addToTodo()">
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-todo-task" type="text" onfocusout="addToTodo()">
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>

                <div style="height: 900px" class="col-lg-3">
                    <div class="lists" id="inprogress-list-wrapper">
                        <span class="list-header">In Progress</span>
                        <div class="sortable-list">
                            <ul id="inprogress-list" class="ul-list">
                                <c:forEach items="${board.inprogress}" var="inprogress">
                                    <li>
                                        <c:choose>
                                            <c:when test="${boardRole.role == 'Product Owner'}">
                                                <div class="card list-card" onmousedown="getTaskId('${inprogress.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${inprogress.id}')">
                                                        <p class="card-text">${inprogress.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${inprogress.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${inprogress.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                                <div class="card list-card" onmousedown="getTaskId('${inprogress.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${inprogress.id}')">
                                                        <p class="card-text">${inprogress.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${inprogress.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${inprogress.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="card list-card" onmousedown="getTaskId('${inprogress.id}')">
                                                    <div class="card-body" onclick="taskOverlayViewOnly('${inprogress.id}')">
                                                        <p class="card-text">${inprogress.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${inprogress.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${boardRole.role == 'Product Owner'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-inprogress-task" type="text" onfocusout="addToInprogress()">
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-inprogress-task" type="text" onfocusout="addToInprogress()">
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>

                <div style="height: 900px"  class="col-lg-3">
                    <div class="lists" id="complete-list-wrapper">
                        <span class="list-header">Complete</span>
                        <div class="sortable-list">
                            <ul id="complete-list" class="ul-list">
                                <c:forEach items="${board.complete}" var="complete">
                                    <li>
                                        <c:choose>
                                            <c:when test="${boardRole.role == 'Product Owner'}">
                                                <div class="card list-card" onmousedown="getTaskId('${complete.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${complete.id}')">
                                                        <p class="card-text">${complete.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${complete.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${complete.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                                <div class="card list-card" onmousedown="getTaskId('${complete.id}')">
                                                    <div class="card-body" onclick="taskOverlayOn('${complete.id}')">
                                                        <p class="card-text">${complete.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${complete.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <div class="card-footer">
                                                        <i class="material-icons task-icons" onclick="deleteTask('${complete.id}')">delete_outline</i>
                                                    </div>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="card list-card" onmousedown="getTaskId('${complete.id}')">
                                                    <div class="card-body" onclick="taskOverlayViewOnly('${complete.id}')">
                                                        <p class="card-text">${complete.name}</p>
                                                        <div class="progress md-progress" style="height: 20px; margin-top: 1rem">
                                                            <div class="progress-bar" role="progressbar" style="width: ${complete.progress}%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <c:choose>
                            <c:when test="${boardRole.role == 'Product Owner'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-complete-task" type="text" onfocusout="addToComplete()">
                                    </div>
                                </div>
                            </c:when>
                            <c:when test="${boardRole.role == 'Scrum Master'}">
                                <div class="card list-card">
                                    <div style="text-align: center;" class="card-body">
                                        <input class="new-card-box" placeholder="Enter new task" id="new-complete-task" type="text" onfocusout="addToComplete()">
                                    </div>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>

        <%--            Task Overlay--%>
        <div id="task-overlay">
            <div id="task-overlay-container" class="friend-overlay">
                <div style="align-content: center" class="friend-overlay-contents">
                    <div style="text-align: right; margin-bottom: 10px;">
                        <i class="material-icons" onclick="taskOverlayOff()">close</i>
                    </div>
                    <div class="tab-content" id="task-overlay-tab-content">
                        <div class="tab-pane fade show active" id="task-details" role="tabpanel" aria-labelledby="task-details-tab">
                            <div class="friends-overlay-list-container">
                                <div id="card-overlay-taskid" style="display: none;"></div>
                                <form style="padding-top: 0 !important;" class="text-center p-5">
                                    <label for="task-overlay-name">Name</label>
                                    <input onfocusout="saveTask()" style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="task-overlay-name" class="form-control mb-4" name="name">
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="task-overlay-description">Description</label>
                                        <textarea onfocusout="saveTask()" style="resize: none" class="form-control rounded-0" id="task-overlay-description" rows="3" placeholder="Enter a description..." name="description"></textarea>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="task-overlay-dod" onclick="saveTask()">
                                        <label class="custom-control-label" for="task-overlay-dod">Definition of Done</label>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="task-overlay-complete" onclick="saveTask()">
                                        <label class="custom-control-label" for="task-overlay-complete">Complete</label>
                                    </div>
                                    <div class="progress md-progress" style="height: 20px; margin-top: 1rem; margin-bottom: 1rem;">
                                        <div id="task-progress-bar" class="progress-bar" role="progressbar" style="width: 25%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
                                    </div>
                                    <div style="margin-bottom: 1rem" class="input-append date form_datetime">
                                        <input id="due-date" style="width: 70%; margin-left: 15%" class="form-control" name="date" placeholder="Enter due date" type="text" onchange="setTaskDueDate()"/>
                                    </div>
                                    <label for="task-new-comment">Activity</label>
                                    <textarea style="resize: none; text-align: left; height: 38px;" class="form-control rounded-0" id="task-new-comment" rows="1" placeholder="Add a comment..." name="comment"></textarea>
                                    <button style="background-color: #31353D !important; border-color: #31353D !important; margin: 1rem;" type="button" class="btn btn-primary" onclick="commentOnTask()">Comment</button>
                                    <div style="padding: 0" class="modal-body">
                                        <div class="actionBox">
                                            <ul id="task-comment-list" class="commentList">
                                                <%--                                                COMMENTS APPENDED HERE--%>
                                            </ul>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--        Task Overlay View Only--%>
        <div id="task-overlay-view-only">
            <div id="task-overlay-view-only-container" class="friend-overlay">
                <div style="align-content: center" class="friend-overlay-contents">
                    <div style="text-align: right; margin-bottom: 10px;">
                        <i class="material-icons" onclick="taskOverlayViewOnlyOff()">close</i>
                    </div>
                    <div class="tab-content" id="task-overlay-vo-tab-content">
                        <div class="tab-pane fade show active" id="task-vo-details" role="tabpanel" aria-labelledby="task-vo-details-tab">
                            <div class="friends-overlay-list-container">
                                <div id="card-overlay-vo-taskid" style="display: none;"></div>
                                <form style="padding-top: 0 !important;" class="text-center p-5">
                                    <label for="task-overlay-vo-name">Name</label>
                                    <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="task-overlay-vo-name" class="form-control mb-4" name="name" readonly>
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="task-overlay-vo-description">Description</label>
                                        <textarea style="resize: none" class="form-control rounded-0" id="task-overlay-vo-description" rows="3" placeholder="Enter a description..." name="description" readonly></textarea>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="task-overlay-vo-dod" onclick="return false;">
                                        <label class="custom-control-label" for="task-overlay-vo-dod">Definition of Done</label>
                                    </div>
                                    <div class="custom-control custom-checkbox">
                                        <input type="checkbox" class="custom-control-input" id="task-overlay-vo-complete" onclick="return false;">
                                        <label class="custom-control-label" for="task-overlay-vo-complete">Complete</label>
                                    </div>
                                    <div class="progress md-progress" style="height: 20px; margin-top: 1rem; margin-bottom: 1rem;">
                                        <div id="task-progress-vo-bar" class="progress-bar" role="progressbar" style="width: 25%; height: 20px;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
                                    </div>
                                    <div style="margin-bottom: 1rem" class="input-append date form_datetime">
                                        <input id="due-date-vo" style="width: 70%; margin-left: 15%" class="form-control" name="date" placeholder="Enter due date" type="text" readonly/>
                                    </div>
                                    <label for="task-vo-new-comment">Activity</label>
                                    <textarea style="resize: none; text-align: left; height: 38px;" class="form-control rounded-0" id="task-vo-new-comment" rows="1" placeholder="Add a comment..." name="comment"></textarea>
                                    <button style="background-color: #31353D !important; border-color: #31353D !important; margin: 1rem;" type="button" class="btn btn-primary" onclick="commentOnTaskViewOnly()">Comment</button>
                                    <div style="padding: 0" class="modal-body">
                                        <div class="actionBox">
                                            <ul id="task-vo-comment-list" class="commentList">
                                                <%--                                                COMMENTS APPENDED HERE--%>
                                            </ul>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--Polls--%>
        <div style="display:none;" id="poll-row"  class="container-fluid">
            <div class="row">
                <div style="height: 900px"  class="col-lg-6">
                    <div class="lists" id="polls-list-wrapper">
                        <div class="friends-overlay-list-container">
                            <div style="margin-bottom: 0; padding-bottom: 0" class="jumbotron jumbotron-fluid">
                                <div class="container">
                                    <h1 class="display-4">View Polls</h1>
                                </div>
                            </div>
                            <ul style="margin-top: 3rem" id="poll-list" class="ul-list">
                                <c:forEach items="${board.polls}" var="poll">
                                    <div style="width: 50%; margin-left: 25%" class="card list-card">
                                        <c:choose>
                                            <c:when test="${poll.voters.contains(user)}">
                                                <div class="card-body" onclick="getResults('${poll.id}')">
                                                    <p class="card-text">${poll.question}</p>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="card-body" onclick="getPoll('${poll.id}')" data-toggle="modal" data-target="#poll-modal">
                                                    <p class="card-text">${poll.question}</p>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                        <c:if test="${poll.creator == user}">
                                            <div class="card-footer">
                                                <i class="material-icons task-icons" onclick="getResults('${poll.id}')">bar_chart</i>
                                                <i class="material-icons task-icons" onclick="deletePoll('${poll.id}')">delete_outline</i>
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
                <div style="height: 900px"  class="col-lg-6">
                    <div class="lists" id="create-polls-wrapper">
                        <div class="friends-overlay-list-container">
                            <div style="margin-bottom: 0; padding-bottom: 0" class="jumbotron jumbotron-fluid">
                                <div class="container">
                                    <h1 class="display-4">Create a Poll</h1>
                                </div>
                            </div>
                            <form id="account-form" class="text-center p-5">
                                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="create-poll-question" class="form-control mb-4" placeholder="Enter your question">
                                <select  id="create-poll-select" style="margin-top: .5rem; margin-bottom: 2rem" class="browser-default custom-select">
                                    <option selected>Choose from lists</option>
                                    <option value="Backlog">Backlog</option>
                                    <option value="TODO">TODO</option>
                                    <option value="In Progress">In Progress</option>
                                </select>

<%--                                <div style="padding: 0" class="jumbotron jumbotron-fluid">--%>
<%--                                    <div class="container">--%>
<%--                                        <p class="lead">Or</p>--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <input style="margin-bottom: 14px !important; margin-top: 8px;" type="text" id="create-poll-o" class="form-control mb-4" placeholder="Enter poll option">--%>
<%--                                <input style="margin-bottom: 14px !important; margin-top: 8px;" type="text" id="create-poll-o1" class="form-control mb-4" placeholder="Enter poll option">--%>

                                <button style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="createPoll()">Create</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--        Vote Modal--%>
        <div class="modal fade" id="poll-modal" tabindex="-1" role="dialog" aria-labelledby="poll-modal" aria-hidden="true" data-backdrop="true">
            <span style="display: none" id="poll-id"></span>
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 id="poll-question" style="text-align: center; word-wrap: break-word; width: 95% !important;" class="modal-title w-100">Results</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div style="padding: 0; min-height: 400px;" class="modal-body">
                        <div class="actionBox">
                            <ul id="choices-list" class="ul-list">
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-center">
                    <span id="poll-view-results" class="date sub-text" onclick="results()" data-toggle="modal" data-target="results-modal">
                        View Results
                    </span>
                    </div>
                </div>
            </div>
        </div>

<%--        Results Modal--%>
        <div class="modal fade" id="results-modal" tabindex="-1" role="dialog" aria-labelledby="results-modal" aria-hidden="true" data-backdrop="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 id="results-question" style="text-align: center; word-wrap: break-word; width: 95% !important;" class="modal-title w-100">Poll</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div id="chart-container" class="actionBox">
<%--                            CHART HERE--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--        Documents--%>
        <div style="display:none;" id="document-row"  class="container-fluid">
            <div class="row">
                <div style="height: 900px"  class="col-lg-12">
                    <div class="lists" id="document-list-wrapper">
                        <div class="friends-overlay-list-container">
                            <div style="margin-bottom: 0; padding-bottom: 0" class="jumbotron jumbotron-fluid">
                                <div class="container">
                                    <h1 class="display-4">Documents</h1>
                                    <p class="lead">Coming soon.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--        Activity--%>
        <div class="modal fade" id="activity-modal" tabindex="-1" role="dialog" aria-labelledby="activity-modal" aria-hidden="true" data-backdrop="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 style="text-align: center" class="modal-title w-100">Activity</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div style="padding: 0" class="modal-body">
                        <div class="actionBox">
                            <ul id="comment-list" class="commentList">
                                <c:forEach items="${board.comments}" var="comment">
                                    <li>
                                        <div class="commenterImage">
                                            <i class="material-icons">account_circle</i>
                                        </div>
                                        <div class="commentText">
                                            <p style="word-break: break-word" class="">${comment.description}</p>
                                            <span class="date sub-text">
                                            <p>${comment.username}</p>
                                                ${comment.formattedDate}
                                            </span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <textarea style="resize: none; text-align: left; height: 38px;" class="form-control rounded-0" id="new-comment" rows="1" placeholder="Add a comment..." name="comment"></textarea>
                        <button style="background-color: #31353D !important; border-color: #31353D !important;" type="button" class="btn btn-primary" onclick="commentOnBoard()">Comment</button>
                    </div>
                </div>
            </div>
        </div>

<%--        Users--%>
        <div class="modal fade bd-example-modal-lg" id="users-modal" tabindex="-1" role="dialog" aria-labelledby="users-modal"
             aria-hidden="true" data-backdrop="true">
            <div class="modal-dialog modal-lg" role="document">
                <div style="max-height: 600px; min-height: 600px;" class="modal-content">
                    <input id="board-modal-id" style="display: none" value="${board.id}">
                    <div class="modal-header">
                        <h4 style="text-align: center" class="modal-title w-100">Users</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div style="padding: 0" class="modal-body">
                        <form style="padding-top: 1rem" class="form-inline d-flex justify-content-center md-form form-sm">
                            <input id="board-modal-search-bar" class="form-control form-control-sm mr-3 w-75" type="text" placeholder="Search user email" aria-label="Search">
                            <i class="fas fa-search" aria-hidden="true" onclick="searchUserTask()"></i>
                        </form>
                        <ul style="min-height: 46.6px" id="board-modal-search-list" class="list-group list-group-flush friends-overlay-list">
                            <%--Results of search are appended here--%>
                        </ul>
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col">Username</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Role</th>
                                <th scope="col">Remove</th>
                            </tr>
                            </thead>
                            <tbody id="board-page-table">
                            <c:forEach items="${boardRoles}" var="boardRole">
                                <tr>
                                    <th scope="row" >${boardRole.user.username} <i id="user-name-label" onclick="commentWithUsername('${boardRole.user.username}')" class="material-icons">message</i> </th>
                                    <td>${boardRole.user.fullname}</td>
                                    <td>${boardRole.user.email}</td>
                                    <td>
                                        <select class="custom-select custom-select-sm">
                                            <option selected>${boardRole.role}</option>
                                            <option value="1">Test</option>
                                        </select>
                                    </td>
                                    <c:if test="${board.owner != boardRole.user}">
                                        <td><i style="padding-left: 25%" class="material-icons" onclick="removeUserTask('${boardRole.user.email}')">delete_outline</i></td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

<%--        Notifications--%>
        <div class="modal fade" id="notification-modal" tabindex="-1" role="dialog" aria-labelledby="notification-modal" aria-hidden="true" data-backdrop="true">
            <div class="modal-dialog" role="document">
                <div style="min-height: 600px" class="modal-content">
                    <div class="modal-header">
                        <h4 style="text-align: center" class="modal-title w-100">Notifications</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div style="padding: 0" class="modal-body">
                        <div class="actionBox">
                            <ul id="notification-list" class="commentList">
                                <c:forEach items="${notifications}" var="notification">
                                    <li style="display:flex;">
                                        <div class="commentText">
                                            <p style="word-break: break-word; font-size: 18px;" class="">${notification.description}</p>
                                            <c:if test="${notification.pending == true}">
                                                <a class="notification-link" onclick="acceptInvitation('${notification.id}')">Accept</a> - <a class="notification-link" onclick="declineInvitation('${notification.id}')">Decline</a>
                                            </c:if>
                                            <span class="date sub-text">
                                        <p>${notification.formattedDate}</p>
                                    </span>
                                        </div>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <div style="text-align: center; display: block" class="modal-footer">
                <span id="clear-notifications" class="date sub-text">
                 Clear all notifications
                </span>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <!-- page-content" -->
</div>
<!-- page-wrapper -->

</body>
<script src="<c:url value="/resources/scripts/main.js"/>"></script>
<script src="<c:url value="/resources/scripts/tasks.js"/>"></script>
<%--</script>--%>
</html>