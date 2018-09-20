<%-- 
    Document   : newjsp
    Created on : Aug 30, 2018, 9:40:29 PM
    Author     : unbox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>
function myFunction() {
   // alert('1');
  var input, filter, select,option, i;
 input = document.getElementById("sstaffid");
  filter = input.value.toUpperCase();
 
  select = document.getElementById("myselect");
  option=select.getElementsByTagName("option");
  // alert(select.length);
   for( i=0;i < select.length; i++){
       option=select.getElementsByTagName("option")[i];
     //  alert(option.value);
       if(option.innerHTML.toUpperCase().indexOf(filter) > -1){
           option.style.display = "";
           select.autofocus="true";
           
       }else{
           option.style.display = "none";
       }
   }
}
</script>
    </head>
    <body>
        <h1>Hello World!</h1>
        <input type="text" id="sstaffid" onkeyup="myFunction()" placeholder="search for staffid"><br>
        <select id="myselect" autofocus="autofocus" >
            <option></option>
            <option value="one">one</option>
            <option value="two">two</option>
            <option value="three">three</option>
            <option value="four">four</option>
            <option value="five">five</option>
        </select>
    </body>
</html>
