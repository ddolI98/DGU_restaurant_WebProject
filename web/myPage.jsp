<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="review.reviewDAO"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.databaseUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>맛동국</title>
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/custom.css">
    <link rel="icon" href="./image/favicon.png">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm" style="background-color: #FAF1D6;">
    <div class="container-xxl d-flex align-items-md-center" style="width:1200px">
        <a class="navbar-brand" href="index.jsp"><img src="./image/mainIcon.svg" class="rounded float-start" width="120"></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">식당</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        더보기
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: #FAF1D6;">
                        <li><a class="dropdown-item" href="storeInfo.jsp">공지사항</a></li>
                        <li><a class="dropdown-item" href="#">이벤트</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="#">신고하기</a></li>
                    </ul>
                </li>
            </ul>
            <%
                String loginID = null;
                String userName = null;
                if(session.getAttribute("loginID") != null) {
                    loginID = (String) session.getAttribute("loginID");
                    userName = (String) session.getAttribute("userName");
                }
                if(loginID == null) {
            %>
            <ul class="navbar-nav d-flex">
                <a class="nav-link" aria-current="page" href="signUp.jsp">회원가입</a>
                <a class="btn btn-outline-warning" href="login.jsp" style="border-color: #FFD6AA; color: #FFD6AA">로그인</a>
            </ul>
            <%
            } else {
            %>
            <ul class="navbar-nav d-flex">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <%=userName %> 님
                    </a>
                    <ul class="dropdown-menu" aria-labelledby="navbarDropdown" style="background-color: #FAF1D6;">
                        <li><a class="dropdown-item" href="#">마이페이지</a></li>
                        <li><a class="dropdown-item" href="#">1:1 문의</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" href="logout.jsp">로그아웃</a></li>
                    </ul>
                </li>
            </ul>
            <%
                }
            %>
        </div>
    </div>
</nav><br><br><br><br>
<ul class="nav nav-pills container justify-content-center" id="nav-tab" role="tablist" style="max-width: 220px">
    <li class="nav-item" role="presentation">
        <button class="nav-link active" id="userTab" data-bs-toggle="tab" data-bs-target="#user" type="button" role="tab" aria-controls="user" aria-selected="true" style="color:#000000">회원정보</button>
    </li>
    <li class="nav-item" role="presentation">
        <button class="nav-link" id="reviewTab" data-bs-toggle="tab" data-bs-target="#review" type="button" role="tab" aria-controls="review" aria-selected="false" style="color:#000000;">&nbsp;&nbsp;내후기&nbsp;&nbsp;</button>
    </li>
</ul><br>
<div class="tab-content container col-md-8 col-lg-6" id="nav-tabContent">
    <div class="tab-pane fade show active" id="user" role="tabpanel" aria-labelledby="userTab">
        <div class="container">

        </div>
    </div>
    <%
        List<String[]> myReview = null;
        String restName = null;
        String userID = (String) session.getAttribute("userID");
        reviewDAO reviewdao = new reviewDAO();
        myReview = reviewdao.myReview(userID);

    %>
    <div class="tab-pane fade show active" id="review" role="tabpanel" aria-labelledby="reviewTab">
        <div class="container row">
            <hr class="my-4">
            <%
                for(String[] myReviewValue : myReview){
                    restName = reviewDAO.getRestName(myReviewValue[0]);
            %>
            <div class="card bg-light mt-3" style="margin-bottom: 30px">
                <div class="card-header bg-light">
                    <div class="row">
                        <div class="col-9 text-left"><strong><%=restName%></strong></div>
                        <div class="col-3 text-end">
                            <img src="./image/star.svg" style="width:15px">
                            <strong><%=myReviewValue[2]%></strong>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-9 text-left"><h5><%=myReviewValue[1]%></h5></div>
                        <div class="col-3 text-end">
                            <a onclick="return confirm('이 리뷰를 삭제하시겠습니까?')" href="action/deleteReview.jsp?reviewID=<%=myReviewValue[3]%>">삭제</a>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>


<footer class="bg-light mt-4 p-5 text-center" style="color: #000000;">
    전화번호 : 010-9564-3580<br>
    Copyright &copy; 2021 ddolI98 All Rights Reserved.
</footer>
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
