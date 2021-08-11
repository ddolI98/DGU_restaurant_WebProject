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
<body>
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
<br><br><br><br>
<div class="py-5 text-center">
    <img class="d-block mx-auto mb-4" src="./img/mainIcon.svg" alt="" width="150px">
    <h2>회원가입</h2>
</div>
<div class="container col-md-8 col-lg-6">
    <hr class="my-4">
    <h4 class="mb-3">기본 정보 입력</h4>
    <form method="post" action="signUpAction.jsp">
        <div class="row g-3">
            <div class="col-12">
                <label for="userName" class="form-label">이름</label>
                <input type="text" class="form-control" name="userName" id="userName" placeholder="" value="" required>
            </div>
            <div class="col-12">
                <label for="loginID" class="form-label">아이디<span class="text-muted">(4자~12자리의 영문자, 숫자)</span></label>
                <input type="id" class="form-control" name="loginID" id="loginID" placeholder="" required>
            </div>
            <div class="col-12">
                <label for="password" class="form-label">비밀번호<span class="text-muted">(8자~20자리의 영문자, 숫자, 특수문자)</span></label>
                <input type="password" class="form-control" name="password" id="password" placeholder="" required>
            </div>
            <div class="col-12">
                <label for="passwordVerify" class="form-label">비밀번호 재입력<span class="text-muted">(8자~20자리의 영문자, 숫자, 특수문자)</span></label>
                <input type="password" class="form-control" name="passwordVerify" id="passwordVerify" placeholder="" required>
            </div>
            <div class="col-12">
                <label for="mailAddress" class="form-label">이메일</label>
                <input type="email" class="form-control" name="mailAddress" id="mailAddress" placeholder="you@example.com" required>
            </div>
            <div class="col-12 d-flex">
                <div class="col-4" style="margin-right: 45px">
                    <label for="userAge" class="form-label">나이</label>
                    <select class="form-select" name="userAge" id="userAge" required>
                        <option value="">선택</option>
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
                    <label for="phoneNumber" class="form-label">전화번호</label>
                    <input type="number" class="form-control" name="phoneNumber" id="phoneNumber" placeholder="" required>
                </div>
            </div>
            <hr class="my-4">
            <h4 class="mb-3">부가 정보 입력</h4>
            <div class="col-12">
                <label for="nickName" class="form-label">닉네임</label>
                <input type="text" class="form-control" name="nickName" id="nickName" placeholder="" required>
            </div>
            <div class="col-12">
                <label for="userAddress" class="form-label">주소</label>
                <input type="text" class="form-control" name="userAddress" id="userAddress" placeholder="" required>
            </div>

            <div class="my-3">
                <label class="form-label">이용 목적</label>
                <div class="form-check-label">
                    <input id="president" name="purpose" type="radio" class="form-check-input" checked required>
                    <label class="form-check-label" for="president">사장님</label>
                </div>
                <div class="form-check">
                    <input id="guest" name="purpose" type="radio" class="form-check-input" required>
                    <label class="form-check-label" for="guest">손님</label>
                </div>
            </div>
        </div>
        <button class="w-100 btn btn-lg btn" type="submit" style="background-color: #FAF1D6">회원가입</button>
    </form>
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

