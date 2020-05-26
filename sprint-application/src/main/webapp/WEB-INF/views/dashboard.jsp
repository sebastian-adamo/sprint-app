<%--
  Created by IntelliJ IDEA.
  User: Sebastian Adamo
  Date: 5/24/2020
  Time: 1:01 PM
  To change this template use File | Settings | File Templates.
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
    <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.min.js"></script>
    <script src="https://unpkg.com/tippy.js@6/dist/tippy-bundle.umd.js"></script>

    <!-- jQuery Modal -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />

    <script src="<c:url value="/resources/scripts/main.js"/>"></script>
    <script src="<c:url value="/resources/scripts/account.js"/>"></script>
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
                        <a href="#">
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
            <div class="sidebar-menu">
                <ul>
                    <li class="header-menu">
                        <span>RECENT BOARDS</span>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <%--    Main Wrapper--%>
    <main class="page-content">
        <%--        Navbar--%>
        <nav id="navbar" class="navbar navbar-expand-sm bg-dark navbar-dark">
            <a style="padding-top: 25px;" id="logo" class="navbar-brand" href="${pageContext.request.contextPath}/dashboard"><img src="<c:url value="/resources/images/logo.svg"/>" style="width: 120px; height: 60px;" alt="logo"/></a>
            <!-- Links -->
            <ul class="navbar-nav">
                <!-- Home -->
                <li class="nav-item">
                    <a id="show-sidebar" class="nav-link" onclick="toggleSidebar()"><i class="material-icons">menu</i></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard"><i class="material-icons">home</i></a>
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
                                <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="${pageContext.request.contextPath}/teams">
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
                        <c:forEach items="${user.boardRoles}" var="boardRole">
                            <div class="module">
                                <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                    <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" href="${pageContext.request.contextPath}/tasks?id=${boardRole.board.id}">
                                        <div style="height: 75%; text-align: center; padding-top: 30%" class="card-body">
                                            <p class="card-text">${boardRole.board.name}</p>
                                        </div>
                                    </a>
                                    <div class="card-footer">
                                        <a class="material-icons" style="text-decoration: none; color: black" href="#edit-my-board-modal" rel="modal:open" onclick="getMyBoard('${boardRole.board.id}')"><i class="material-icons">create</i></a>
                                        <i class="material-icons" onclick="deleteMyBoard('${boardRole.board.id}')">delete_outline</i>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div style="width: 70%; height: 80%" id="edit-my-board-modal" class="modal">
                            <form style="padding-top: 1rem !important;" id="edit-board-form" class="text-center p-5">
                                <label for="edit-my-board-name">Name</label>
                                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="edit-my-board-name" class="form-control mb-4" placeholder="Enter a name...">
                                <div style="margin-top: 8px;" class="form-group">
                                    <label for="edit-my-board-description">Description</label>
                                    <textarea class="form-control rounded-0" id="edit-my-board-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                                </div>
                                <div style="margin-top: 8px;" class="form-group">
                                    <label for="edit-my-board-dod">Definition of Done</label>
                                    <textarea class="form-control rounded-0" id="edit-my-board-dod" rows="3" name="dod" placeholder="Enter a definition of done..."></textarea>
                                </div>
                                <button id="save-my-board" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="saveMyBoard()">Save</button>
                            </form>
                        </div>

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
                        <div style="width: 70%; height: 80%" id="my-board-modal" class="modal">
                            <input id="my-board-id" style="display: none">
                            <form style="padding-top: 1rem !important;" id="create-board-form" class="text-center p-5">
                                <label for="my-board-name">Name</label>
                                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="my-board-name" class="form-control mb-4" placeholder="Enter a name..." required>
                                <div style="margin-top: 8px;" class="form-group">
                                    <label for="my-board-description">Description</label>
                                    <textarea class="form-control rounded-0" id="my-board-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                                </div>
                                <div style="margin-top: 8px;" class="form-group">
                                    <label for="my-board-dod">Definition of Done</label>
                                    <textarea class="form-control rounded-0" id="my-board-dod" rows="3" name="dod" placeholder="Enter a definition of done..."></textarea>
                                </div>
                                <button id="create-my-board" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="createMyBoard()">Create</button>
                            </form>
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
                        <c:forEach items="${user.teams}" var="team">
                            <div class="module">
                                <div style="width: 100%; height: 100%" class="card list-card boards-card">
                                    <a style="text-decoration: none; color: #0f0f0f; display: block; height: 100%" onclick="displayTeams()">
                                        <div style="height: 100%; text-align: center; padding-top: 30%" class="card-body">
                                            <p class="card-text"><i class="material-icons">group</i></p>
                                            <p class="card-text">${team.name}</p>
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
                        <div style="width: 70%; height: 80%" id="create-team-modal" class="modal">
                            <form style="padding-top: 1rem !important;" id="create-team-form" class="text-center p-5">
                                <label for="create-team-name">Name</label>
                                <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="create-team-name" class="form-control mb-4" placeholder="Enter a team name..." required>
                                <div style="margin-top: 8px;" class="form-group">
                                    <label for="create-team-description">Description</label>
                                    <textarea class="form-control rounded-0" id="create-team-description" rows="3" name="description" placeholder="Enter a description..."></textarea>
                                </div>
                                <button id="create-team" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="createTeam()">Create</button>
                            </form>
                        </div>
                        <!-- !Create Team -->

                    </div>
                </div>
            </div>
            <!-- !Teams -->

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
                            <div class="friends-overlay-list-container">
                                <form id="account-form" class="text-center p-5">
                                    <label for="account-username">Username</label>
                                    <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="account-username" class="form-control mb-4" value="${user.username}" readonly>
                                    <label for="account-email">Email</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px;" type="text" id="account-email" class="form-control mb-4" name="email" value="${user.email}" placeholder="Enter an email address..." readonly>
                                    <label for="account-fullname">Full Name</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px;" type="text" id="account-fullname" name="fullname" class="form-control mb-4" value="${user.fullname}" placeholder="Enter your full name...">
                                    <label for="account-company">Company</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px;" type="text" id="account-company" name="company" class="form-control mb-4" value="${user.company}" placeholder="Enter your company name...">
                                    <div style="margin-top: 8px;" class="form-group">
                                        <label for="account-bio">Bio</label>
                                        <textarea class="form-control rounded-0" id="account-bio" rows="3" name="bio" placeholder="Enter a bio...">${user.bio}</textarea>
                                    </div>
                                    <button id="save-account-details" style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="saveDetails()">Save</button>
                                </form>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="settings" role="tabpanel" aria-labelledby="settings-tab" >
                            <div class="friends-overlay-list-container">
                                <form class="text-center p-5">
                                    <label for="account-new-password">New Password</label>
                                    <input style="margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="password" id="account-new-password" class="form-control mb-4" placeholder="Enter new password...">
                                    <label for="account-confirm-password">Confirm Password</label>
                                    <input style="margin-bottom: 14px !important; margin-top: 8px;" type="password" id="account-confirm-password" class="form-control mb-4" placeholder="Confirm password...">
                                    <button style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="savePassword()">Save</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- !Settings -->

        </div>
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

    function createMyBoard() {
        var name, description, dod;

        name = $('#my-board-name').val();
        description = $('#my-board-description').val();
        dod = $('#my-board-dod').val();

        if (name !== '') {
            $.ajax({
                url: "/boards/addMyBoard?name=" + name + "&description=" + description + "&dod=" + dod,
                success: function(result) {
                    $('#my-board-modal').modal("hide ");
                    $('#content-container').load(' #my-boards-row > *');
                }
            })
        }
    }

    function deleteMyBoard(id) {
        $.ajax({
            url: "/boards/delete?id=" + id,
            success: function(result) {
                $('#content-container').load(' #my-boards-row > *');
            }
        })
    }

    function getMyBoard(id) {
        $.ajax({
            url: "/boards/getMyBoard?id=" + id,
            success: function(result) {
                $('#my-board-id').val(id);
                $('#edit-my-board-name').val(result.name);
                $('#edit-my-board-description').val(result.description);
                $('#edit-my-board-dod').val(result.dod);
            }
        })
    }

    function saveMyBoard() {
        let id, name, description, dod;

        id = $('#my-board-id').val();
        name = $('#edit-my-board-name').val();
        description = $('#edit-my-board-description').val();
        dod = $('#edit-my-board-dod').val();

        if (name !== '') {
            $.ajax({
                url: "/boards/save?id= " + id + "&name=" + name + "&description=" + description + "&dod=" + dod,
                success: function(result) {
                    $('#content-container').load(' #my-boards-row > *');
                }
            })
        }
    }
</script>
</html>
