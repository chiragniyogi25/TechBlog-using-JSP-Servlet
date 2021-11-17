package com.techblog.servlets;

import com.techblog.dao.CommentDao;
import com.techblog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
public class AddReply extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            CommentDao c_dao = new CommentDao(ConnectionProvider.getConnection());
            int count = c_dao.getCommentCount();
            String index = request.getParameter("index");
            String reply_comment = request.getParameter("reply_comment_"+index).trim();
            int user_id = Integer.parseInt(request.getParameter("r_user_"+index));
            int post_id = Integer.parseInt(request.getParameter("r_post_"+index));
            int comment_id = Integer.parseInt(request.getParameter("r_comm_"+index));
            
            CommentDao dao = new CommentDao(ConnectionProvider.getConnection());
            if(dao.insertReply(post_id, comment_id, user_id, reply_comment)){
                out.println("done");
            }else{
                out.println("error while replying");
            }
                        
//            out.println(reply_comment);
//            out.println(user_id);
//            out.println(post_id);
//            out.println(comment_id);
//            out.println(index);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
