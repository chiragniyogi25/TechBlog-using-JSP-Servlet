package com.techblog.servlets;

import com.techblog.dao.CommentDao;
import com.techblog.entities.Comment;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddComment extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session=request.getSession();  
            /* TODO output your page here. You may use following sample code. */
            User user = (User)session.getAttribute("currentUser");
            int user_id = user.getId();
            int post_id=Integer.parseInt(request.getParameter("post_id"));
            String comment_str = request.getParameter("adding_comment").trim();
//            out.println(postId);
//            out.println(user_id);
//            out.println(post_id);
//            out.println(comment_str);
            Comment comment = new Comment(user_id, comment_str, post_id);
            CommentDao comment_dao = new CommentDao(ConnectionProvider.getConnection());
            if(comment_dao.insertComment(post_id, user_id, comment_str)){
                out.println("done");
            }else{
                out.println("Something went wrong!!! Comment again");
            }
            
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
