<%--
  Created by IntelliJ IDEA.
  User: Sebastian Adamo
  Date: 5/24/2020
  Time: 1:01 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - Sprint</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">

    <script
            src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
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
</head>
<body>
<div class="container">

    <div class="login-container">
        <div style="text-align: center; padding-top: 20px" class="col-lg-12">
            <div style="padding-top: 20px; max-height: 60px" class="banner">
                <a style="margin-left: 7.5%; "><img src="<c:url value="/resources/images/logo.svg"/>" alt="logo"/></a>
            </div>
            <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 0;" class="jumbotron jumbotron-fluid">
                <div class="container">
                    <h1 class="display-4">Register</h1>
                        <p style="display: none; color: red" id="register-error" class="lead">Username or Email already in use by another account.</p>
                    <p class="lead">Email:</p>
                </div>
            </div>
            <form action="${pageContext.request.contextPath}/register/submit" method="post">
                <div class="form-group" style="margin-bottom: 11px">
                    <input id="email" class="form-control" type="email" name="email" placeholder="Enter email address" value="${email}" required>
                </div>
                <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 0;" class="jumbotron jumbotron-fluid">
                    <div class="container">
                        <p class="lead">Username:</p>
                    </div>
                </div>
                <div class="form-group">
                    <input class="form-control" type="text" name="username" placeholder="Enter username" required>
                </div>
                <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 0;" class="jumbotron jumbotron-fluid">
                    <div class="container">
                        <p class="lead">Password:</p>
                    </div>
                </div>
                <div class="form-group">
                    <input class="form-control" type="password" name="password" placeholder="Enter password" required>
                </div>
                <button id="login-button" type="submit" name="submit" class="btn btn-primary">Register</button>

                <div class="register-account">
                    <a href="${pageContext.request.contextPath}/login"><p>Already have an account? Log in</p></a>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
<script>
    $("#email").focusout(function () { //can be .keyup or .change, whichever you feels best. keydown / keyup can spam the ajax method sometimes
       var email =  $("#email").val();
       $.ajax({
           type: "GET",
           url: "/register/user-error?email=" + email,
           success: function (result) {
               if (result === "exists") {
                   $("#register-error").show();
               } else {
                   $("#register-error").hide();
               }
           }
       })
    });
</script>
</html>