package com.techblog.helper;

import java.io.File;

public class ImageAvailableChecker {
    public static String Image_available(String pPic){        
        File f = new File("D:\\JSP Projects\\TechBlog\\web\\blog_pics\\"+pPic);
        if(!f.exists()){
            pPic = "default.jpg";
        }
        return pPic;
    }
}
