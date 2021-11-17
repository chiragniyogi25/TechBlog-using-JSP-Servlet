<%@page import="com.techblog.entities.Reply"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Comment"%>
<%@page import="com.techblog.dao.CommentDao"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.techblog.helper.DateFormat1"%>
<%@page import="com.techblog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.entities.User"%>
<%@page errorPage="error_page.jsp"%>
<%
    User user = (User)session.getAttribute("currentUser");
    if(user==null){
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId=Integer.parseInt(request.getParameter("post_id"));
//    String postTitle = request.getParameter("post_title");//<a href="show_blog_page.jsp?post_id=&post_title="
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p =d.getPostByPostId(postId);
    String link = p.getpLink();
    String[] links= link.trim().split(",");
    String date_str = DateFormat1.DateToString(p.getpDate());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%> || TechBlog</title>
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
            .post-title{
                font-weight:100;
                font-height:30px;
            }
            .post-content{
                font-weight:100;
                font-size:25;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user-info{
                font-size:20px;
                font-weight:300px;
            }
            .row-user{
                border:1px solid #e2e2e2;
                padding-top: 15px;
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
                    <a class="nav-link" href="profile.jsp"><span class="fa fa-home"></span>&nbsp;Home<span class="sr-only">(current)</span></a>
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
        
        <!--main content of body-->
        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-center text-white">
                            <h4 class="post-title"><%=p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img src ="blog_pics/<%=p.getpPic()%>" class="profile_pic my-2" alt="blog_pics/default.jpg">
                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    
                                    <%
                                        UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                    %>
                                    <p class="post-user-info"><a href="#!"><%=ud.getUserByUserId(p.getUserId()).getName()%> </a>has posted on :</p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%=DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>
                            <div>
                               <p class="post-content"><%=p.getpContent()%></p> 
                            </div>
                            <div class="post-code">
                                <label><h4>Sample Code</h4></label>
                                <pre><%=p.getpCode()%></pre>
                            </div>
                            <div>
                                <label><h4>Check out some other links for the topic</h4></label>                                
                                <br>
                                <%
                                    for(int i=0;i<links.length;i++){
                                %>
                                <a href="<%=links[i]%>"><%=links[i]%></a>
                                <br>
                                <%}%>
                            </div>
                        </div>
                        <div class="card-footer primary-background">
                            <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                boolean flag = ld.isLikedByUser(p.getPid(),user.getId());
                                
//                                request.setAttribute("pid",p.getPid());
//                                request.setAttribute("uid",user.getId());
                                if(flag){
                            %>
                            <a id="anchor_tag" href="#!" onclick="dodeleteLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm">
                                <i id="thumbs_id" class="fa fa-thumbs-up">
                                    <span class="like-counter">
                                        <%= ld.countLikeOnPost(p.getPid()) %>
                                    </span>
                                </i>
                            </a>
                            <%}else{%>
                            <a id="anchor_tag" href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-sm">
                                <i id="thumbs_id" class="fa fa-thumbs-o-up">
                                    <span class="like-counter">
                                        <%= ld.countLikeOnPost(p.getPid()) %>
                                    </span>
                                </i>
                            </a>
                            <%}%>
                            <%
                                    CommentDao comment_d = new CommentDao(ConnectionProvider.getConnection());
                                    int count = comment_d.totalComment(p.getPid());
                            %>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"> <%=count%> </i></a>
                        </div>
                        
                            <div class="card-footer">
                                <div class="comment-section">
                                                                            
                                    <form id="comment-form" class="mb-3" action="AddComment" method="post">
                                        
                                        <div class="form-group comments mb-3">
                                          <img class="comment_img mr-2" src="pics/<%=user.getProfile()%>">
                                             <textarea 
                                                 name="adding_comment"
                                                 class="form-control"
                                                 id="commentsample"
                                                 rows="3" 
                                                 cols="5"
                                                 placeholder="Add a public Comment"></textarea>
                                             
                                        </div>     
                                        <div class="form-group">
                                            <input name="post_id" type="hidden" class="form-control" id="exp_post_id" value="<%=postId%>" >
                                        </div>
                                        <button type="submit" 
                                                id="btn1" 
                                                class="btn primary-background text-white float-right mr-4 comment_btn">
                                                    Comment
                                        </button>
                                        <button type="button" 
                                                id="btn2" 
                                                class="btn border-button-color comment_btn float-right mr-4">Close</button>
                                    </form>
                                             
                                </div>
                                
                            </div>
                            <div id ="comment_count" class="load_comments card-footer">
                                <h4><%=count%> Comments</h4>
                            </div>
                            <div id="commenting">
                                <%
                                    List<Comment> com_list= comment_d.getComment(postId);
                                    for(int i=0;i<com_list.size();i++){
                                        Comment c = com_list.get(i);
                                        int comment_id = c.getComment_id();
                                        int user_id = c.getUser_id();
                                        String comment_str = c.getComment();
                                        Timestamp c_time = c.getcDate();
                                        User u1 = ud.getUserByUserId(user_id);
                                        String u_name = u1.getName();
                                        String c_date = DateFormat1.DateToString(c_time);
                                        String u_image_name = u1.getProfile();
                                %>
                                <div class="container show_comments">
                                    <div class="com_head my-3">
                                        <img class="comment_img mr-2" src="pics/<%=u_image_name%>">
                                        <h4 class="com_name" id="<%=comment_id%>"><%=u_name%></h4>.
                                        <small class="com_date">Posted on <%=c_date%></small>
                                    </div>
                                    <div class ="com_body">
                                        <p><%=comment_str%></p>
                                    </div>
                                    <span id="reply_<%=comment_id%>" onclick="show_div(this.id)" class="btn reply_button">
                                         <i class="fa fa-reply"></i>
                                    </span>
                                    <br>
                                    
                                    <form id="reply_div<%=comment_id%>" class="forms comment_btn input-group mb-3" action="AddReply" method="post">
                                            <img class="comment_img mr-2" src="pics/<%=user.getProfile()%>">
                                            <input type="text"
                                                name = "reply_comment_<%=comment_id%>"
                                                placeholder="Enter Replies"
                                                id="rep_c_<%=comment_id%>"
                                                class="form-control">
                                            
                                            <input type="hidden"
                                                   name="r_post_<%=comment_id%>"
                                                   id="r_post_id_<%=comment_id%>"
                                                   value="<%=p.getPid()%>"
                                                   >
                                            <input type="hidden"
                                                   name="r_comm_<%=comment_id%>"
                                                   id="r_comm_id_<%=comment_id%>"
                                                   value="<%=comment_id%>"
                                                   >
                                            <input type="hidden"
                                                   name="r_user_<%=comment_id%>"
                                                   id="r_user_id_<%=comment_id%>"
                                                   value="<%=user.getId()%>"
                                                   >
                                            <input type="hidden"
                                                   name="index" value="<%=comment_id%>"
                                                   >
                                            
                                            <button id ="rep_btn_<%=comment_id%>" class="btn btn-secondary" type="submit">Reply</button>
                                    </form>
                                    
                                    <%List<Reply> reply_list= comment_d.getReplyComment(comment_id);%>
                                    <%if(reply_list.size()>0){%>
                                        <button id="reply_but_<%=comment_id%>" onclick = "show_replies_div(this.id)" class="btn btn-secondary" type="button"
                                                style="position:relative;left:42px">
                                            <%=reply_list.size()%> Replies
                                        </button>
                                    <%}%>
                                    
                                    <%
                                        for(int j=0;j<reply_list.size();j++){
                                            Reply r = reply_list.get(j);
                                            int r_id = r.getReply_id();
                                            int r_post_id = r.getR_post_id();
                                            int r_comment_id = r.getR_comment_id();
                                            int r_uid = r.getR_user_id();
                                            String r_comment = r.getR_comment();
                                            Timestamp r_date = r.getrDate(); 
                                            u1 = ud.getUserByUserId(r_uid);
                                            String rep_name_img = u1.getProfile();
                                            String user_name=u1.getName();
                                    %>
                                    <div id="show_rep<%=comment_id%><%=j+1%>" class="show_replies<%=comment_id%><%=j+1%> comment_btn">
                                        <div class="rep_head my-3">
                                            <img class="rep_comment_img mr-2" src="pics/<%=rep_name_img%>">
                                            <h4 class="rep_name" id="rep_<%=comment_id%><%=j%>"><%=user_name%></h4><b>.</b>
                                            <small class="rep_date">Posted on <%=r_date%></small>
                                        </div>
                                        <div class ="rep_body">
                                            <p><%=r_comment%></p>
                                        </div>
                                        <span id="reply_<%=comment_id%><%=j%>" onclick="show_div1(this.id,'<%=user_name%>')" class="btn reply_button">
                                            <i class="fa fa-reply"></i>
                                       </span>
                                       
                                       <form id="reply_div1<%=comment_id%><%=j%>" class="forms1 comment_btn input-group mb-3" action="AddSubReply" method="post">
                                                <img class="rep_comment_img mr-2" src="pics/<%=user.getProfile()%>">
                                                <input type="text"
                                                    name = "sub_reply_comment_<%=comment_id%><%=j%>"
                                                    placeholder="Enter Replies"
                                                    id="sub_rep_c_<%=comment_id%><%=j%>"
                                                    class="form-control col-sm-8">

                                                <input type="hidden"
                                                       name="sub_r_post_<%=comment_id%><%=j%>"
                                                       id="sub_r_post_id_<%=comment_id%><%=j%>"
                                                       value="<%=p.getPid()%>"
                                                       >
                                                <input type="hidden"
                                                       name="main_comment_id_<%=comment_id%><%=j%>"
                                                       id ="main_comment_<%=comment_id%><%=j%>"
                                                       value="<%=comment_id%>">
                                                <input type="hidden"
                                                   name="sub_r_user_id_<%=comment_id%><%=j%>"
                                                   id="sub_r_user_<%=comment_id%><%=j%>"
                                                   value="<%=user.getId()%>"
                                                   >
                                                <input type="hidden"
                                                       name="index" value="<%=comment_id%><%=j%>"
                                                       >
                                                <button id ="rep_btn_<%=comment_id%><%=j%>" class="btn btn-secondary ml-2" type="submit">Reply</button>
                                        </form>
                                    </div>
                                    <%}%>
                                </div>
                                    <hr>
                                <%}%>
                            </div>
                    </div>
                </div>
            </div>   
        </div>                
        <!--end of main content of body-->
        
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
        
    </body>
    <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        
</html>
