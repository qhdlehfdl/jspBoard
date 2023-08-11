package bbs;

import java.awt.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {
    private Connection conn;
    private ResultSet rs;

    public class Pair{
        int ID;
        String s;

        public int getID() {
            return ID;
        }

        public void setID(int ID) {
            this.ID = ID;
        }

        public String getS() {
            return s;
        }

        public void setS(String s) {
            this.s = s;
        }
    }
    public BbsDAO(){
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
        String SQL="SELECT bbsID FROM BBS ORDER BY bbsID DESC";
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

    public int write(String bbsTitle, String userID, String bbsContent, String bbsImg) {
        String SQL="INSERT INTO bbs VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,getNext());
            pstmt.setString(2,bbsTitle);
            pstmt.setString(3,userID);
            pstmt.setString(4,getDate());
            pstmt.setString(5,bbsContent);
            pstmt.setInt(6,0);
            pstmt.setInt(7,1);
            pstmt.setString(8,bbsImg);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public ArrayList<Bbs> getList(int pageNumber) {
        String SQL="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
        ArrayList<Bbs>list=new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            rs=pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsHits(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsImg(rs.getString(8));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean nextPage(int pageNumber) {
        String SQL="SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";

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

    public Bbs getBbs(int bbsID) {
        String SQL="SELECT * FROM BBS WHERE bbsID = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, bbsID);
            rs=pstmt.executeQuery();
            if (rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsHits(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsImg(rs.getString(8));
                return bbs;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public int update(int bbsID, String bbsTitle, String bbsContent, String bbsImg) {
        String SQL="UPDATE BBS SET bbsTitle = ?,bbsContent = ?,bbsImg = ? WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,bbsTitle);
            pstmt.setString(2,bbsContent);
            pstmt.setString(3,bbsImg);
            pstmt.setInt(4,bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int delete(int bbsID) {
        String SQL="DELETE FROM BBS WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public int updateHits(int bbsID) {
        String SQL = "UPDATE BBS SET bbsHits = bbsHits + 1 WHERE bbsID = ?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1,bbsID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;//데이터베이스 오류
    }

    public ArrayList<Pair> getPost(String userID) {
        String SQL="SELECT bbsID, bbsTitle FROM BBS WHERE userID=? AND bbsAvailable = 1 ORDER BY bbsID DESC";
        ArrayList<Pair>list=new ArrayList<Pair>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1,userID);
            rs=pstmt.executeQuery();
            while (rs.next()) {
                Pair p = new Pair();
                p.setID(rs.getInt(1));
                p.setS(rs.getString(2));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Bbs> getSearchList(String searchCol, String searchContent) {
        ArrayList<Bbs> list = new ArrayList<Bbs>();
        String SQL="select * from bbs where "+searchCol.trim();
        try {
            SQL+=" like '%"+searchContent.trim()+"%' order by bbsID";

            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsHits(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsImg(rs.getString(8));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Bbs> getPopularBbs() {
        String SQL="select * from bbs where bbsID in (select * from (select bbsID from likey group by bbsID order by count(bbsID) desc limit 5) as t);";
        ArrayList<Bbs>list=new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs=pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsHits(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsImg(rs.getString(8));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public ArrayList<Bbs> getMostHitsBbs() {
        String SQL="select * from bbs order by bbsHits desc limit 5";
        ArrayList<Bbs>list=new ArrayList<Bbs>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(SQL);
            rs=pstmt.executeQuery();
            while (rs.next()) {
                Bbs bbs=new Bbs();
                bbs.setBbsID(rs.getInt(1));
                bbs.setBbsTitle(rs.getString(2));
                bbs.setUserID(rs.getString(3));
                bbs.setBbsDate(rs.getString(4));
                bbs.setBbsContent(rs.getString(5));
                bbs.setBbsHits(rs.getInt(6));
                bbs.setBbsAvailable(rs.getInt(7));
                bbs.setBbsImg(rs.getString(8));
                list.add(bbs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
