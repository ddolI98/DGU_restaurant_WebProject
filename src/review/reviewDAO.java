package review;
import util.databaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class reviewDAO {

    public static ArrayList<String[]> getStoreReview(Integer restID) {
        String SQL = "SELECT reviewID, userID, contents, score, createdAt FROM REVIEW WHERE restID = ?";
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
                String[] reviewValue = new String[5];
                reviewValue[0] = rs.getString(1);
                reviewValue[1] = rs.getString(2);
                reviewValue[2] = rs.getString(3);
                reviewValue[3] = rs.getString(4);
                reviewValue[4] = rs.getString(5);
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

    public static boolean ifReviewed(String userID, String reviewID) {
        String SQL = "SELECT reviewRecommendID FROM REVIEWRECOMMEND WHERE userID = ? and reviewID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            pstmt.setString(2, reviewID);
            rs = pstmt.executeQuery();
            if(rs.next()) return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int reviewRecommend(String reviewID, String userID) {
        String SQL = "INSERT INTO REVIEWRECOMMEND(reviewID, userID) VALUES(?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reviewID);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static int reviewRecommendCancel(String reviewID, String userID) {
        String SQL = "DELETE FROM REVIEWRECOMMEND WHERE reviewID = ? and userID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reviewID);
            pstmt.setString(2, userID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static String reviewCount(String reviewID) {
        String SQL = "SELECT COUNT(*) FROM REVIEWRECOMMEND WHERE reviewID = ?";
        String count = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, reviewID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                count = rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

}