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
    String avgScore = null;
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
<%
    reviewDAO reviewdao = new reviewDAO();
    avgScore = reviewdao.avgScore(restID);
    if (avgScore == null) {
%>
<div><h4 style="text-align: center">첫 번째로 리뷰를 남겨보세요!</h4></div><br>
<%
    } else {
%>
<div style="position: absolute; left: 48%; margin: auto;">
    <img src="image/star.svg">
    <h4 style="display:inline"><%=avgScore %></h4><br>
</div><br><br>
<%
    }
%>
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
                if(loginID == null) {
            %>
            <button class="w-100 btn btn-lg btn" type="button" onclick="location.href='login.jsp'" style="background-color: #faf1d6">리뷰 쓰기</button>
            <%
                } else {
                    userID = (String) session.getAttribute("userID");
            %>
            <button class="w-100 btn btn-lg btn" type="button"  data-bs-toggle="modal" data-bs-target="#wrtReview"  style="background-color: #faf1d6">리뷰 쓰기</button>

            <div class="modal fade" id="wrtReview" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form method="post" action="action/reviewAction.jsp">
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
            <%
                }
            %>
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
                    <div class="row">
                        <div class="col-9 text-left"><h5><%=reviewValue[1]%></h5></div>
                        <div class="col-3 text-end">
                            <a onclick="return confirm('이 리뷰를 추천하시겠습니까?')" href="action/rcmdAction.jsp?reviewID=">추천</a>
                            <a onclick="return confirm('추천을 취소하시겠습니까?')" href="action/delRcmdAction.jsp?reviewID=">삭제</a>
                        </div>
                    </div>

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
