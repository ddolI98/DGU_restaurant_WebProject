<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="review.reviewDAO"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="util.databaseUtil" %>
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
</nav>
<div id="mainSlide" class="carousel slide carousel-fade" data-bs-ride="carousel" style="width:60%; margin: auto; display: flex; margin-bottom:40px; margin-top: 100px; border-radius:100px">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" id="first">
            <img src="./image/mainImg.svg" class="d-block w-100" alt="첫번째">
        </div>
        <div class="carousel-item" id="second">
            <img src="./image/chicken.png" class="d-block w-100" alt="두번째">
        </div>
        <div class="carousel-item" id="third">
            <img src="./image/pizza.png" class="d-block w-100" alt="세번째">
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#mainSlide" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#mainSlide" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
    </button>
</div>
<%
    String searchWord = request.getParameter("searchWord");
%>
<div class="container-xxl" style="width:550px; margin: auto;">
    <form class="d-flex" method="get" action="search.jsp">
        <input class="form-control" type="search" style="width:450px; border-right: #FFD6AA; border-radius: 10px 0px 0px 10px" placeholder="<%=searchWord%>" onfocus="this.placeholder = ''" aria-label="Search" name="searchWord">
        <button class="btn btn-outline-warning" type="submit" style="width:100px; border-radius: 0px 10px 10px 0px">검색</button>
    </form>
</div><br><br>
<div class="tab-content" id="nav-tabContent" style="width:1200px; margin:auto">
    <div class="tab-pane fade show active" id="all" role="tabpanel" aria-labelledby="allTab">
        <div class="container">
            <div class="row row-cols-1 row-cols-sm-2 row-cols-md-4 g-4">
                <%
                    int serialNum;
                    String name;
                    String explane;
                    String mainImg;
                    String SQL = "SELECT * FROM RESTAURANT WHERE name LIKE CONCAT('%',?,'%')";
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        conn = databaseUtil.getConnection();
                        pstmt = conn.prepareStatement(SQL);
                        pstmt.setString(1, searchWord);
                        rs = pstmt.executeQuery();


                        while(rs.next()) {
                            serialNum = Integer.parseInt(rs.getString(1));
                            name = rs.getString(2);
                            explane = rs.getString(3);
                            mainImg = rs.getString(5);
                %>
                <div class="col">
                    <a href="storeInfo.jsp?serialNum=<%= serialNum%>"><img src="<%= mainImg%>" width="100%" height="200"></a>
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <h4 class="card-text"><%= name %></h4>
                            <div class="text-end">
                                <img src="./image/star.svg" style="width:15px">
                                <%
                                    reviewDAO reviewdao = new reviewDAO();
                                    String avgScore = reviewdao.avgScore(serialNum);
                                    if (avgScore == null) {
                                %>
                                <small class="text-muted">X</small>
                                <%
                                } else {
                                %>
                                <small class="text-muted"><%=avgScore%></small>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div style="margin-top:10px;margin-bottom: 10px">
                            <p class="card-text"><%= explane%></p>
                        </div>
                    </div>
                </div>
                <%
                        }
                        rs.close();
                        pstmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
                        try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
                        try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
                    }
                %>
            </div>
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
