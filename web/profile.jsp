<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.entities.Message"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User)session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login_page.jsp");
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <!--CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                 clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 93%, 50% 100%, 15% 97%, 0 100%, 0 0);
            }
            .profile_pic {
                width: 200px;
                height: 200px;
                border-radius: 50%;
                overflow: hidden; 
            }
            body{
                background:url(img/background.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>
        <!--start of navbar-->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span>TechBlog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
              <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="#"><span class="fa fa-home"></span>&nbsp;Home<span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <span class="fa fa-check-square-o"></span>&nbsp;Categories
                  </a>
                  <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">Programming Language</a>
                    <a class="dropdown-item" href="#">Project Implementation</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Data Structure</a>
                  </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-book"></span>&nbsp;Contact</a>
                </li>                  
                <li class="nav-item">
                    <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-sticky-note-o"></span>&nbsp;DoPost</a>
                </li>                  
              </ul>     
              
              <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span>&nbsp;<%=user.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-plus"></span>&nbsp;Logout</a>
                </li>
              </ul>
            </div>
          </nav>
        <!--end of navbar-->
        
        <!--message box-->
        <%
          Message m = (Message)session.getAttribute("msg");
          if(m!=null){
        %>
         <div class="alert <%=m.getCssClass()%>" role="alert">
             <%=m.getContent() %>
         </div>
         <%
            session.removeAttribute("msg");
         }
         %>
         
         <!--main body of the page-->
         <main>
             <div class="container">
                 <div class="row mt-4">
                     <!--first column-->
                     <div class="col-md-4">
                         <!--list of categories-->
                         <div class="list-group">
                            <a href="#" id="0" onclick="getPosts(0,this)" class="c-link list-group-item list-group-item-action active" aria-current="true">
                              All Posts
                            </a>
                             <!--categories-->
                             <%
                               response.addHeader("Set-Cookie", "key=value; HttpOnly; SameSite=None;Secure");
                               PostDao d = new PostDao(ConnectionProvider.getConnection());
                               ArrayList<Category> list1 = d.getAllCategories();
                               List<Post> all_post = d.getAllPosts();
                               int total = all_post.size();
                               for(Category cc:list1){
                                   
                             %>
                             <a href="#" onclick="getPosts(<%=cc.getCid()%>,this)" class="c-link list-group-item list-group-item-action"><%=cc.getName()%></a>
                            <%}%>
                         </div>
                     </div>
                     <!--second column-->
                     <div class="col-md-8">
                         <!--posts of the categories-->
                         <div class="container text-center" id="loader">
                             <div class="fa fa-refresh fa-4x fa-spin"></div>
                             <h3 class="mt-2">Loading...</h3>
                         </div>
                         
                         <div class="container-fluid" id="post-container">
                             
                         </div>
                         <!--add pagination here-->
<!--                         <div class ="container color-for-pagination-btn" id="pagination">
                             
                         </div>-->
                     </div>
                 </div>
             </div>
         </main>
         <!--end of the main body-->

        <!--start of profile modal-->
        
        <!-- Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="primary-background text-white modal-header">
                <h5 class="modal-title" id="exampleModalLabel"> TechBlog </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  <div class="container text-center">
                      <img src ="pics/<%=user.getProfile()%>" class="profile_pic" alt="pics/default.jpg">
                       <h5 class="modal-title" id="exampleModalLabel"> <%= user.getName()%> </h5>
                       <!--DETAILS-->
                       <div id ="profile-details">
                            <table class="table">
                                 <tbody>
                                   <tr>
                                     <th scope="row"> ID :</th>
                                     <td><%= user.getId()%></td>
                                   </tr>
                                   <tr>
                                     <th scope="row"> Email :</th>
                                     <td><%= user.getEmail()%></td>
                                   </tr>
                                   <tr>
                                     <th scope="row"> Gender :</th>
                                     <td><%= user.getGender()%></td>
                                   </tr>
                                   <tr>
                                     <th scope="row"> Status :</th>
                                     <td><%= user.getAbout()%></td>
                                   </tr>
                                   <tr>
                                     <th scope="row"> Account Made On :</th>
                                     <td><%= user.getDateTime()%></td>
                                   </tr>
                                 </tbody>
                             </table>
                        </div>
                           
                        <!--profile-edit-->
                        <div id="profile-edit" style="display:none">
                            <h2 class="mt-2">Please Edit Carefully</h2>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                    <table class="table">
                                        <tr>
                                         <th scope="row"> ID :</th>
                                         <td><%= user.getId()%></td>
                                       </tr>
                                       <tr>
                                         <th scope="row"> Name :</th>
                                         <td><input type="text" class="form-control" name="user_name" value="<%= user.getName()%>"></td>
                                       </tr>
                                       <tr>
                                         <th scope="row"> Email :</th>
                                         <td><input type="email" class="form-control" name="user_email" value="<%= user.getEmail()%>"></td>
                                       </tr>
                                       <tr>
                                         <th scope="row"> Password :</th>
                                         <td><input type="password" class="form-control" name="user_password" value="<%= user.getPassword()%>"></td>
                                       </tr>
                                       <tr>
                                         <th scope="row"> Gender :</th>
                                         <td><%= user.getGender().toUpperCase()%></td>
                                       </tr>
                                       <tr>
                                         <th scope="row"> Status :</th>
                                         <td>
                                             <textarea rows="3" class="form-control" name="user_about"><%= user.getAbout()%></textarea>
                                         </td>
                                       </tr>
                                       <tr>
                                           <th scope="row">New Profile:</th>
                                           <td>
                                               <input type="file" name="image" class="form-control">
                                           </td>
                                       </tr>
                                    </table>
                                     <div class="container">
                                         <button type="submit" class=" btn border-button-color">Save</button>
                                     </div>
                            </form>
                        </div>
                                   
                  </div>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn secondary-background" data-dismiss="modal">Close</button>
                <button id="edit-profile-button" type="button" class="btn primary-background text-white">Edit</button>
              </div>
            </div>
          </div>
        </div>

        <!--end of profile modal-->
        
        <!--add post model-->
        <div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
          <div class="modal-dialog">
            <div class="modal-content">
              <div  class="primary-background text-white modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Provide the post details.</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span>
                </button>
              </div>
              <div class="modal-body">
                  
                  <form id="add-post-form" action ="AddPostServlet" method="post" enctype="multipart/form-data">
                      <div class="form-group">
                        <select class="form-control" name="cid">
                            <option selected disabled>---Select Category---</option>
                            <%
                                PostDao postd=new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list=postd.getAllCategories();
                                for(Category c:list){
                            %>
                            <option value="<%=c.getCid()%>"><%=c.getName()%></option>
                            <%
                                }
                            %>
                        </select>    
                      </div>
                      <div class ="form-group">
                          <input type="text" name="pTitle" placeholder="Enter Post Title" class="form-control">
                      </div>
                      <div class ="form-group">
                          <textarea name="pContent" type="text" placeholder="Enter your Content" style="height:200px;" class="form-control"></textarea>
                      </div>
                      <div class ="form-group">
                          <textarea name="pCode" type="text" placeholder="Enter your program if any" style="height:200px;" class="form-control"></textarea>
                      </div>
                      <div class ="form-group">
                          <label>Select your pic</label><br>
                          <input name="pic" type="file" placeholder="Enter your pic..">
                      </div>
                      <div class ="form-group">
                          <input name="pLink" type="text" placeholder="Enter Links if any..." class="form-control">
                      </div>
                      
                      <div class="container text-center">
                          <button type="submit" class="btn border-button-color">Post</button>
                      </div>
                  </form>
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
              </div>
            </div>
          </div>
        </div>
        
        <!--end of post modal-->
        
        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
