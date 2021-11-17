package com.techblog.dao;
import com.techblog.entities.Category;
import com.techblog.entities.Post;
import com.techblog.helper.ImageAvailableChecker;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list=new ArrayList<>();
        try{
            String q = "Select * from categories";
            Statement st = this.con.createStatement();
            ResultSet set =st.executeQuery(q);
            while(set.next()){
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");
                Category c = new Category(cid,name,description);
                list.add(c);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    //saving the post in db
    public boolean savePost(Post p){
        boolean f = false;
        try{
            String q = "insert into posts(pTitle,pContent,pCode,pPic,pLink,catId,userId) values(?,?,?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setString(1,p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setString(5, p.getpLink());
            pstmt.setInt(6, p.getCatId());
            pstmt.setInt(7, p.getUserId());
            pstmt.executeUpdate();
            f=true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    //get all the post
    public List<Post> getAllPosts(){
        List<Post> list = new ArrayList<>();
        //fetch all the post
        try{
            String q = "Select * from posts Order by pDate DESC";
            PreparedStatement pstmt = this.con.prepareStatement(q);
            ResultSet set = pstmt.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic  = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                String pLink = set.getString("pLink");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                pPic = ImageAvailableChecker.Image_available(pPic);
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, pLink, catId, userId);
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    //oagination data
    public List<Post> getAllPostsPagination(int start,int end){
        List<Post> list = new ArrayList<>();
        //fetch all the post
        try{
            String q = "Select * from posts Order by pDate DESC limit ?,?";
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1,start);
            pstmt.setInt(2,end);
            ResultSet set = pstmt.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic  = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                String pLink = set.getString("pLink");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");
                pPic = ImageAvailableChecker.Image_available(pPic);
                
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, pLink, catId, userId);
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    }
    
    public List<Post> getPostByCatId(int catId){
//        fetching all the post based on category that is selected
        List<Post> list = new ArrayList<>();
        //fetch all the post
        try{
            String q = "Select * from posts where catId=?";
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, catId);
            ResultSet set = pstmt.executeQuery();
            while(set.next()){
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic  = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                String pLink = set.getString("pLink");
                int userId = set.getInt("userId");
                pPic = ImageAvailableChecker.Image_available(pPic);
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, pDate, pLink, catId, userId);
                list.add(post);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return list;
    
    }
    public Post getPostByPostId(int postId){
        Post post = null;
        //fetch all the post
        try{
            String q = "Select * from posts where pid=?";
            PreparedStatement pstmt = this.con.prepareStatement(q);
            pstmt.setInt(1, postId);
            ResultSet set = pstmt.executeQuery();
            if(set.next()){
                int catId = set.getInt("catId");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic  = set.getString("pPic");
                Timestamp pDate = set.getTimestamp("pDate");
                String pLink = set.getString("pLink");
                int userId = set.getInt("userId");
                pPic = ImageAvailableChecker.Image_available(pPic);
                post = new Post(postId, pTitle, pContent, pCode, pPic, pDate, pLink, catId, userId);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return post;
    }
    
    public int count_post(){
        int count=0;
        String q = "Select count(*) from posts";
        try{
            Statement s = this.con.createStatement();
            ResultSet  set= s.executeQuery(q);
            if(set.next()){
                count=set.getInt(1);
            }
        }catch(Exception e){
            e.printStackTrace();
        }
        return count;
    }
}
