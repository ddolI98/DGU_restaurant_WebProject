package review;
import util.databaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class reviewDAO {

    public static ArrayList<String[]> getStoreReview(Integer restID) {
        String SQL = "SELECT userID, contents, score FROM REVIEW WHERE restID = ?";
        ArrayList<String[]> review = new ArrayList<String[]>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, restID);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                String[] reviewValue = new String[3];
                reviewValue[0] = rs.getString(1);
                reviewValue[1] = rs.getString(2);
                reviewValue[2] = rs.getString(3);
                review.add(reviewValue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }

    public static int review(String restID, String userID, String contents, String score) {
        String SQL = "INSERT INTO REVIEW(restID, userID, contents, score) VALUES(?, ?, ?, ?)";

        try {
            Connection conn = databaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, restID);
            pstmt.setString(2, userID);
            pstmt.setString(3, contents);
            pstmt.setString(4, score);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static String avgScore(int restID) {
        String SQL = "SELECT ROUND(AVG(SCORE), 1) FROM REVIEW WHERE restID = ?";
        String avgScore = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, restID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                avgScore = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return avgScore;
    }

    public static ArrayList<String[]> myReview(String userID) {
        String SQL = "SELECT restID, contents, score, reviewID FROM REVIEW WHERE userID = ?";
        ArrayList<String[]> review = new ArrayList<String[]>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                String[] reviewValue = new String[4];
                reviewValue[0] = rs.getString(1);
                reviewValue[1] = rs.getString(2);
                reviewValue[2] = rs.getString(3);
                reviewValue[3] = rs.getString(4);
                review.add(reviewValue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return review;
    }

    public static String getRestName(String restID) {
        String SQL = "SELECT name FROM RESTAURANT WHERE serialNum = ?";
        Connection conn = null;
        String name = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, restID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                name = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public static int deleteReview(String reviewID) {
        String SQL = "DELETE TABLE FROM REVIEW WHERE reviewID = ?";

        try {
            Connection conn = databaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reviewID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
