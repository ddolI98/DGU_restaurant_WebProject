<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>맛동국</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.css">
    <link rel="icon" href="./img/favicon.png">
</head>
<body class="text-center">
<nav class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm" style="background-color: #FAF1D6; z-index: 2;">
    <div class="container-xxl d-flex align-items-md-center">
        <a class="navbar-brand" href="index.jsp"><img src="./img/mainIcon.svg" class="rounded float-start" width="120"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">식당</a>
                </li>
                <li class="nav-item dropdown ">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        더보기
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: #FAF1D6;">
                        <li><a class="dropdown-item" href="#">공지사항</a></li>
                        <li><a class="dropdown-item" href="#">이벤트</a></li>
                        <li><a class="dropdown-item" href="#">1:1 문의</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">신고하기</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="navbar-nav d-flex">
                <a class="nav-link" aria-current="page" href="#">회원가입</a>
                <a class="btn btn-outline-warning" href="login.jsp">로그인</a>
            </ul>
        </div>
    </div>
</nav>
<br><br><br><br><br><br><br><br><br><br><br>
<section class="container" style="max-width:500px;">
<form method="post" action="loginAction.jsp">
    <img src="./img/mainIcon.svg" class="rounded" width="250"><br><br>

    <div class="form-floating">
        <input type="ID" class="form-control" id="floatingInput" placeholder="name@example.com" style="border-bottom-color: #FFFFFF; border-radius: 5px 5px 0px 0px;">
        <label for="floatingInput">ID</label>
    </div>
    <div class="form-floating">
        <input type="password" class="form-control" id="floatingPassword" placeholder="Password" style="border-radius: 0px 0px 5px 5px;">
        <label for="floatingPassword">Password</label>
    </div><br>
    <button class="w-100 btn btn-lg btn" type="submit" style="background-color: #FAF1D6">로그인</button>
    <br><br>
    <div class="d-grid gap-2 d-md-block">
        <button class="btn btn" type="button" style="background-color: #FFFFFF">아이디/비밀번호 찾기</button>
        <button class="btn btn" type="button" style="background-color: #FFFFFF">회원가입</button>
    </div>
</form>
</section>
<br><br><br><br><br><br><br><br><br><br><br>
<footer class="bg-light mt-4 p-5 text-center" style="color: #000000;">
    전화번호 : 010-9564-3580<br>
    Copyright &copy; 2021 ddolI98 All Rights Reserved.
</footer>
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>

