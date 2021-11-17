<%@page import="com.techblog.dao.CommentDao"%>
<%@page import="com.techblog.entities.User"%>
<%@page import="com.techblog.dao.LikeDao"%>
<%@page import="java.util.List"%>
<%@page import="com.techblog.entities.Post"%>
<%@page import="com.techblog.dao.PostDao"%>
<%@page import="com.techblog.helper.ConnectionProvider"%>
<div class="row">
    
    <%
        User uuu = (User)session.getAttribute("currentUser");
        //Thread.sleep(1000);
        PostDao d =new PostDao(ConnectionProvider.getConnection());
        int cid =  Integer.parseInt(request.getParameter("cid"));
        int start = 0;
        int end = 3;
        List<Post> p =null;
        if(cid==0){
            p = d.getAllPosts();
        }else{
            p=d.getPostByCatId(cid);//getting post according to  categories
        }
        if(p.size()==0){
            out.println("<h3 class='display-3 text-white text-center'>No Post in this Category</h3>");
            return;
        }
        int num = d.count_post();
        for(int i=0;i<p.size();i++){
            Post p1=p.get(i);
    %>      
    <div class="col-md-6 mt-2">
        <div class="card text-truncate">
            <img src="blog_pics/<%=p1.getpPic()%>" class="card-img-top" alt="blog_pics/default.jpg">
            <div class="card-body">
                <b><%=p1.getpTitle()%></b>
                <p><%=p1.getpContent()%></p>
            </div>
            <div class ="card-footer primary-background text-center">
                <%
                                LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                                boolean flag = ld.isLikedByUser(p1.getPid(),uuu.getId());
                                
//                                request.setAttribute("pid",p.getPid());
//                                request.setAttribute("uid",user.getId());
                                if(flag){
                            %>
                            
                            <a href="#!" class="btn btn-outline-light btn-sm" id= "anchor_<%=i%>" onclick="dodeleteLike1(<%=p1.getPid()%>,<%=uuu.getId()%>,this.id)">
                                <i id="thumb_<%=i%>" class="fa fa-thumbs-up">
                                    <span id="counter_<%=i%>">
                                        <%= ld.countLikeOnPost(p1.getPid()) %>
                                    </span>
                                </i>
                            </a>
                            <%}else{%>
                            <a href="#!" class="btn btn-outline-light btn-sm" id="anchor_<%=i%>" onclick="doLike1(<%=p1.getPid()%>,<%=uuu.getId()%>,this.id)">
                                <i id="thumb_<%=i%>" class="fa fa-thumbs-o-up">
                                    <span id="counter_<%=i%>">
                                        <%= ld.countLikeOnPost(p1.getPid())%>
                                    </span>
                                </i>
                            </a>
                            <%}%>
                <a href="show_blog_page.jsp?post_id=<%=p1.getPid()%>" class="btn btn-outline-light btn-sm">Read More...</a>
                <%CommentDao cd = new CommentDao(ConnectionProvider.getConnection());
                  int count = cd.totalComment(p1.getPid()); %>
                <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"><%=count%></i></a>
            </div>
        </div>
    </div>

    <%}%>
</div>