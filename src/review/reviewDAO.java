package review;

import util.databaseUtil;

import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class reviewDAO {

    public static List<String[]> getStoreReview(Integer restID) {
        String SQL = "SELECT userID, contents, score FROM REVIEW WHERE restID = ?";
        List<String[]> review = new ArrayList<String[]>();
        String[] reviewValue = new String[3];
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, restID);
            rs = pstmt.executeQuery();
            while(rs.next()) {
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

}
