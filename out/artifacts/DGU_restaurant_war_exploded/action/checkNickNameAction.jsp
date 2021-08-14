<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="user.userDTO"%>
<%@ page import="user.userDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
  request.setCharacterEncoding("UTF-8");
  String nickName = null;

  if(request.getParameter("nickName") != null) {
    nickName = (String) request.getParameter("nickName");
  }

  userDAO userdao = new userDAO();
  boolean result = userdao.checkNickName(nickName);
  if(result) {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('중복되는 닉네임 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
  } else {
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert('사용가능한 닉네임 입니다.');");
    script.println("history.back();");
    script.println("</script>");
    script.close();
    return;
  }
%>