<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.userDAO"%>
<%@ page import="store.storeDAO"%>
<%@ page import="review.reviewDAO"%>
<%@ page import="java.math.BigDecimal" %>
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
</nav>
<%
    Integer restID = null;
    Integer ownerID;
    String storeName;
    String explane;
    String category;
    String address;
    String phoneNumber;
    String startHours;
    String endHours;
    String avgScore;
    String holiday;

    String[] storeInfo = new String[9];
    String[] storeImg = new String[3];
    BigDecimal[] mapInfo = new BigDecimal[2];

    List<String[]> review = null;

    storeDAO storedao = new storeDAO();
    reviewDAO reviewDAO = new reviewDAO();

    if(request.getParameter("serialNum") != null) {
        restID = Integer.parseInt(request.getParameter("serialNum"));
        storeInfo = storedao.getStoreInfo(restID);
        mapInfo = storedao.getStoreMap(restID);
        review = reviewDAO.getStoreReview(restID);
        storeImg = storedao.getStoreImg(restID);
    }


    //String[] reviewValue = new String[3];

    storeName = storeInfo[0];
    explane = storeInfo[1];
    category = storeInfo[2];
    phoneNumber = storeInfo[3];
    address = storeInfo[4];
    startHours = storeInfo[5];
    endHours = storeInfo[6];
    avgScore = storeInfo[7];
    holiday = storeInfo[8];

    BigDecimal latitude = mapInfo[0];
    BigDecimal longitude = mapInfo[1];

    ArrayList<String[]> similarInfo = null;


    similarInfo = storedao.getStoreSimilar(category, latitude, longitude);

%>
<div id="mainSlide" class="carousel slide carousel-fade" data-bs-ride="carousel" style="width:1100px; height:650px; margin: auto; display: flex; margin-bottom:40px; margin-top: 100px;">
    <div class="carousel-indicators">
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="1" aria-label="Slide 2"></button>
        <button type="button" data-bs-target="#mainSlide" data-bs-slide-to="2" aria-label="Slide 3"></button>
    </div>
    <div class="carousel-inner">
        <div class="carousel-item active" id="first">
            <img src="<%=storeImg[0]%>" class="d-block w-100" alt="첫번째">
        </div>
        <div class="carousel-item" id="second">
            <img src="<%=storeImg[1]%>" class="d-block w-100" alt="두번째">
        </div>
        <div class="carousel-item" id="third">
            <img src="<%=storeImg[2]%>" class="d-block w-100" alt="세번째">
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
<h2 style="font-size: 30px; text-align:center; "><strong><%=storeName %></strong></h2>
<div style="position: absolute; left: 48%; margin: auto;">
    <svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <rect width="30" height="30" fill="url(#pattern0)"/>
        <defs>
            <pattern id="pattern0" patternContentUnits="objectBoundingBox" width="1" height="1">
                <use xlink:href="#image0" transform="scale(0.00125)"/>
            </pattern>
            <image id="image0" width="800" height="800" xlink:href="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAyAAAAMgCAYAAADbcAZoAAAgAElEQVR4Ae3dW3Ibx7IFUM9JH5qPx6cZOMIfnhhvgFfUoSgC7EbXIx/rRJywLZFA98LuqsqqpPTXX/5HgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIECBAgAABAgQIEGgh8PLv97/f/7/FTbtJAgQIECBAgAABAgTmCPwqLv75/t/L7f8/vr2c+v/b9/0sVOZcpVclQIAAAQIECBAgQCCtwGvR8UyxcbQ4ub32v9//TgvkwgkQIECAAAECBAgQuCYwveh4VJwoRq59eL6bAAECBAgQIECAQBaBp9qqHhUTV37PyUiW2LhOAgQIECBAgAABAucEQhUeH4sWhci5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"/>
        </defs>
    </svg>
    <h4 style="display:inline"><%=avgScore %></h4><br>
</div><br><br>
<h5 style="text-align: center"><%=explane %></h5><br><br>

<section class="container" style="max-width:1200px;">
<div class="container justify-content-between align-items-center">
    <div class="row">
        <div class="col-8" >
            <div style="margin-top: 30px;">
                <h5><strong>분류</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=category %></h5><br>
                <h5><strong>전화번호</strong>&nbsp;&nbsp;&nbsp;<%=phoneNumber %></h5><br>
                <h5><strong>주소</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=address %></h5><br>
                <%
                    if(startHours != null) {
                %>
                <h5><strong>영업시간</strong>&nbsp;&nbsp;&nbsp;<%=startHours %>부터 <%=endHours %></h5><br>
                <%
                    }
                %>
                <%
                    if(holiday != null) {
                %>
                <h5><strong>휴무</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=holiday %></h5><br>
                <%
                    }
                %>
            </div>
        </div>
        <div class="col-1"></div>
        <div class="col-3">
            <div id="map" style="width:100%; height:270px;">
                <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cb6da4e816f1b380f9f5043c839fdeeb"></script>
                <script>
                    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                        mapOption = {
                            center: new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>), // 지도의 중심좌표
                            level: 3 // 지도의 확대 레벨
                        };

                    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

                    // 마커가 표시될 위치입니다
                    var markerPosition  = new kakao.maps.LatLng(<%=latitude%>, <%=longitude%>);

                    // 마커를 생성합니다
                    var marker = new kakao.maps.Marker({
                        position: markerPosition,
                        clickable: true
                    });

                    // 마커가 지도 위에 표시되도록 설정합니다
                    marker.setMap(map);

                    kakao.maps.event.addListener(marker, 'click', function() {
                        // 마커 위에 인포윈도우를 표시합니다
                        window.open('https://map.kakao.com/link/map/<%=latitude%>,<%=longitude%>', '_blank');
                    });
                </script>
            </div>
            <br><br>
            <%
                String userID = null;
                if(session.getAttribute("loginID") != null) {
                    userID = (String) session.getAttribute("userID");
                }
                if(loginID == null) {
            %>
            <button class="w-100 btn btn-lg btn" type="button" onclick="location.href='login.jsp'" style="background-color: #faf1d6">리뷰 쓰기</button>
            <%
                } else {
            %>
            <button class="w-100 btn btn-lg btn" type="button"  data-bs-toggle="modal" data-bs-target="#wrtReview"  style="background-color: #faf1d6">리뷰 쓰기</button>
            <%
                }
            %>

            <div class="modal fade" id="wrtReview" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="./action/reviewAction.jsp">
                            <div class="modal-header">
                                <h4 class="modal-title" id="exampleModalLabel">리뷰 쓰기</h4>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3 d-flex">
                                    <label for="score" class="col-form-label col-md-3">별점</label>
                                    <select class="form-select col-md-9 ms-auto" name="score" id="score" style="width:350px" required>
                                        <option>선택</option>
                                        <option>1.0</option>
                                        <option>1.5</option>
                                        <option>2.0</option>
                                        <option>2.5</option>
                                        <option>3.0</option>
                                        <option>3.5</option>
                                        <option>4.0</option>
                                        <option>4.5</option>
                                        <option>5.0</option>
                                    </select>
                                </div>
                                <div class="mb-3 d-flex">
                                    <input type="hidden" name="userID" value="<%=userID%>" id="userID">
                                    <input type="hidden" name="restID" value="<%=restID%>" id="restID">
                                    <label for="contents" class="col-form-label col-md-3">후기</label>
                                    <textarea class="form-control col-md-9 ms-auto" name="contents" id="contents" style="width:350px" required></textarea>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn" style="background-color: #d3d3d3" data-bs-dismiss="modal">닫기</button>
                                <button type="submit" class="btn" style="background-color: #faf1d6">완료</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class = "container">
    <div class="row">
        <div class="col-8">
            <h3 style="font-size: 30px; margin-top: 50px;"><strong>리뷰(<%=review.size()%>)</strong></h3>
            <hr class="my-4">
            <%
                for(String[] reviewValue : review){
                    String nickname = null;
                    nickname = userDAO.getNickName(Integer.parseInt(reviewValue[0]));
            %>
            <div class="card bg-light mt-3" style="margin-bottom: 30px">
                <div class="card-header bg-light">
                    <div class="row">
                        <div class="col-9 text-left"><strong><%=nickname%></strong></div>
                        <div class="col-3 text-end">
                            <img src="./image/star.svg" style="width:15px">
                            <strong><%= reviewValue[2]%></strong>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h5 class="card-title"><%=reviewValue[1]%></h5>
                </div>
            </div>
            <%
                }
            %>
        </div>
        <div class="col-1"></div>
        <div class="col-3">
            <br><h5 style="text-align:center"><strong><%=storeName %></strong>와(과)<br>유사한 주변 음식점</h5><br>

            <%
                for(String[] infoValue : similarInfo){
                    Integer serialNum = null;
                    String name = null;
                    String explaneS = null;
                    String mainImg = null;
                    String score = null;
                    serialNum = Integer.parseInt(infoValue[0]);
                    name = infoValue[1];
                    explaneS = infoValue[2];
                    mainImg = infoValue[3];
                    score = infoValue[4];
            %>
            <a href="storeInfo.jsp?serialNum=<%= serialNum%>"><img src="<%= mainImg%>" width="100%" height="200"></a>
            <div class="card-body">
                <div class="d-flex justify-content-between align-items-center">
                    <h4 class="card-text"><%= name %></h4>
                    <div class="text-end">
                        <img src="./image/star.svg" style="width:15px">
                        <small class="text-muted"><strong><%=score%></strong></small>
                    </div>
                </div>
                <div style="margin-top:10px;margin-bottom: 10px">
                    <p class="card-text"><%= explaneS%></p>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>
</section>


<br><br>
<footer class="bg-light mt-4 p-5 text-center" style="color: #000000;">
    전화번호 : 010-9564-3580<br>
    Copyright &copy; 2021 ddolI98 All Rights Reserved.
</footer>
<script src="./js/jquery.min.js"></script>
<script src="./js/popper.js"></script>
<script src="./js/bootstrap.min.js"></script>
</body>
</html>
