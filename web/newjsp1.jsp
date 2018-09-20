<%-- 
    Document   : newjsp1
    Created on : Sep 11, 2018, 3:05:40 PM
    Author     : unbox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
   <script type="text/javascript">
function getfolder(e) {
    var files = e.target.files;
    var path = files[0].webkitRelativePath;
    var Folder = path.split("/");
    alert(Folder[0]);
}
</script>

<input type="file" id="flup" onchange="getfolder(event)" webkitdirectory mozdirectory msdirectory odirectory directory multiple />
    </body>
</html>
