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
                        <li><a class="dropdown-item" href="myPage.jsp">마이페이지</a></li>
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
                        <div class="col-3 text-left"><strong><%=restName%></strong></div>
                        <div class="col-5 text-end">
                            <img src="./image/star.svg" style="width:15px">
                            <strong><%=myReviewValue[2]%></strong>
                        </div>
                        <div class="col-4 text-end">
                            <strong><%= myReviewValue[4]%></strong>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-9 text-start">
                            <h5><%=myReviewValue[1]%></h5>
                        </div>
                        <div class="col-2 text-end">
                            <%
                                userID = null;
                                String reviewRecommendCount = null;
                                reviewRecommendCount = reviewdao.reviewCount(myReviewValue[3]);
                            %>
                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
                                <path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
                            </svg> (<%=reviewRecommendCount%>)
                        </div>
                        <div class="col-1 text-end">
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
