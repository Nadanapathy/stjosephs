<%-- 
    Document   : test
    Created on : Aug 25, 2018, 8:05:56 PM
    Author     : unbox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function check(v){
             //   alert('called');
                //var v=this.value;
         if(!isNaN(v.value)){
                 //  alert('is no');
                    if(v.value>50){
                        alert("Invalid Mark");
                        v.value="";
                        v.focus();
                    }
                }       
        if(isNaN(v.value)){
               //     alert('not no');
                    v.value="";
                }
                
               
            }
        </script>
    </head>
    <body>
        <h1>Hello World!</h1>
        <form>
            <input type="text" id="123" required="" onchange="check(this)"><label ></label>
        <br>
        <button type="submit">ok</button>
        </form>
       
    </body>
</html>
