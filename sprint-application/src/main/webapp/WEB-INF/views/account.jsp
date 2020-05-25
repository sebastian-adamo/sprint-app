<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Account - Sprinting</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">
    <link type="text/css" href="../../../resources/style/account.css" rel="stylesheet">

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
    <script src="<c:url value="/resources/scripts/account.js"/>"></script>
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
                        <a href="${pageContext.request.contextPath}/account">
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
            <div class="row">
                <div style="height: 900px"  class="col-lg-12">
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
                                    <div id="account-image-wrapper" class="text-center">
                                        <c:choose>
                                            <c:when test="${user.profileImage}">
                                            <div class="container">
                                                <img id="account-image" src="<c:url value="/resources/images/123.jpg"/>" class="account-image" alt="image" onclick="$('#account-image-input').trigger('click')"/>
                                                <input id="account-image-input" type="file" style="display: none" onchange="setProfileImage()">
                                            </div>
                                            </c:when>
                                            <c:otherwise>
                                                <i id="account-image" style="font-size: 100px;" class="material-icons" onclick="$('#account-image-input').trigger('click')">account_circle</i>
                                                <input id="account-image-input" type="file" style="display: none" onchange="setProfileImage()">
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
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
                                    <button style="background: #31353D; border-color: #31353D;" class="btn btn-info btn-block" type="button" onclick="saveDetails()">Save</button>
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
        </div>
    </main>
</div>
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
<script>
    $(document).ready(function () {
        $("#account-image").click(function () {
            $("#account-image-input").trigger('click');
        });
        $('#account-image-input').change(function () {
            var value = this.value;
            var fileName = typeof value == 'string' ? value.match(/[^\/\\]+$/)[0] : value[0]
            alert(fileName);
        }, false);
    });

    // Convert image file to javascript byte[], then upload
    // to MySql via ajax method to store as java byte[] in user
    // object. Find a way to retrieve byte[] from ajax again
    // and display as image file.
</script>
</html>
