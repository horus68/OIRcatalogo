
<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!--#INCLUDE FILE="clsUpload.asp"-->
<link rel="stylesheet" href="../css/default.min.css" type="text/css" title="styles" />
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
  if (s=="")  { alert("O campo NOME do ficheiro n�o pode ficar vazio! \nUtilize o bot�o PROCURAR e repita a opera��o."); return false;}
  
  if (fext!='ISO' && ftext!='CSV')
  {
		 alert("Apenas s�o permitidas as extens�es de ficheiros |*.CSV| e |*.ISO|")
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
			response.write "<br><h3>Importa��o de leitores</h3>"
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
					    strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkperm.in]?expressao=SIGLA ADMIN")
						pos=instr(strHTML,"^c")    
						if pos>0 and mid(strHTML,pos+2,1)="1" then 															
							strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkuser.in]?expressao=SIGLA ADMIN")
						else
							writeLog("LOGIN (insucesso) - " & ucase(nm))
							response.write "<h3 style=""margin-top:50px;color:red"">Acesso negado. O utilizador n�o tem permiss�es de administra��o no sistema...</h3>"
							response.write "<br>Contacte o administrador"
							Session("LogError")=Session("LogError")+1        
							response.end
						end if 	
						user="ADMIN"
						
					    objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?null&create=../bases/users&now&count=1", False
						objXmlHttp.send
						objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?db=../bases/users&proc='A2~ADMIN~A3~Administrador~A7~"&strHTML&"'&copy=../bases/users", False
						objXmlHttp.send
						
					end if
					if formato ="csv" then
						objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?seq=../upload/files/"& FileName & ";&cipar=dbdef.cip&append=../bases/users&now", False
						objXmlHttp.send
						strHTML = objXmlHttp.responsebody
					else	
						objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?iso=../upload/files/"& FileName &";&cipar=dbdef.cip&gizmo=gansutf8&append=../bases/users&now", False
						objXmlHttp.send
						strHTML = objXmlHttp.responseBody	
					end if	
					texto=SimpleBinaryToString(strHTML)
					texto= replace(replace(texto,"�",""),"�","")
                    'objXmlHttp.open "GET", strROOT & "/cgi/mx.exe/cgi=mx?../bases/leitor&cipar=dbdef.cip&gizmo=gutf8ans&copy=../bases/leitor&nowait", False
					'objXmlHttp.send
					writeFile Server.MapPath("../upload/files/admin_imp.html"), texto
				
					if  texto<>"" then					
						Response.Write("<br><p align='center'>O ficheiro foi carregado e processado com successo.  [<a href=""../upload/files/admin_imp.html"" target=""_blank"">Ver ficheiro</a>] <a  href='#' onClick='window.close();'><br />Clique aqui para fechar a janela</a>!</p>")
					else
						Response.Write("<br><p align='center'>O ficheiro foi carregado, mas n�o p�de ser processado. <a  href='#' onClick='window.close();'>Clique aqui para fechar a janela</a>!</p>")
					end if 			
					if trim(fecho)="on" then response.write "<script>fechar()</script>"											

				Else
					Response.Write "<p align='center'>Erro: O tamanho m�ximo do ficheiro(100 Mb) foi excedido!<br>"
					Response.Write("<p align='center'>Use o bot�o Retroceder do Browser para tentar de novo ou clique <a  href='javascript:history.go(-1)'>aqui</a>!</p>")				
				End If	
			Case Else
				Response.Write "<p align='center'>Erro: Tipo de ficheiro n�o permitido.<br>"
				Response.Write("<p align='center'>Use o bot�o Retroceder do Browser para tentar de novo ou clique <a  href='javascript:history.go(-1)'>aqui</a>!</p>")				
			End Select
			
       
           				
			
											
		Else
		%>
		</head>
		<body >
			<form id="frmimp" action="admin_imp_users.asp?mode=doit" method="post" ENCTYPE="multipart/form-data" onsubmit="return validar('<%=session("user")%>')">
<p style="font-size:1.3em"><b>Importa��o de Utilizadores</b></p>	
			    <table  border="0" width="100%" cellspacing="1" cellpadding="4">
				 <tr>
				  <td>Formato do ficheiro
				  </td>
				    <td>CSV <input type="radio" id="formato" name="impformato" value="csv" checked> Iso2709<input type="radio" id="formato1" name="impformato" value="iso">
					</td>
				</tr><tr>
					<td>Reinicializar base de dados?
					</td>
					<td>Sim <input type="radio" id="reset" name="reset" value="1"> N�o <input type="radio" id="reset1" name="reset" value="0" checked>
					</td>
			    </tr>
	</table>
			      <p>Selecione o ficheiro:<br />
	<input type="file" id="FILE1" name="FILE1" size="54" class="botao botao5"></p>
<p>
<input type="submit" class="botao botao1" value="Enviar"></p>		      
<p class="fecho"><input id="chkfecho" name="chkfecho" type="checkbox" checked> Fechar janela ap�s conclus�o da transfer�ncia</p>
			</form>
				  <p align="center"> <a href="#" onClick="window.close();">Fechar janela</a></p>
	    </body>
<%		End if
 	Else  
	        %>
 <div id="upload"> 
  <img src="../imagens/logotipo.png">
  <br><br><br>
  <h3>Aten��o! A sua sess�o expirou!!!</h3>
  <p><%=session("nome")%></p>
  <p></p>
  <p>Por esse motivo ter� que voltar a entrar no sistema para realizar a opera��o solicitada.</p>
   <script>   
		fechar();
    </script>
  </div>
 <%end if %>
		
