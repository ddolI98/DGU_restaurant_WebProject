package user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.databaseUtil;

import java.sql.PreparedStatement;

public class userDAO {
    public static int login(String loginID, String password) {
        String SQL = "SELECT password FROM USER WHERE loginID = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, loginID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                if(rs.getString(1).equals(password)) {
                    return 1;
                }
                else {
                    return 0;
                }
            }
            return -1;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {if(conn != null) conn.close();} catch (Exception e) {e.printStackTrace();}
            try {if(pstmt != null) pstmt.close();} catch (Exception e) {e.printStackTrace();}
            try {if(rs != null) rs.close();} catch (Exception e) {e.printStackTrace();}
        }
        return -2;
    }

    public static int join(String loginID, String password, String nickName, String mailAddress, String userName, String userAge, String phoneNumber, String userAddress) {
        String SQL = "INSERT INTO USER(loginID, password, nickName, mailAddress, userName, userAge, phoneNumber, userAddress) VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            Connection conn = databaseUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, loginID);
            pstmt.setString(2, password);
            pstmt.setString(3, nickName);
            pstmt.setString(4, mailAddress);
            pstmt.setString(5, userName);
            pstmt.setString(6, userAge);
            pstmt.setString(7, phoneNumber);
            pstmt.setString(8, userAddress);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

}
