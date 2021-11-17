$(document).ready(function(){
    //ajax call while registering user name
    $("#reg-form").on('submit',function(event){
    event.preventDefault();//this will help preventing the page to go to the servlet
    //it will help staying in this page
    
    let form = new FormData(this);//all the data of the form is stored in this
    //since id ='#reg-form' is referenced to the form
                    
    $("#submit-btn").hide();
    $("#loader").show();
    ////sending the form to the RegisterServlet
    $.ajax({
        url:"RegisterServlet",
        type:'POST',
        data:form,
        success:function(data,textStatus,jqXHR){
            $("#submit-btn").show();
            $("#loader").hide();
            if(data.trim()==='done'){
                swal("Registered Successfully..we are redirecting to Login Page")
                .then((value) => {
                    window.location="login_page.jsp";//redirecting to login page after registering
                });
            }else{
                swal(data);
            }
        },
        error:function(jqXHR,textStatus,errorThrown){
//                          console.log(textStatus);
            $("#submit-btn").show();
            $("#loader").hide();
            swal("Something went wrong...try again");
        },
        processData:false,
        contentType:false
        });
                    
    });
    
    //toggle between edit and back button
    let editStatus = false;
    $('#edit-profile-button').click(function(){
        //Toggle
    if(editStatus==false){
        $('#profile-details').hide();
        $('#profile-edit').show();
        editStatus=true;
        $(this).text("Back");
    }else{
        $('#profile-details').show();
        $('#profile-edit').hide();
        editStatus=false;
        $(this).text("Edit");
    }
   });    
   
//   now add post js
    $('#add-post-form').on('submit',function(e){
        //this code gets called when post form gets submitted
        e.preventDefault();
        console.log("Clicked");
        let form = new FormData(this);
        //now requesting the server
        $.ajax({
            url:"AddPostServlet",
            type:'POST',
            data:form,
            success:function(data,textStatus,jqXHR){
                //success...
                if(data.trim()==="done"){
                    swal("Good job!", "Content Posted Successfully!", "success");
                }else{
                    swal("Error!", "Something went wrong try again...!", "error");
                }
            },
            error:function(jqXHR,textStatus,errorThrown){
                //error
                swal("Error!", "Something went wrong try again...!", "error");
            },
            processData:false,
            contentType:false
        })
    });
    
    //Comment

    $('#commentsample').on('click',function(){
            $('.comment_btn').show();
        });
    $("#comment-form").on('submit',function(event){
        event.preventDefault();
        $('.comment_btn').hide();
//        var form = new FormData(this);
        let form = $(this).serialize();
        $('#commentsample').val("");
        $.ajax({
           url:"AddComment",
           type:'POST',
           data:form,
           success:function(data,textStatus,jqXHR){
               if(data.trim()==='done'){
                   console.log(data);
               }else{
                   console.log("Error");
               }
            },
           error:function(jqXHR,textStatus,errorThrown){
               console.log(errorThrown);
           },
        });
        
    });
        $('#btn2').on('click',function(){
        $('.comment_btn').hide();
    });
});

    function getPosts(catId,temp){
        $("#loader").show();
        $("#post-container").hide();
        $(".c-link").removeClass('active');
        const d = {
            cid:catId,
        }
    //    loading post using ajax
      $.ajax({
          url:"load_posts.jsp",
          crossDomain:true,
          data:d,//sending category Id to load_posts.jsp
          success:function (data,textStatus,jqXHR) {
              $('#loader').hide();
              $("#post-container").show();
              $('#post-container').html(data);
              $(temp).addClass('active');
       }
    })
}
    //if there is no Category selected we  will pass zero resulting in all categories  display
    let allPostRef = $('.c-link')[0];//get the first element in the array
    getPosts(0,allPostRef,0,3);

    function doLike(pid,uid){
        console.log(pid,uid);
        const d = {
            uid: uid,
            pid: pid,
            operation:'like'
        }
        $.ajax({
            url:"LikeServlet",
            data:d,
            success:function(data,textStatus,jqXHR){
//                console.log(data);
                if(data.trim()==='true'){
                    let c=$(".like-counter").html();
                    c++;
                    $(".like-counter").html(c);//updating the likes instantly after clicking like button
                    $("#anchor_tag").removeAttr("onclick");
                    $("#anchor_tag").attr("onclick","dodeleteLike("+pid+","+uid+")");
                    $("#thumbs_id").addClass("fa-thumbs-up");
                    $("#thumbs_id").removeClass("fa-thumbs-o-up");
                }
            },
            error:function(jqXHR,textStatus,errorThrown){
                console.log(data);
               
            }
        })
    }
    
    function dodeleteLike(pid,uid){
        const d = {
            uid: uid,
            pid: pid,
            operation:'delete'
        }
        $.ajax({
            url:"LikeServlet",
            data:d,
            success:function(data,textStatus,jqXHR){
//                console.log(data);
                if(data.trim()==='true'){
                    let c=$(".like-counter").html();
                    c--;
                    $(".like-counter").html(c);//updating the likes instantly after clicking like button
                    $("#anchor_tag").removeAttr("onclick");
                    $("#anchor_tag").attr("onclick","doLike("+pid+","+uid+")");
                    $("#thumbs_id").removeClass("fa-thumbs-up");
                    $("#thumbs_id").addClass("fa-thumbs-o-up");
                }
            },
            error:function(jqXHR,textStatus,errorThrown){
                console.log(data);
               
            }
        })
    }
    
    function doLike1(pid,uid,id){
        console.log(pid,uid);
        const d = {
            uid: uid,
            pid: pid,
//            id:id,
            operation:'like'
        }
        $.ajax({
            url:"LikeServlet",
            data:d,
            success:function(data,textStatus,jqXHR){
//                console.log(data);
                if(data.trim()==='true'){
                    id="#"+id;
                    let last_char = id.charAt(id.length-1);
                    let thumbs_sel = "#thumb_"+last_char;
                    let counter_sel = "#counter_"+last_char;
                   
                    let c=$(counter_sel).html();
                    c++;
                    $(counter_sel).html(c);//updating the likes instantly after clicking like button
                    $(id).removeAttr("onclick");
                    $(id).attr("onclick","dodeleteLike("+pid+","+uid+")");
                    $(thumbs_sel).addClass("fa-thumbs-up");
                    $(thumbs_sel).removeClass("fa-thumbs-o-up");
                }
            },
            error:function(jqXHR,textStatus,errorThrown){
                console.log(data);
               
            }
        })
    }
    
    function dodeleteLike1(pid,uid,id){
        const d = {
            uid: uid,
            pid: pid,
//            id:id,
            operation:'delete'
        }
        $.ajax({
            url:"LikeServlet",
            data:d,
            success:function(data,textStatus,jqXHR){
//                console.log(data);
                if(data.trim()==='true'){
                    id="#"+id;
                    let last_char = id.charAt(id.length-1);
                    let thumbs_sel = "#thumb_"+last_char;
                    let counter_sel = "#counter_"+last_char;
                    
                    let c=$(counter_sel).html();
                    c--;
                    $(counter_sel).html(c);//updating the likes instantly after clicking like button
                    $(id).removeAttr("onclick");
                    $(id).attr("onclick","doLike("+pid+","+uid+")");
                    $(thumbs_sel).removeClass("fa-thumbs-up");
                    $(thumbs_sel).addClass("fa-thumbs-o-up");
                }
            },
            error:function(jqXHR,textStatus,errorThrown){
                console.log(data);
               
            }
        })
    }
    function mo_ov_click(r_id){
        r_id="#"+r_id;
        $(r_id).mouseover(function(){
            $('.reply_button').addClass("primary-background");
            $('.reply_button').addClass("text_colour");
        });
    }
    function mo_ou_click(r_id){
        r_id="#"+r_id;
        
        $(r_id).mouseout(function(){
           $('.reply_button').removeClass("primary-background");
           $('.reply_button').removeClass("text_colour");
        });
    }
    function show_div(id){
        let container = "#reply_div"+id.charAt(id.length-1);
        let flag = $(container).hasClass("comment_btn");
        if(flag){
           $(container).removeClass("comment_btn"); 
        }else{
           $(container).addClass("comment_btn");             
        }
    }
    function show_div1(id,user_name){
        let container = "#reply_div1"+id.charAt(id.length-2)+id.charAt(id.length-1);
        let flag = $(container).hasClass("comment_btn");
        if(flag){
            $(container).removeClass("comment_btn");
            let username = "@"+user_name+" "; 
            $('#sub_rep_c_'+id.charAt(id.length-2)+id.charAt(id.length-1)).val(username);
        }else{
            $(container).addClass("comment_btn");
        }
    }
    function show_replies_div(id){
        let index = id.charAt(id.length-1);
        let selector="show_replies"+index+"*";
        let flag = $(`[id^=show_rep${index}]`).hasClass("comment_btn");
        if(flag){
            $(`[id^=show_rep${index}]`).removeClass("comment_btn");
        }else{
            $(`[id^=show_rep${index}]`).addClass("comment_btn");            
        }
    }
    $('.forms').submit(function(e){
       e.preventDefault();
       console.log(this.id,typeof this.id);
       let container = "#"+this.id;
        $(container).addClass("comment_btn");
       let form = $(this).serialize();
       console.log(form);
       $.ajax({
           url:'AddReply',
           data:form,
           type:'POST',
           success:function(data){
               if(data.trim()==='done'){
                    console.log(data);
               }else{
                   console.log("error");
               }
           },
           error:function(errorThrown){
               console.log("Error");
           }
       })
    });
    
    $('.forms1').submit(function(e){
        e.preventDefault();
        let container = "#"+this.id;
        $(container).addClass('comment_btn');
         let form = $(this).serialize();
       $.ajax({
           url:'AddSubReply',
           data:form,
           type:'POST',
           success:function(data){
               if(data.trim()==="done"){
                   alert("Replied successfully");
               }else{
                   alert("Error");
               }
           },
           error:function(errorThrown){
               alert("Error");
           }
       })
    });