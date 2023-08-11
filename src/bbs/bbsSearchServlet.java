package bbs;

import comment.CommentDAO;
import user.User;
import user.UserDAO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/bbsSearchServlet")
public class bbsSearchServlet extends HttpServlet {
    private static final long serialVersionUID=1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String searchSub = request.getParameter("searchSub");
        String searchContent = request.getParameter("searchContent");
        response.getWriter().write(getJSON(searchSub, searchContent));
    }

    public String getJSON(String searchSub, String searchContent) {
        if(searchContent==null)
            searchContent="";
        if(searchSub==null)
            searchSub = "";
        StringBuffer result = new StringBuffer("");
        result.append("{\"result\":[");
        BbsDAO bbsDAO=new BbsDAO();
        ArrayList<Bbs> userList = bbsDAO.getSearchList(searchSub, searchContent);

        CommentDAO commentDAO=new CommentDAO();
        for (int i = 0; i < userList.size(); i++) {
            result.append("[{\"value\": \"" + userList.get(i).getBbsID()+"\"},");
            result.append("{\"value\": \"" + userList.get(i).getBbsTitle()+"\"},");
            result.append("{\"value\": \"" + userList.get(i).getUserID()+"\"},");
            result.append("{\"value\": \"" + userList.get(i).getBbsDate()+"\"},");
            result.append("{\"value\": \"" + userList.get(i).getBbsHits()+"\"},");
            result.append("{\"value\": \"" + commentDAO.countComment(userList.get(i).getBbsID())+"\"}],");
        }
        result.append("]}");
        return result.toString();
    }
}
