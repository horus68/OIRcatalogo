<%@ Language=VBScript %>
<% 
option explicit 
If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"
Response.Expires = -1
Server.ScriptTimeout = 1200
' All communication must be in UTF-8, including the response back from the request
Session.CodePage  = 65001
%>
<!--#include file="functions.asp"-->
<!-- #include file="aspupload.asp" -->
<%


  ' ****************************************************
  ' Change the value of the variable below to the pathname
  ' of a directory with write permissions, for example "C:\Inetpub\wwwroot"
  ' ****************************************************

  Dim uploadsDirVar
  uploadsDirVar = server.mappath("/rbcatalogo/upload/isos/") 


function OutputForm()
%>
    <br>
    <form name="frmSend" method="POST" enctype="multipart/form-data" accept-charset="utf-8" action="admin_iso_upload.asp" onSubmit="return onSubmitForm();">
	<B>Indicar ficheiro ISO: </B><br />
	<input name="attach1" id="attach1" type="file" size="54">
    <br /> 
    <p align="center"><input style="margin-top:4" type=submit value="Enviar" class="botao botao1"></p>
    </form>
	<div style="font-size:0.8em"><input id="chkfecho" name="chkfecho" type="checkbox" checked> Fechar janela ap&oacute;s conclus&atilde;o do carregamento</div>
	
<%
end function
Function LinkClose()
%>
	<div style="float:right"><a   href="#" onClick="window.close();">Fechar janela</a></div><br>
<%

end function

function TestEnvironment()
    Dim fso, fileName, testFile, streamTest
    TestEnvironment = ""
    Set fso = Server.CreateObject("Scripting.FileSystemObject")
    if not fso.FolderExists(uploadsDirVar) then
        TestEnvironment = "<B>Pasta de UPLOAD em falta.</B>"
        exit function
    end if
    fileName = uploadsDirVar & "\test.txt"
    on error resume next
    Set testFile = fso.CreateTextFile(fileName, true)
    If Err.Number<>0 then
        TestEnvironment = "<B>Pasta de UPLOAD sem permiss�es de escrita.</B>"
        exit function
    end if
    Err.Clear
    testFile.Close
    fso.DeleteFile(fileName)
    If Err.Number<>0 then
        TestEnvironment = "<B>Pasta de UPLOAD sem permiss�es para eliminar ficheiros</B>, embora possua permiss�es de escrita.<br>"
        exit function
    end if
    Err.Clear
    Set streamTest = Server.CreateObject("ADODB.Stream")
    If Err.Number<>0 then
        TestEnvironment = "<B>O objecto ADODB <I>Stream</I> n�o est� dispon�vel no servidor.</B>"
        exit function
    end if
    Set streamTest = Nothing
end function

function SaveFiles
    Dim Upload, fileName, fileSize, ks, i, fileKey

    Set Upload = New FreeASPUpload
    Upload.Save(uploadsDirVar)

	' If something fails inside the script, but the exception is handled
	If Err.Number<>0 then  Exit function
    SaveFiles = ""
    ks = Upload.UploadedFiles.keys
    if (UBound(ks) <> -1) then
        SaveFiles = "<B>Ficheiro carregado com sucesso:</B> "
        for each fileKey in Upload.UploadedFiles.keys
            SaveFiles = SaveFiles & Upload.UploadedFiles(fileKey).FileName & " (" & Upload.UploadedFiles(fileKey).Length & "B) "
        next
    else
        SaveFiles = "Nenhum ficheiro selecionado ou nome de ficheiro inv�lido."
    end if

end function
%>

<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Carregamento de bases</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name=viewport content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow" />
<link rel="stylesheet" href="../css/default.min.css" type="text/css" title="styles" />
<style>
 td {font-size: 1em}
 td.fecho{font-size: 0.9em}
 body {margin-left:15px;margin-top:10px}
</style>
<script language="JavaScript">
var flag=false;
var ob;
function fechar(){
if (flag)
{
clearTimeout(ob);
  window.close(); 
}
else {
	  flag=true;
	  ob=setTimeout("fechar()",3000); 
	  }
}
</script>
<script language="JavaScript">
function validar(user){
  var s=document.getElementById("attach1").value;
  var pos= s.lastIndexOf('.');
  var fext= s.substring(pos+1);
  fext=fext.toUpperCase();
  var posi= s.lastIndexOf('\\');

  s= s.substring(posi+1,pos);
  s= s.toUpperCase();
  if (s=="")  { alert("O campo NOME do ficheiro n�o pode ficar vazio! \nUtilize o bot�o ESCOLHER FICHEIRO e repita a opera��o."); return false;}
  
  if (fext=='ISO')
  {
	  
	  if (s != user) 
	  {
		  var r=confirm("O sistema detetou que o nome do ficheiro ISO n�o confere com o nome do UTILIZADOR atual.\nATEN��O: O ficheiro ISO ser� carregado mas n�o ser� processado. \nTem a certeza que pretende continuar?")
		  if (r==true) return true; else return false;
	  }
  }
}
</script>
<script>
function onSubmitForm() {
    var formDOMObj = document.frmSend;
    if (formDOMObj.attach1.value == "" )
        alert("O campo NOME do ficheiro n�o pode ficar vazio! \nUtilize o bot�o ESCOLHER FICHEIRO e repita a opera��o.")
    else
        return validar('<%=session("user")%>');
    return false;
}
</script>
</head>

<body>
<h3>Envio de ficheiros em formato ISO</h3>


<%
Dim diagnostics
if Request.ServerVariables("REQUEST_METHOD") <> "POST" then
    diagnostics = TestEnvironment()
    if diagnostics<>"" then
        response.write "<div style=""margin-left:20; margin-top:50; margin-right:30; margin-bottom:50;"">"
        response.write diagnostics
        response.write "<p>Contacte o administrador do sistema."
        response.write "</div>"
		linkClose()
    else
        response.write "<div style=""margin-left:10"">"
        OutputForm()
		linkClose()
        response.write "</div>"
    end if
else
    response.write "<div style=""margin-left:10"">"
    OutputForm()
    response.write SaveFiles()
	linkClose()
	response.write "<script>fechar();</script>"
end if

%>

</body>
</html>

