
  // $(document).ready(function() {
  //   //alert($("#admin_user_email").val());
  
  //   // // Setup form validation on the #register-form element
  //   $("#new_admin_user").validate({
    
  //       // Specify the validation rules
  //       rules: {
          
  //           "admin_user[email]": {
  //               required: true,
  //               email: true
  //           },
  //           "admin_user[passsword]": {
  //               required: true,
  //               minlength: 6
  //           }
  //       },
        
  //       // Specify the validation error messages
  //       messages: {
  //          "admin_user[email]" :{ 
  //          	required: "Email addres should not blan."

  //          	email:"Please enter valid email id."
  //          },
          
  //           "admin_user[password]": {
  //               required: "Password should not be blank.",
  //               minlength: "Password must be contain 6 characters."
  //           }
            
  //       },
        
  //       submitHandler: function(form) {
  //           form.submit();
  //       }
  //   });

  // });
  // 


//   $(document).ready(function(){



//     $("#admin_user_email_input").append("<span class= 'email-error' style='color:red;padding-left:90px;'></span>");
//     $("#admin_user_password_input").append("<span class= 'pass-error' style='color:red;padding-left:90px;'></span>");


//     var reg = /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,3})$/;   
   
//     $('#session_new > .actions > ol > li > input[type="submit"]').click(function(e){
//         e.preventDefault();
//         var a = validateForm();
//         if(a){$('#session_new').submit();}    
//     });
    
//     function validateForm(){
//         var email = $('#admin_user_email').val().trim();
//         var pass  = $('#admin_user_password').val().trim();
//         var email_error = "";
//         var pass_error = "";

//         var email_check = reg.test(email);

//         if(email == ""){email_error = "Email Id can't be blank";}
//         else{if(!email_check){email_error = "Invalid email format";}}          
//         if(pass  == "" ){pass_error = " Password can't be blank";}
         
//         {document.getElementsByClassName("email-error")[0].innerHTML = email_error;}
//         {document.getElementsByClassName("pass-error")[0].innerHTML = pass_error;}

//         if((email_error == "" )&&(pass_error == "")){return true;}

//         return false;
//     }


//     $('#new_admin_user > .actions > ol > li > input[type="submit"]').click(function(e){
//         $("#admin_user_email").append("<span class= 'email-error' style='color:red;padding-left:90px;'></span>");
//         e.preventDefault();
//         var a = validateForgetForm();
//         if(a){
//           $('#new_admin_user').submit();
//         }    
//     });
    
//     function validateForgetForm(){
//         var email = $('#admin_user_email').val().trim();
//         var pass  = $('#admin_user_password').val().trim();
//         var con_pass  = $('#admin_user_password_confirmation').val().trim();
//         var email_error = "";
//         var pass_error = "";
        
//         var email_check = reg.test(email);

//         if(email == ""){
//             email_error = "Email Can't be blank";
//             $(".email-error").text(email_error);
//             return false;
//         }
//         else if(!email_check)
//             {
//                 email_error = "Invalid email format";
//                 $(".email-error").text(email_error);
//                 return false;
//             }          
//         else if(pass  == "" )
//         {
//             $(".email-error").text(" ");
//               pass_error = " Password can't be blank";
//              $(".pass-error").text(pass_error);
//             return false;
            
//         }
//         else if(con_pass=="")
//         {
//             $(".pass-error").text(" ");
             
//              $(".pass-error").text("Password confirmation can't be blank");
//             return false;
//         }
    

//         else{return true;}


      
//     }

// });

$(document).ready(function(){


     $("#error_explanation").text("").hide();
     $("#error_explanation > ul > li").text("").hide();
     $(".inputs > ol > li > p").css({"color":"red","font-weight":"normal"});
   
    var reg = /^[a-zA-Z0-9_\.\-]+(\.[_a-z0-9]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,})$/;   
   
    $('#session_new > .actions > ol > li > input[type="submit"]').click(function(e){
        e.preventDefault();
        var a = validateForm();
        if(a){$('#session_new').submit();}    
    });
    
    function validateForm(){


    $("#admin_user_email_input").append("<span class= 'email-error' style='color:red;padding-left:90px;'></span>");
    $("#admin_user_password_input").append("<span class= 'pass-error' style='color:red;padding-left:90px;'></span>");
   
      
        var email = $('#admin_user_email').val().trim();
        var pass  = $('#admin_user_password').val().trim();
        var email_error = "";
        var pass_error = "";

        var email_check = reg.test(email);

        if(email == ""){email_error = "Email id can't be blank";}
        else{if(!email_check){email_error = "Invalid email format";}}          
        if(pass  == "" ){pass_error = "Password can't be blank";}
         
        {document.getElementsByClassName("email-error")[0].innerHTML = email_error;}
        {document.getElementsByClassName("pass-error")[0].innerHTML = pass_error;}

        if((email_error == "" )&&(pass_error == "")){return true;}

        return false;
    }


    $('#new_admin_user > .actions > ol > li > input[type="submit"]').click(function(e){
       
        e.preventDefault();
       // var val= $('#new_admin_user > .actions > ol > li > input[type="submit"]').val();
        if($('#new_admin_user > .actions > ol > li > input[type="submit"]').val() =="Change my password")
        {
           $(".inputs > ol > li > p").text("Password must be contain (6-20) characters.");
          var b = validateResetForm(); 
           if(b)
          {$('#new_admin_user').submit();}  
        }
        if($('#new_admin_user > .actions > ol > li > input[type="submit"]').val()=="Reset My Password")
        {
        var a = validateForgetForm();
       
        if(a)
          {$('#new_admin_user').submit();}  
        }

        if($('#new_admin_user > .actions > ol > li > input[type="submit"]').val()=="Create Admin user")
        {
        var c = validateNewAdminForm();
       
        if(!c)
          {$('#new_admin_user').submit();}  
        }


    });

    function validateNewAdminForm()
    {

    $("#admin_user_email_input").append("<span class= 'email-error' style='color:red; padding-left:310px;'></span>");
    $("#admin_user_password_input").append("<span class= 'pass-error' style='color:red;padding-left:310px;'></span>");
    $("#admin_user_password_confirmation_input").append("<span class= 'cpass-error' style='color:red; padding-left:310px;'></span>");
        var email = $('#admin_user_email').val().trim();
        var pass  = $('#admin_user_password').val().trim();
        var cpass  = $('#admin_user_password_confirmation').val().trim();
       

        var email_check = reg.test(email);

        if(email == ""){
          document.getElementsByClassName("email-error")[0].innerHTML = "Email id can't be blankoooo";
          return true;
        }
        else if(!email_check){
          document.getElementsByClassName("email-error")[0].innerHTML = "Invalid email format";
          
        return true;
        }         
        else if(pass  == "" ){
          document.getElementsByClassName("pass-error")[0].innerHTML = "Password can't be blank";
          document.getElementsByClassName("email-error")[0].innerHTML="";

        return true;}

 
       else if (cpass=="")
        {document.getElementsByClassName("cpass-error")[0].innerHTML="Confirmation password can't be blank";
         document.getElementsByClassName("email-error")[0].innerHTML="";
          document.getElementsByClassName("pass-error")[0].innerHTML="";

         return true;
       }
       else if(pass!=cpass){
        document.getElementsByClassName("cpass-error")[0].innerHTML = "Password does not match. ";
       document.getElementsByClassName("email-error")[0].innerHTML="";
      document.getElementsByClassName("pass-error")[0].innerHTML="";

       return true;
        }
        else
        {
          return false;
        }
     
     
    }
    







    function validateForgetForm(){

    $("#admin_user_email_input").append("<span class= 'email-error' style='color:red; padding-left:90px;'></span>");

        var email = $('#admin_user_email').val().trim();
        var email_error = "";
        
        var email_check = reg.test(email);

        if(email == ""){email_error = "Email id can't be blank";}
        else{if(!email_check){email_error = "Invalid email format";}}          
        
        {$(".email-error").text(email_error);}

        if((email_error == "" )){return true;}

        return false;
    }
      function  validateResetForm()
     {

  
    $("#admin_user_password_input").append("<span class= 'pass-error' style='color:red; padding-left:90px;'></span>");
    $("#admin_user_password_confirmation_input").append("<span class= 'cpass-error' style='color:red;'></span>");
      var pass_error="";
      var cpass_error="";
       var pass  = $('#admin_user_password').val().trim();
      var cpass  = $('#admin_user_password_confirmation').val().trim();
       if(pass  == "" ){pass_error = "Password can't be blank";}
       else if (cpass==""){cpass_error="Confirmation password can't be blank"}
       else if(pass!=cpass){ cpass_error = "Password does not match. ";
        }

        {document.getElementsByClassName("pass-error")[0].innerHTML = pass_error;}
        {document.getElementsByClassName("cpass-error")[0].innerHTML = cpass_error;}
      //alert( $('#new_admin_user > .actions > ol > li > input[type="submit"]').val());
       if((cpass_error == "" )&&(pass_error == "")){return true;}
      return false;
     
     }



});
