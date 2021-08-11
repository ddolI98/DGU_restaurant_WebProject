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
    if(loginID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('아이디를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(password == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('비밀번호를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(nickName == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('닉네임을 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(mailAddress == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이메일을 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(userName == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이름을 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(phoneNumber == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('전화번호를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(userAge == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('나이를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
    if(userAddress == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('주소를 입력해주세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
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
