<%--
  Created by IntelliJ IDEA.
  User: Sebastian Adamo
  Date: 6/1/2020
  Time: 12:50 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login - Sprint</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link type="text/css" href="../../../resources/style/theme.css" rel="stylesheet">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
          crossorigin="anonymous">

    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
            integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
            crossorigin="anonymous">

    </script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
            integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
            crossorigin="anonymous">
    </script>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js"
            integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
            crossorigin="anonymous">
    </script>
</head>
<body>
<div class="container">
    <div style="height: 40%" class="login-container">
        <div style="text-align: center; padding-top: 20px" class="col-lg-12">
            <div style="padding-top: 20px; max-height: 60px" class="banner">
                <a style="margin-left: 7.5%; "><img src="<c:url value="/resources/images/logo.svg"/>" alt="logo"/></a>
            </div>
            <div id="recovery-container">
                <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 1rem;" class="jumbotron jumbotron-fluid">
                    <div class="container">
                        <p class="lead">We'll send a recovery email to this address:</p>
                        <p style="display: none; color: red" id="email-error" class="lead">Please enter a valid email address.</p>
                    </div>
                </div>
                <form>
                    <div class="form-group" style="margin-bottom: 11px">
                        <input class="form-control" type="email" name="email" placeholder="Enter email address" id="recovery-email" onchange="checkEmail()">
                    </div>
                    <button id="login-button" type="button" class="btn btn-primary" onclick="sendRecoveryEmail()">Send Recovery Link</button>
                </form>
            </div>
            <div style="display: none" id="email-sent">
                <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 1rem;" class="jumbotron jumbotron-fluid">
                    <div class="container">
                        <p class="lead">We've sent a recovery email to:</p>
                        <p id="result-address" class="lead"></p>
                    </div>
                </div>
            </div>
            <div class="register-account">
                <a href="${pageContext.request.contextPath}/login"><p>Back to Log in</p></a>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function checkEmail() {
        let email, error;
        email = $('#recovery-email').val();
        error = $('#email-error');

        if (email === "") {
            error.hide();
        }
        else {
            $.ajax({
                url: "/recovery/check-email?email=" + email,
                success: function(result) {
                    if (result === false) {
                        error.show();
                    }
                    else {
                        error.hide()
                    }
                }
            })
        }
    }

    function sendRecoveryEmail() {
        let email = $('#recovery-email').val();
        document.getElementById('result-address').innerText = email;
        $('#recovery-container').load(' #email-sent > *');
        $.ajax({
            url: "/recovery/send?email=" + email,
        })
    }
</script>
</html>
