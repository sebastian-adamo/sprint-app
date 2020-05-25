<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Import - Sprint</title>

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
    <script src="<c:url value="/resources/scripts/import.js"/>"></script>
</head>
<body>
<div class="page-wrapper chiller-theme">
    <%--    Sidebar Wrapper--%>
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
                    <li>
                        <a href="${pageContext.request.contextPath}/import">
                            <i class="fa fa-file-excel"></i>
                            <span>Import</span>
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
                    <div class="dropdown-menu dropdown-menu-left">
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
                    <a class="nav-link" href="#" id="navbardrop" data-toggle="dropdown">
                        <i class="material-icons">notifications</i>
                        <c:if test="${fn:length(unseenNotifications) > 0}">
                            <span class="badge badge-pill badge-danger notification">
                                    ${fn:length(unseenNotifications)}
                            </span>
                        </c:if>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a class="dropdown-header">Notifications</a>
                        <c:if test="${fn:length(unseenNotifications) > 0}">
                            <c:forEach items="${unseenNotifications}" var="unseen">
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#">${unseen.description}</a>
                            </c:forEach>
                        </c:if>
                        <c:forEach items="${seenNotifications}" var="seen">
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">${seen.description}</a>
                        </c:forEach>
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
            <div class="row">
                <div style="height: 900px"  class="col-lg-12">
                    <div class="friends-overlay-list-container">
                        <div style="margin-bottom: 0; padding-bottom: 0" class="jumbotron jumbotron-fluid">
                            <div class="container">
                                <h1 class="display-4">Import Data</h1>
                                <p class="lead">Coming soon.</p>
                            </div>
                        </div>
                        <form class="text-center p-5">
                            <label for="board-name">Board Name</label>
                            <input style=" margin-bottom: 10px !important; margin-top: 8px; width: 350px;" type="text" id="board-name" class="form-control mb-4" placeholder="Enter board name...">
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-description">Board Description</label>
                                <textarea class="form-control rounded-0" id="board-description" rows="3" placeholder="Enter board description..."></textarea>
                            </div>
                            <div style="margin-top: 8px;" class="form-group">
                                <label for="board-dod">Board Definition of Done</label>
                                <textarea class="form-control rounded-0" id="board-dod" rows="5" placeholder="Enter board definition of done..."></textarea>
                            </div>

                            <div style="margin-bottom: 2rem" class="input-group">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" id="inputGroupFile01"
                                           aria-describedby="inputGroupFileAddon01">
                                    <label class="custom-file-label" for="inputGroupFile01">Choose Excel File</label>
                                </div>
                            </div>

                            <button style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="importBoard()">Create</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </main>
</div>
</body>
</html>
