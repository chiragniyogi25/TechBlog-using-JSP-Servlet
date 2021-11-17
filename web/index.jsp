<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Main Page</title>
        <!--CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                 clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 93%, 50% 100%, 15% 97%, 0 100%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--navbar-->
        <%@include file="navbar.jsp"%>
        
        <!--banner-->
        <div class ="container-fluid p-0 m-0 banner-background">
            <div class ="jumbotron primary-background text-white">
                <div class ="container">
                    <h3 class="display-3">Welcome , Geeks</h3>
                    <p>This is my Programming Techblog</p>
                    <p>Here you can share knowledge related to Programming.Together we all can make a better community and help each other by sharing our knowledge and also implement this knowledge for solving various problems and indirectly helping for betterment of society</p>
                    
                    <a class ="btn btn-outline-light btn-lg"href="register_page.jsp"><span class="fa fa-user-plus"></span>&nbsp;Start ! Its free</a>
                    <a href="login_page.jsp" class ="btn btn-outline-light btn-lg"><span class="fa fa-user-circle fa-spin"></span>&nbsp;Login</a>
                </div>
            </div>
        </div>
        
        
        <!--cards-->
        <div class="container">
            
            <div class="row">
             <% //PostDao pdao = new PostDao(ConnectionProvider.getConnection());
                ArrayList<Category> cat_list = new ArrayList<>();
                cat_list = pdao.getAllCategories();
                for(int i=0;i<cat_list.size();i++){
                    Category cat = (Category)cat_list.get(i);

                %>
                <div class ="col-md-4">
                      <div class="card">
                        <div class="card-body">
                          <h5 class="card-title"><%=cat.getName()%></h5>
                          <p class="card-text"><%=cat.getDescription()%></p>
                        </div>
                      </div>
                </div>
            <%}%>
            </div>
        </div>
        
        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
