package com.techblog.servlets;

import com.techblog.dao.UserDao;
import com.techblog.entities.User;
import com.techblog.helper.ConnectionProvider;
import com.techblog.helper.Helper;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig //this annotation is required to let the compiler know that this servlet receives
//form which has documents as well as text data
public class RegisterServlet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {            
            //fetch all form data
            String check=request.getParameter("check");
            if(check==null){
                out.println("please check terms and conditions");
            }else{
                //rest of the data needs to be retrieved
                String name=request.getParameter("user_name");
                String email=request.getParameter("user_email");
                String password=request.getParameter("user_password");
                String gender=request.getParameter("gender");
                String about=request.getParameter("about");
                String profile="";
                //taking image input from client
                Part part =request.getPart("image");
                String filename = part.getSubmittedFileName();
                
                String path="D:\\JSP Projects\\TechBlog\\web\\pics\\"+filename;
//                String path=request.getRealPath("/pics"+File.separator+filename);

                InputStream is = part.getInputStream();
                if(filename!=""){
                    boolean flag = Helper.saveFile(is, path);
                    if(flag){
                        profile = filename;
                    }else{
                        profile = "default.png";
                    }
                }else{
                     profile = "default.png";
                }
                //create a user object and set all data to that object
                User user = new User(name,email,password,gender,about,profile);
                
                //create a Userdao object
                UserDao dao= new UserDao(ConnectionProvider.getConnection());
                if(dao.saveUser(user)){
                    //if true then saved
                    out.println("done");
                }else{
                    out.println("Email Id already registered....  Please register with other Email_id");
                }

            }
        }
    }
    public boolean uploadImage(InputStream is,String path){
        boolean f= false;
        try{
            byte[] data = new byte[is.available()];
            is.read(data);
            FileOutputStream fos = new FileOutputStream(path);
            fos.write(data);
//            fos.flush();
            fos.close();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
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
