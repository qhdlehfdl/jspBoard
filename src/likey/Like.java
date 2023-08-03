package likey;

import java.sql.PreparedStatement;

public class Like {
    String userID;
    int bbsID;
    String likeyType;

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public int getBbsID() {
        return bbsID;
    }

    public void setBbsID(int bbsID) {
        this.bbsID = bbsID;
    }

    public String getLikeyType() {
        return likeyType;
    }

    public void setLikeyType(String likeyType) {
        this.likeyType = likeyType;
    }
}
