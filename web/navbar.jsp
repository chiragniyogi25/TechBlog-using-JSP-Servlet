<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<%@page import="com.techblog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
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
                            <%
                          PostDao pdao = new PostDao(ConnectionProvider.getConnection());
                          ArrayList<Category> cat_list_nav = new ArrayList<>();
                          cat_list_nav = pdao.getAllCategories();
                          for(int i=0;i<cat_list_nav.size();i++){
                              Category ccc = cat_list_nav.get(i);                    
                      %>
                    <a class="dropdown-item" href="#"><%=ccc.getName()%></a>
                        <%}%>
                  </div>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-book"></span>&nbsp;Contact</a>
                </li>              
                <li class="nav-item">
                    <a class="nav-link" href="login_page.jsp"><span class="fa fa-user-circle"></span>&nbsp;Login</a>
                </li>   
                <li class="nav-item">
                    <a class="nav-link" href="register_page.jsp"><span class="fa fa-user-plus"></span>&nbsp;Sign up</a>
                </li> 
              </ul>     
              <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-outline-light my-2 my-sm-0" type="submit"><span class="fa fa-search"></span>&nbsp;Search</button>
              </form>
            </div>
          </nav>