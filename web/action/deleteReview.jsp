<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="review.reviewDAO"%>
<%@ page import="review.reviewDTO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8");
    int result1 = -1;
    int result2 = -1;
    String reviewID = null;
    reviewDAO reviewdao = new reviewDAO();
    if(request.getParameter("reviewID") != null) {
        reviewID = (String) request.getParameter("reviewID");
        result1 = reviewdao.deleteReviewRecommend(reviewID);
        result2 = reviewdao.deleteReview(reviewID);
    }
    if(result1 == 1 && result2 == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('리뷰가 삭제되었습니다.');");
        script.println("location.href = './../myPage.jsp';");
        script.println("</script>");
        script.close();
        return;
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('데이터베이스 오류');");
        script.println("location.href = './../myPage.jsp';");
        script.println("</script>");
        script.close();
        return;
    }

%>