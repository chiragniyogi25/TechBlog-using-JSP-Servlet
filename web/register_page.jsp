<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Page</title>
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
        
        <%@include file="navbar.jsp" %>
        <main class="primary-background p-5 banner-background">
            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header text-white text-center primary-background">
                            <span class="fa fa-user-circle fa-3x"></span>
                            <br>
                            Register Here
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="post" enctype="multipart/form-data">
                                
                                <div class="form-group">
                                  <label for="user_name">User Name</label>
                                  <input name="user_name" type="text" class="form-control" id="user_name" aria-describedby="name" placeholder="Enter name">
                                </div>
                                
                                <div class="form-group">
                                  <label for="exampleInputEmail1">Email address</label>
                                  <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" placeholder="Enter Email">
                                </div>
                                
                                <div class="form-group">
                                  <label for="exampleInputPassword1">Password</label>
                                  <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Enter Password">
                                </div>
                                <div class="form-group">    
                                  <label for="gender">Select Gender</label>
                                  <br>
                                  <input type="radio" id="gender" name="gender" value="male">&nbsp;Male
                                  <input type="radio" id="gender" name="gender" value="female">&nbsp;Female
                                </div>
                                
                                <div class="form-group">
                                    <div class="custom-file">
                                        <input type="file" name ="image" class="custom-file-input" id="customFile">
                                        <label class="custom-file-label" for="customFile">Choose Profile Picture</label>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <textarea name="about" class="form-control" id="" rows="5" placeholder="Enter something about yourself"></textarea>
                                </div>
                                <div class="form-check">
                                  <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                  <label class="form-check-label" for="exampleCheck1">Agree Terms and Conditions</label>
                                </div>
                                <br>   
                                <div class="container text-center" id="loader" style="display:none;">
                                    <span class="fa fa-refresh fa-spin fa-4"></span>
                                    <h4>Please wait....</h4>
                                    <br>
                                </div>

                                <button id="submit-btn" type="submit" class="btn primary-background text-white">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
        crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
    </body>
</html>
