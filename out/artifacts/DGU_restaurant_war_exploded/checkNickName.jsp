<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>닉네임 중복 체크</title>
	<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel="icon" href="./img/favicon.png">
	<style type="text/css">
	</style>
	<script type="text/javascript">
		function pValue(){
			document.getElementById("nickName").value = opener.document.userInfo.nickName.value;
		}

		function sendCheckValue(){
			opener.document.userInfo.nickName.value = document.getElementById("nickName").value;
			if (opener != null) {
            	opener.chkForm = null;
            	self.close();
			}	
		}	
	</script>
	
</head>
<body onload="pValue()" class="text-center" onsubmit="">
<div id="wrap col-12">
	<br>
	<h4>닉네임 중복체크</h4>
	<hr class="my-4">
	<hr size="1" width="460">
	<br>
	<div id="chk">
		<form method="post" action="action/checkNickNameAction.jsp" id="checkForm">
			<div class="col-10 d-flex align-items-md-center container-xxl">
				<input type="id" class="form-control" name="nickName" id="nickName" placeholder="" style="margin-right: 10px" required>
				<input class="col-3 btn" style="background-color: #FAF1D6;" type="submit" value="중복확인">
			</div>
		</form><br>
		<div class="gap-5 d-md-block align-items-md-center container-xxl">
			<button class="col-3 btn float-right" style="background-color: #FAF1D6;" id="useID" type="button" onclick="sendCheckValue()">사용하기</button>
			<button class="col-3 btn float-right" style="background-color: #FAF1D6;" id="cancel" style="margin-left: 10%" type="button" onclick="window.close()">취소</button>
		</div>
	</div>
</div>	
</body>
</html>