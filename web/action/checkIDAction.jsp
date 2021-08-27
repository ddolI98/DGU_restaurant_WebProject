<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
  request.setCharacterEncoding("UTF-8");
  String loginID = null;

  if(request.getParameter("loginID") != null) {
    loginID = (String) request.getParameter("loginID");
  }

  userDAO userdao = new userDAO();
  boolean result = userdao.checkID(loginID);
  if(result) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('중복되는 아이디 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
  } else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('사용가능한 아이디 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
  }
%>