<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!--#include file="clsUpload.asp"-->
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-PT" lang="pt-PT">

<head>
	<title>Importação de leitores</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name=viewport content="width=device-width, initial-scale=1" />
	<meta name="robots" content="noindex, nofollow" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" href="../css/default.min.css?version=001" type="text/css" title="styles" />
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
	  ob=setTimeout("fechar()",5000); 
	  }
}
</script>
	<script language="JavaScript">
		function validar(user){
  var s=document.getElementById("FILE1").value;
  var pos= s.lastIndexOf('.');
  var fext= s.substring(pos+1);
  fext=fext.toUpperCase();
  var posi= s.lastIndexOf('\\');

  s= s.substring(posi+1,pos);
  s= s.toUpperCase();
  if (s=="")  { alert("O campo NOME do ficheiro não pode ficar vazio! \nUtilize o botão PROCURAR e repita a operação."); return false;}
  
  if (fext!='ISO' && ftext!='CSV')
  {
		 alert("Apenas são permitidas as extensões de ficheiros |*.CSV| e |*.ISO|")
		 return false;
  }
}
</script>
	<style>
		body {margin-left:10px;margin-top:5px}
 td {font-size: 0.9em}
 .fecho{font-size: 0.75em}
</style>
	<%	If Session("LoggedIn") = True Then 
%>

	<%		If Request.QueryString("mode") = "doit" Then
			Server.ScriptTimeout = 1200		
			Set Upload = New clsUpload
			FileName = Upload.Fields("File1").FileName
			formato = Upload("impformato").Value
			reset= Upload("reset").Value
			fecho=Upload("chkfecho").Value
			savepath= "/rbcatalogo/upload/files/"
			
			MaxFileSize = 100*1024*1024  ' 100MB 
			Ext = Upload("File1").FileExt
			response.write "<br><h3>Importação de leitores</h3>"
			Select Case Ext
			Case "ISO","CSV"
				If Upload("File1").Length <= MaxFileSize then
				
					FileName = Upload("File1").FileName
					Folder = Server.MapPath(savepath) & "/"
					Upload("File1").SaveAs Folder & FileName
					Dim objXmlHttp
					Dim strHTML
					Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
					if reset="1" then
					    objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?null&create=../bases/leitor&now&count=0", False
						objXmlHttp.send
					end if
					if formato ="csv" then
						objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?seq=../upload/files/"& FileName & ";&cipar=dbdef.cip&append=../bases/leitor&now", False
						objXmlHttp.send
						strHTML = objXmlHttp.responsebody
					else	
						objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?iso=../upload/files/"& FileName &";&cipar=dbdef.cip&gizmo=gansutf8&append=../bases/leitor&now", False
						objXmlHttp.send
						strHTML = objXmlHttp.responseBody	
					end if	
					texto=SimpleBinaryToString(strHTML)
					texto= replace(replace(texto,"®",""),"¯","")
                    'objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?../bases/leitor&cipar=dbdef.cip&gizmo=gutf8ans&copy=../bases/leitor&nowait", False
					'objXmlHttp.send
					writeFile Server.MapPath("../upload/files/admin_imp.html"), texto
				
					if  texto<>"" then					
						Response.Write("<br><p align='center'>O ficheiro foi carregado e processado com successo.  [<a href=""../upload/files/admin_imp.html"" target=""_blank"">Ver ficheiro</a>] <a  href='#' onClick='window.close();'><br />Clique aqui para fechar a janela</a>!</p>")
					else
						Response.Write("<br><p align='center'>O ficheiro foi carregado, mas não pôde ser processado. <a  href='#' onClick='window.close();'>Clique aqui para fechar a janela</a>!</p>")
					end if 			
					if trim(fecho)="on" then response.write "<script>fechar()</script>"											

				Else
					Response.Write "<p align='center'>Erro: O tamanho máximo do ficheiro(100 Mb) foi excedido!<br>"
					Response.Write("<p align='center'>Use o botão Retroceder do Browser para tentar de novo ou clique <a  href='javascript:history.go(-1)'>aqui</a>!</p>")				
				End If	
			Case Else
				Response.Write "<p align='center'>Erro: Tipo de ficheiro não permitido.<br>"
				Response.Write("<p align='center'>Use o botão Retroceder do Browser para tentar de novo ou clique <a  href='javascript:history.go(-1)'>aqui</a>!</p>")				
			End Select
			
       
           				
			
											
		Else
		%>
</head>

<body>
	<form id="frmimp" action="admin_imp_leitores.asp?mode=doit" method="post" ENCTYPE="multipart/form-data" onsubmit="return validar('<%=session("user")%>')">
		<p style="font-size:1.3em"><b>Importação de Leitores</b></p>
		<table border="0" width="100%" cellspacing="1" cellpadding="4">
			<tr>
				<td>Formato do ficheiro
				</td>
				<td>
					<input type="radio" id="formato" name="impformato" value="csv" checked>CSV
					<input type="radio" id="formato1" name="impformato" value="iso">Iso2709
				</td>
			</tr>
			<tr>
				<td>Reinicializar base de dados?
				</td>
				<td>
					<input type="radio" id="reset" name="reset" value="1">Sim
					<input type="radio" id="reset1" name="reset" value="0" checked>Não
				</td>
			</tr>
		</table>
		<p><b>Indicar ficheiro:</b>
			<br>
			<input name="FILE1" id="FILE1" type="file" size="54">
		</p>
		<p align="center">
			<input type="submit" class="botao botao1" value="Enviar">
		</p>
		<p class="fecho">
			<input id="chkfecho" name="chkfecho" type="checkbox" checked>Fechar janela após conclusão da transferência</p>
	</form>
	<div style="float:right"><a href="#" onClick="window.close();">Fechar janela</a> </div>
	<br>
</body>
<%		End if
 	Else  
	        %>
<div id="upload">
	<img src="../imagens/logotipo.png">
	<br><br><br>
	<h3>Atenção! A sua sessão expirou!!!</h3>
	<p>
		<%=session("nome")%>
	</p>
	<p></p>
	<p>Terá de voltar a iniciar a sessão e a entrar no sistema para realizar a operação solicitada.</p>
	<script>
		fechar();

	</script>
</div>
<%end if %>
