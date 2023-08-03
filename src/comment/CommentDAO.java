package comment;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CommentDAO {
    private Connection conn;
    private ResultSet rs;
    public CommentDAO(){
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

    public String getDate(){
        String SQL="SELECT NOW()";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";//데이터베이스 오류
    }

    public int getNext(){
        String SQL="SELECT commentID FROM COMMENT ORDER BY commentID DESC";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1)+1;
            }
            return 1;//첫번째 게시물인 경우
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int write(int bbsID, String userID, String commentContent) {
        String SQL="INSERT INTO comment VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,getNext());
            pstmt.setString(2,userID);
            pstmt.setInt(3,bbsID);
            pstmt.setString(4, commentContent);
            pstmt.setString(5, getDate());
            pstmt.setInt(6,1);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public ArrayList<Comment> getList(int bbsID ) {
        String SQL="SELECT * FROM COMMENT WHERE bbsID = ? AND commentAvailable = 1 ORDER BY bbsID DESC";
        ArrayList<Comment>list=new ArrayList<Comment>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bbsID);
            rs=pstmt.executeQuery();
            while (rs.next()) {
                Comment comment=new Comment();
                comment.setCommentID(rs.getInt(1));
                comment.setUserID(rs.getString(2));
                comment.setBbsID(rs.getInt(3));
                comment.setCommentContent(rs.getString(4));
                comment.setCommentDate(rs.getString(5));
                comment.setCommentAvailable(rs.getInt(6));
                list.add(comment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber) {
        String SQL="SELECT * FROM COMMENT WHERE commentID < ? AND commentAvailable = 1 ORDER BY commentID DESC LIMIT 10";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Comment getComment(int commentID) {
        String SQL="SELECT * FROM COMMENT WHERE commentID = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, commentID);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                Comment comment=new Comment();
                comment.setCommentID(rs.getInt(1));
                comment.setUserID(rs.getString(2));
                comment.setBbsID(rs.getInt(3));
                comment.setCommentContent(rs.getString(4));
                comment.setCommentDate(rs.getString(5));
                comment.setCommentAvailable(rs.getInt(6));
                return comment;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(String commentContent, int commentID) {
        String SQL="UPDATE COMMENT SET commentContent = ? WHERE commentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,commentContent);
            pstmt.setInt(2,commentID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int delete(int commentID) {
        String SQL="DELETE FROM COMMENT WHERE commentID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,commentID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int countComment(int bbsID) {
        String SQL = "select count(*) from comment where bbsID=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs = pstmt.executeQuery();
            if(rs.next()) {
                return rs.getInt(1); //sql문 수행한 반환값
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }
}
