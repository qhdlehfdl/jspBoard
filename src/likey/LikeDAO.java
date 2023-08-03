package likey;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDAO {
    private Connection conn;
    private ResultSet rs;

    public LikeDAO(){
        try{
            String dbURL = "jdbc:mysql://localhost:3306/bbs";
            String dbID = "root";
            String dbPassword="gh5968";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public int checkClick(String userID, int bbsID) {
        String SQL = "select * from likey where userID = ? and bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            pstmt.setInt(2,bbsID);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                return 0;
            }else{
                return 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int click(String userID, int bbsID, String likeyType) {
        if(checkClick(userID,bbsID)==0)
            return -2;
        else if (checkClick(userID, bbsID) == -1)
            return -1;

        String SQL="INSERT INTO likey VALUES(?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            pstmt.setInt(2,bbsID);
            pstmt.setString(3,likeyType);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int countLike(int bbsID) {
        String SQL = "select count(*) from likey where bbsID = ? and likeyType='like'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bbsID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int countUnlike(int bbsID) {
        String SQL = "select count(*) from likey where bbsID = ? and likeyType='unlike'";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bbsID);
            rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }
}
