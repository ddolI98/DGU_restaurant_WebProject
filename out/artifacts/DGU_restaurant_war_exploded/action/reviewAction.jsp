<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="review.reviewDTO"%>
<%@ page import="review.reviewDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String restID = null;
    String userID = null;
    String score = null;
    String contents = null;

    if(request.getParameter("restID") != null) {
        restID = (String) request.getParameter("restID");
    }
    if(request.getParameter("userID") != null) {
        userID = (String) request.getParameter("userID");
    }
    if(request.getParameter("contents") != null) {
        contents = (String) request.getParameter("contents");
    }
    if(request.getParameter("score") != null) {
        score = (String) request.getParameter("score");
    }
    reviewDAO reviewdao = new reviewDAO();
    int result = reviewdao.review(restID, userID, contents, score);
    System.out.println(result);
    if(result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('리뷰가 작성되었습니다.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }
%>