<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="review.reviewDTO"%>
<%@ page import="review.reviewDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    String reviewID = null;
    String userID = null;
    String restID = null;

    userID = (String) session.getAttribute("userID");

    if(request.getParameter("reviewID") != null) {
        reviewID = (String) request.getParameter("reviewID");
    }
    if(request.getParameter("restID") != null) {
        restID = (String) request.getParameter("restID");
    }
    reviewDAO reviewdao = new reviewDAO();
    int result = reviewdao.reviewRecommendCancel(reviewID, userID);
    if(result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('리뷰 추천을 취소하였습니다.');");
        script.println("location.href='./../storeInfo.jsp?serialNum=" + restID + "'");
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