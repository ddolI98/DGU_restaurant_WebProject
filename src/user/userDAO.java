package user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import util.databaseUtil;

import java.sql.PreparedStatement;

public class userDAO {
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
