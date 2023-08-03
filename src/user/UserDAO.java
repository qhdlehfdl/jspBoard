package user;

import bbs.Bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserDAO(){
        //mysql에 접속
        try{
            String dbURL = "jdbc:mysql://localhost:3306/BBS";
            String dbID = "root";
            String dbPassword="gh5968";
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        String SQL="SELECT userPassword FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1;//로그인 성공
                }
                else return 0;//비밀번호 불일치
            }
            return -1;//아이디 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2; //데이터베이스 오류
    }

    public int join(User user) {
        String SQL="INSERT INTO USER VALUES(?,?,?,?,?)";
        try{
            pstmt=conn.prepareStatement(SQL);
            pstmt.setString(1,user.getUserID());
            pstmt.setString(2,user.getUserPassword());
            pstmt.setString(3,user.getUserName());
            pstmt.setString(4,user.getUserGender());
            pstmt.setString(5,user.getUserEmail());
            return pstmt.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }
        return -1;
    }

    public User getUser(String userID) {
        String SQL="SELECT * FROM USER WHERE userID = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, userID);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                User user=new User();
                user.setUserID(rs.getString(1));
                user.setUserPassword(rs.getString(2));
                user.setUserName(rs.getString(3));
                user.setUserGender(rs.getString(4));
                user.setUserEmail(rs.getString(5));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(String userID, String userPassword, String userName, String userGender, String userEmail, String beforeuserID) {
        String SQL="UPDATE USER SET  userID = ?, userPassword = ?, userName = ?, userGender = ?, userEmail = ? WHERE userID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            pstmt.setString(2,userPassword);
            pstmt.setString(3,userName);
            pstmt.setString(4,userGender);
            pstmt.setString(5,userEmail);
            pstmt.setString(6,beforeuserID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }
}
