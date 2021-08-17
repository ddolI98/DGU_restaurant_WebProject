package store;

import util.databaseUtil;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class storeDAO {

    public static String[] getStoreInfo(Integer serialNum) {
        String SQL = "SELECT serialNum, name, explane, category, phoneNumber, address, startHours, endHours, avgScore, holiday FROM RESTAURANT WHERE serialNum = ?";
        String[] restInfo = new String[9];
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, serialNum);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                restInfo[0] = rs.getString(2);
                restInfo[1] = rs.getString(3);
                restInfo[2] = rs.getString(4);
                restInfo[3] = rs.getString(5);
                restInfo[4] = rs.getString(6);
                restInfo[5] = rs.getString(7);
                restInfo[6] = rs.getString(8);
                restInfo[7] = rs.getString(9);
                restInfo[8] = rs.getString(10);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return restInfo;
    }

    public static String[] getStoreImg(Integer restID) {
        String SQL = "SELECT Img_1, Img_2, Img_3 FROM RESTAURANT WHERE serialNum = ?";
        String[] storeImg = new String[3];
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, restID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                storeImg[0] = rs.getString(1);
                storeImg[1] = rs.getString(2);
                storeImg[2] = rs.getString(3);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return storeImg;
    }

    public static BigDecimal[] getStoreMap(Integer restID) {
        String SQL = "SELECT serialNum, latitude, longitude FROM RESTAURANT WHERE serialNum = ?";
        BigDecimal[] mapInfo = new BigDecimal[2];
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, restID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                mapInfo[0] = rs.getBigDecimal(2);
                mapInfo[1] = rs.getBigDecimal(3);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mapInfo;
    }

    public static ArrayList<String[]> getStoreSimilar(String category, BigDecimal latitude, BigDecimal longitude) {
        String SQL = "SELECT * FROM RESTAURANT " +
        "WHERE category = ? and " +
        "(6371*acos(cos(radians(?))*cos(radians(latitude))*cos(radians(longitude)-radians(?))+sin(radians(?))*sin(radians(latitude)))) <= 1";
        ArrayList<String[]> info = new ArrayList<String[]>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = databaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, category);
            pstmt.setBigDecimal(2, latitude);
            pstmt.setBigDecimal(3, longitude);
            pstmt.setBigDecimal(4, latitude);
            rs = pstmt.executeQuery();
            while(rs.next()) {
                String[] infoValue = new String[5];
                infoValue[0] = rs.getString(1); // serialNum
                infoValue[1] = rs.getString(2); // name
                infoValue[2] = rs.getString(3); // explane
                infoValue[3] = rs.getString(5); // mainImg
                infoValue[4] = rs.getString(15); // score

                info.add(infoValue);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return info;
    }

}
