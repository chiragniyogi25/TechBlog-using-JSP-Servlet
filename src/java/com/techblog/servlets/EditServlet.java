/*
 * Copyright 2020 ChiragNiyogi
 */
package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.Message;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            
            //fetch all the data
            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imagename = part.getSubmittedFileName();
            
            //get the user from the session
            HttpSession s = request.getSession();
            User user = (User)s.getAttribute("currentUser");
            
            //getting path of the old image to delete it
            String old_imagename = user.getProfile();
            String old_imagepath="D:\\JSP Projects\\TechBlog\\web\\pics\\"+old_imagename;
            
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            user.setProfile(imagename);
            
            //update Database
            UserDao userDao= new UserDao(ConnectionProvider.getConnection());
            boolean ans=userDao.updateUser(user);
            if(ans){
                out.println("Updated to DB");
                String path="D:\\JSP Projects\\TechBlog\\web\\pics\\"+imagename;
                
                //deleting the old profile image
                if(!old_imagename.equals("default.png")){
                    Helper.deleteFile(old_imagepath);
                }
                
                if(Helper.saveFile(part.getInputStream(), path)){
                    Message msg = new Message("Profile Details updated...","success","alert-success");
                    s.setAttribute("msg",msg);
                }else{
                    Message msg = new Message("Image Not updated...","error","alert-danger");
                    s.setAttribute("msg",msg);
                }

            }else{
                Message msg = new Message("Something went wrong...","error","alert-danger");
                s.setAttribute("msg",msg);                
            }
            response.sendRedirect("profile.jsp");
            out.println("</body>");
            out.println("</html>");
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
