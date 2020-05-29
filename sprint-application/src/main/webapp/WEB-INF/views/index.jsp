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
    <title>Welcome - Sprint</title>
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
</head>
<body>
    <div class="page-wrapper chiller-theme">
        <main class="page-content">

            <%--        Navbar--%>
            <nav id="navbar" class="navbar navbar-expand-sm bg-dark navbar-dark" style="min-height: 60.8px;">
                <a style="padding-top: 25px;" id="logo" class="navbar-brand" href="${pageContext.request.contextPath}/"><img src="<c:url value="/resources/images/logo.svg"/>" style="width: 120px; height: 60px;" alt="logo"/></a>
            </nav>

            <%--        Main Content--%>
            <div style="box-shadow: none" class="login-container">
                <div style="text-align: center; padding-top: 20px" class="col-lg-12">
                    <div style="padding-bottom: 0; margin-bottom: 0; background-color: white;" class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <p class="lead">Enter your email to get started.</p>
                        </div>
                    </div>
                    <form style="margin-bottom: 0; width: 226.67px;" action="${pageContext.request.contextPath}/register/get-started" method="post">
                        <div class="form-group">
                            <input class="form-control" type="email" name="email" placeholder="Enter email address" required>
                        </div>
                        <button id="login-button" type="submit" class="btn btn-primary">Continue</button>
                    </form>
                    <div style="padding-bottom: 0; margin-bottom: 0; padding-top: 1rem;" class="jumbotron jumbotron-fluid">
                        <div class="container">
                            <p class="lead">Or</p>
                        </div>
                    </div>
                    <form action="${pageContext.request.contextPath}/login" method="get">
                        <button style="width: 226.667px;" id="login-button" type="submit" class="btn btn-primary">Login</button>
                    </form>
                </div>
            </div>

        </main>
    </div>
</body>
</html>
