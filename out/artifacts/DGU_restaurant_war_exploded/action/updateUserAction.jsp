<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
  request.setCharacterEncoding("UTF-8");
  String loginID = null;
  String password = null;
  String nickName = null;
  String mailAddress = null;
  String userName = null;
  String userAge = null;
  String phoneNumber = null;
  String userAddress = null;

  if(request.getParameter("loginID") != null) {
    loginID = (String) request.getParameter("loginID");
  }
  if(request.getParameter("password") != null) {
    password = (String) request.getParameter("password");
  }
  if(request.getParameter("nickName") != null) {
    nickName = (String) request.getParameter("nickName");
  }
  if(request.getParameter("mailAddress") != null) {
    mailAddress = (String) request.getParameter("mailAddress");
  }
  if(request.getParameter("userName") != null) {
    userName = (String) request.getParameter("userName");
  }
  if(request.getParameter("userAge") != null) {
    userAge = (String) request.getParameter("userAge");
  }
  if(request.getParameter("phoneNumber") != null) {
    phoneNumber = (String) request.getParameter("phoneNumber");
  }
  if(request.getParameter("postCode") != null) {
    userAddress = "(" + (String) request.getParameter("postCode") + ") " +
            (String) request.getParameter("address") + " " +
            (String) request.getParameter("detailAddress") +
            (String) request.getParameter("extraAddress");
  }
  userDAO userdao = new userDAO();
  int result;
  boolean checkID = userdao.checkID(loginID);
  boolean checkNickName = userdao.checkNickName(nickName);

  if (checkID == false && checkNickName == false) {
    result = userdao.updateUser(loginID, password, nickName, mailAddress, userName, userAge, phoneNumber, userAddress);
    if(result == 1) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
      script.println("alert('회원정보를 수정했습니다');");
      script.println("location.href = './../myPage.jsp';");
      script.println("</script>");
      script.close();
      return;
    }
  }
  else if (checkID == false) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('중복되는 닉네임 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
  }
  else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('중복되는 ID 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
  }

%>
