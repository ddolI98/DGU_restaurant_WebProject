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
<div class="tab-content container" id="nav-tabContent">
    <div class="tab-pane fade show active" id="user" role="tabpanel" aria-labelledby="userTab">
        <div class="container">
            <div class="container col-8">
                <form method="post" action="action/updateUserAction.jsp" name="userInfo" onsubmit="return checkValue()">
                    <div class="row g-3">
                        <div class="col-12">
                            <label for="userName" class="form-label">이름</label>
                            <input type="text" class="form-control" name="userName" id="userName" placeholder="" value="<%=(String)session.getAttribute("userName")%>" required>
                        </div>
                        <div class="col-12">
                            <label for="loginID" class="form-label">아이디<span class="text-muted">(4자~12자리의 영문자 또는 영문자, 숫자 권장)</span></label>
                            <div class="col-12 d-flex">
                                <input type="id" class="form-control" name="loginID" id="loginID" value="<%=(String)session.getAttribute("loginID")%>" style="margin-right: 10px" required>
                                <input type="button" class="col-2 btn" onclick="openCheckID()" style="background-color: #FAF1D6;" value="중복확인">
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="password" class="form-label">비밀번호<span class="text-muted">(8자~20자리의 영문자, 숫자, 특수문자 반드시 포함)</span></label>
                            <input type="password" class="form-control" name="password" id="password" onchange="checkPassword()" required>
                        </div>
                        <div class="col-12">
                            <label for="passwordVerify" class="form-label">비밀번호 재입력</label>
                            <input type="password" class="form-control" name="passwordVerify" id="passwordVerify" placeholder="" onchange="checkPassword()" required>
                            &nbsp;<span id="check"></span>
                        </div>
                        <div class="col-12">
                            <label for="mailAddress" class="form-label">이메일</label>
                            <input type="email" class="form-control" name="mailAddress" id="mailAddress" value="<%=(String)session.getAttribute("mailAddress")%>" required>
                        </div>
                        <div class="col-12 d-flex">
                            <div class="col-4">
                                <label for="userAge" class="form-label">나이</label>
                                <select class="form-select" name="userAge" id="userAge" value="<%=(String)session.getAttribute("userAge")%>" required>
                                    <option>선택</option>
                                    <option>14</option>
                                    <option>15</option>
                                    <option>16</option>
                                    <option>17</option>
                                    <option>18</option>
                                    <option>19</option>
                                    <option>20</option>
                                    <option>21</option>
                                    <option>22</option>
                                    <option>23</option>
                                    <option>24</option>
                                    <option>25</option>
                                    <option>26</option>
                                    <option>27</option>
                                    <option>28</option>
                                    <option>29</option>
                                    <option>30</option>
                                </select>
                            </div>
                            <div class="col-7">
                                <label for="phoneNumber" class="form-label"style="margin-left:10%;">전화번호</label>
                                <input type="number" class="form-control" name="phoneNumber" id="phoneNumber" value="<%=(String)session.getAttribute("phoneNumber")%>" style="margin-left:10%; width:104.5%" required>
                            </div>
                        </div>
                        <hr class="my-4">
                        <h4 class="mb-3">부가 정보 입력</h4>
                        <div class="col-12">
                            <label for="nickName" class="form-label">닉네임</label>
                            <div class="col-12 d-flex">
                                <input type="text" class="form-control" name="nickName" id="nickName" value="<%=(String)session.getAttribute("nickName")%>" style="margin-right: 10px" required>
                                <button class="col-2 btn" style="background-color: #FAF1D6;" onclick="openCheckNickName()">중복확인</button>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="postCode" class="form-label">주소</label>
                            <div class="col-12 d-flex">
                                <input type="text" class="form-control" name="postCode" id="postCode" placeholder="우편번호" style="margin-right: 10px" required>
                                <button class="col-3 btn" onclick="findPostalCode()" style="background-color: #FAF1D6;">우편번호 찾기</button>
                            </div>
                        </div>
                        <div class="col-12">
                            <input type="text" class="form-control" name="address" id="address" placeholder="주소" required>
                        </div>
                        <div class="col-12 d-flex">
                            <div class="col-7">
                                <input type="text" class="form-control" name="detailAddress" id="detailAddress" placeholder="상세주소" required>
                            </div>
                            <div class="col-4">
                                <input type="text" class="form-control" name="extraAddress" id="extraAddress" placeholder="참고항목" style="margin-left:10%; width:115%">
                            </div>
                        </div>
                        <div id="wrap" style="display:none;border:5px solid #FAF1D6;width:500px;height:300px;position:relative;overflow-y:hidden">
                            <button type="button" class="btn-close" id="btnFoldWrap" aria-label="Close" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldPostcode()"></button>
                        </div>
                        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
                        <script>
                            var element_wrap = document.getElementById('wrap');

                            function foldPostcode() {
                                element_wrap.style.display = 'none';
                            }

                            function findPostalCode() {
                                var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
                                new daum.Postcode({
                                    oncomplete: function(data) {
                                        var addr = '';
                                        var extraAddr = '';

                                        if (data.userSelectedType === 'R') {
                                            addr = data.roadAddress;
                                        } else {
                                            addr = data.jibunAddress;
                                        }

                                        if(data.userSelectedType === 'R'){
                                            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                                                extraAddr += data.bname;
                                            }
                                            if(data.buildingName !== '' && data.apartment === 'Y'){
                                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                                            }
                                            if(extraAddr !== ''){
                                                extraAddr = ' (' + extraAddr + ')';
                                            }
                                            document.getElementById("extraAddress").value = extraAddr;

                                        } else {
                                            document.getElementById("extraAddress").value = '';
                                        }

                                        document.getElementById('postCode').value = data.zonecode;
                                        document.getElementById("address").value = addr;
                                        document.getElementById("detailAddress").focus();

                                        element_wrap.style.display = 'none';
                                        document.body.scrollTop = currentScroll;
                                    },
                                    onresize : function(size) {
                                        element_wrap.style.height = size.height+'px';
                                    },
                                    width : '100%',
                                    height : '110%'
                                }).embed(element_wrap);
                                element_wrap.style.display = 'block';
                            }
                        </script>
                    </div><br><br>
                    <button class="w-100 btn btn-lg btn" type="submit" style="background-color: #FAF1D6;">수정</button>
                </form>
            </div>
        </div>
    </div>
    <div class="tab-pane fade show" id="review" role="tabpanel" aria-labelledby="reviewTab">
        <%
            List<String[]> myReview = null;
            String restName = null;
            String userID = (String) session.getAttribute("userID");
            reviewDAO reviewdao = new reviewDAO();
            myReview = reviewdao.myReview(userID);

        %>
        <div class="container row col-8">
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
