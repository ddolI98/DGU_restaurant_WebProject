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
    if(request.getParameter("userAddress") != null) {
        userAddress = (String) request.getParameter("userAddress");
    }
    userDAO userdao = new userDAO();
    int result = userdao.join(loginID, password, nickName, mailAddress, userName, userAge, phoneNumber, userAddress);
    if(result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 성공했습니다.');");
        script.println("location.href = 'index.jsp';");
        script.println("</script>");
        script.close();
        return;
    }
%>
