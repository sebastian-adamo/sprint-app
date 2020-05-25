<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Boards - Sprint</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">

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
    <script src="<c:url value="/resources/scripts/main.js"/>"></script>
</head>
<body>
<div class="page-wrapper chiller-theme">
<%--    Sidebar --%>
    <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content">
            <div class="sidebar-brand">
                <a href="#">Sprint</a>
            </div>
            <div class="sidebar-menu">
                <ul>
                    <li class="header-menu">
                        <span>Other</span>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-calendar"></i>
                            <span>Calendar</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

<%--    Main Wrapper--%>
    <main class="page-content">
<%--        Navbar--%>
        <nav id="navbar" class="navbar navbar-expand-sm bg-dark navbar-dark">
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
                    <div id="navbar-boards" class="dropdown-menu dropdown-menu-left">
                        <a class="dropdown-header">Boards</a>
                        <c:forEach items="${boardRoles}" var="boardRole">
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="${pageContext.request.contextPath}/tasks?id=${boardRole.board.id}">${boardRole.board.name}</a>
                        </c:forEach>
                    </div>
                </li>
            </ul>

<%--            Right Side Navbar--%>
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

<%--        Main Content--%>
        <div id="content-container" class="container-fluid">

<%--            Boards--%>
            <div id="list-row" class="row">
                <div style="height: 900px" class="col-lg-12">
                    <div id="board-grid" class="grid">
                        <c:forEach items="${boardRoles}" var="boardRole">
                                <div class="module">
                                    <div class="card list-card boards-card">
                                        <a style="text-decoration: none; color: #0f0f0f; display: block" href="${pageContext.request.contextPath}/tasks?id=${boardRole.board.id}">
                                            <div class="card-body">
                                                <p class="card-text">${boardRole.board.name}</p>
                                            </div>
                                        </a>
                                        <div class="card-footer">
                                            <c:choose>
                                                <c:when test="${boardRole.board.owner == user}">
                                                    <i class="material-icons task-icons" onclick="boardOverlayOn('${boardRole.board.id}')">edit</i>
                                                    <i class="material-icons task-icons" onclick="deleteBoard(${boardRole.board.id})">delete_outline</i>
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="material-icons task-icons" onclick="boardOverlayViewOnly(${boardRole.board.id})">visibility</i>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                        </c:forEach>
                        <div class="module">
                            <div class="card list-card boards-card"  id="new-board">
                                <div style="text-align: center;" class="card-body">
                                    <input class="new-card-box" id="new-board-text" type="text" placeholder="Enter new board" onfocusout="addBoard()">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
         </div>
    </main>
</div>

<%--            Board Overlay--%>
<div id="board-overlay">
    <div id="board-overlay-container" class="friend-overlay">
        <div style="align-content: center; height: 95%;" class="friend-overlay-contents">
            <div style="text-align: right; margin-bottom: 10px;">
                <i class="material-icons" onclick="$('#board-overlay').hide()">close</i>
            </div>
            <ul class="nav nav-tabs nav-justified" id="task-overlay-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="board-details-tab" data-toggle="tab" href="#board-details" role="tab" aria-controls="home" aria-selected="true"><i class="material-icons">list</i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="users-tab" data-toggle="tab" href="#users" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">group</i></a>
                </li>
            </ul>
            <div class="tab-content" id="task-overlay-tab-content">
                <div class="tab-pane fade show active" id="board-details" role="tabpanel" aria-labelledby="board-details-tab">
                    <div class="friends-overlay-list-container">
                        <form style="padding-top: 1rem !important; margin-bottom: 0" class="text-center p-5">
                            <div id="board-overlay-id" style="display: none"></div>
                            <label for="board-overlay-name">Name</label>
                            <input onfocusout="saveBoard()" style=" margin-bottom: 10px !important; margin-top: 8px; width: 100%;" type="text" id="board-overlay-name" class="form-control mb-4" name="name">
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-overlay-description">Description</label>
                                <textarea onfocusout="saveBoard()" style="resize: none" class="form-control rounded-0" id="board-overlay-description" rows="3" placeholder="Enter a description..." name="description"></textarea>
                            </div>
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-overlay-dod">Definition of Done</label>
                                <textarea onfocusout="saveBoard()" style="width: 400px; resize: none" class="form-control rounded-0" id="board-overlay-dod" rows="7" placeholder="Enter the definition of done..."></textarea>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="tab-pane fade" id="users" role="tabpanel" aria-labelledby="users-tab" >
                    <div class="friends-overlay-list-container">
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
                            <tbody id="board-overlay-table">
                            </tbody>
                        </table>
                        <!-- Search form -->
                        <form class="form-inline d-flex justify-content-center md-form form-sm">
                            <input id="board-search-bar" class="form-control form-control-sm mr-3 w-75" type="text" placeholder="Search" aria-label="Search">
                            <i class="fas fa-search" aria-hidden="true" onclick="searchUser()"></i>
                        </form>
                        <ul id="board-overlay-search-list" class="list-group list-group-flush friends-overlay-list">
                            <%--Results of search are appended here--%>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--             Board Overlay View Only--%>
<div id="board-overlay-view-only">
    <div class="friend-overlay">
        <div style="align-content: center; height: 95%;" class="friend-overlay-contents">
            <div style="text-align: right; margin-bottom: 10px;">
                <i class="material-icons" onclick="$('#board-overlay-view-only').hide()">close</i>
            </div>
            <ul class="nav nav-tabs nav-justified" id="board-overlay-vo-tab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="board-details-vo-tab" data-toggle="tab" href="#board-details-vo" role="tab" aria-controls="home" aria-selected="true"><i class="material-icons">list</i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="users-vo-tab" data-toggle="tab" href="#users-vo" role="tab" aria-controls="profile" aria-selected="false"><i class="material-icons">group</i></a>
                </li>
            </ul>
            <div class="tab-content">
                <div class="tab-pane fade show active" id="board-details-vo" role="tabpanel" aria-labelledby="board-details-tab">
                    <div class="friends-overlay-list-container">
                        <form style="padding-top: 1rem !important; margin-bottom: 0" class="text-center p-5">
                            <div id="board-overlay-vo-id" style="display: none"></div>
                            <label for="board-overlay-vo-name">Name</label>
                            <input readonly style=" margin-bottom: 10px !important; margin-top: 8px; width: 100%;" type="text" id="board-overlay-vo-name" class="form-control mb-4" name="name">
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-overlay-vo-description">Description</label>
                                <textarea readonly style="resize: none" class="form-control rounded-0" id="board-overlay-vo-description" rows="3" placeholder="Enter a description..." name="description"></textarea>
                            </div>
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-overlay-vo-dod">Definition of Done</label>
                                <textarea readonly style="width: 400px; resize: none" class="form-control rounded-0" id="board-overlay-vo-dod" rows="7" placeholder="Enter the definition of done..."></textarea>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="tab-pane fade" id="users-vo" role="tabpanel" aria-labelledby="users-tab" >
                    <div class="friends-overlay-list-container">
                        <table class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col">Username</th>
                                <th scope="col">Name</th>
                                <th scope="col">Email</th>
                                <th scope="col">Role</th>
                            </tr>
                            </thead>
                            <tbody id="board-overlay-vo-table">
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%--          Notifications--%>
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
</body>
</html>