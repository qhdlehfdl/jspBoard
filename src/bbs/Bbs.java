package bbs;

public class Bbs {
    private int bbsID;
    private String bbsTitle;
    private String userID;
    private String bbsDate;
    private String bbsContent;
    private int bbsHits;
    private int bbsAvailable;
    private String bbsImg;


    public int getBbsID() {
        return bbsID;
    }

    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }

    public String getBbsTitle() {
        return bbsTitle;
    }

    public void setBbsTitle(String bbsTitle) {
        this.bbsTitle = bbsTitle;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getBbsDate() {
        return bbsDate;
    }

    public void setBbsDate(String bbsDate) {
        this.bbsDate = bbsDate;
    }

    public String getBbsContent() {
        return bbsContent;
    }

    public void setBbsContent(String bbsContent) {
        this.bbsContent = bbsContent;
    }

    public int getBbsAvailable() {
        return bbsAvailable;
    }

    public void setBbsAvailable(int bbsAvailable) {
        this.bbsAvailable = bbsAvailable;
    }

    public int getBbsHits() {
        return bbsHits;
    }

    public void setBbsHits(int bbsHits) {
        this.bbsHits = bbsHits;
    }

    public String getBbsImg() {
        return bbsImg;
    }

    public void setBbsImg(String bbsImg) {
        this.bbsImg = bbsImg;
    }
}
