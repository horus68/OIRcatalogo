<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-PT" lang="pt-PT">
<head>
<TITLE><%=stitulo%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name=viewport content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="../css/default.min.css?version=001" type="text/css" />
<script type="text/javascript" src="../js/sorttable.min.js"></script>
<script type="text/javascript" src="../js/tableH.js"></script>
<STYLE type="text/css">
@media print {
     table#users {width:17cm;font-size: 10pt;}
}
@media print {
     table#users td {border:solid 1px;}
}
</STYLE>
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head><body>
  <div class="destaque1">
    <h1>Catálogo Coletivo: Acessos ao sistema</h1>
  </div>    
<!-- Segmento Navegação topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">» <a href="../default.asp">Zona Pública</a> » <a href="admin.asp?id=1">Administração</a> » Listagem de acessos
</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <span id="utilizador"> 	 
		     <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user")) end if%><%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
      </span> 
    </div>
  </div>
<!-- Segmento Navegação topo - FIM -->
<div id="principal">
<div id="admbotoes" style="float:right"><a href="admin.asp?id=1"><img src="../imagens/picactions/icon_close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a><a href="javascript:window.print()"><img src="../imagens/picactions/icon_imprimir.gif" border=0 title="Imprimir lista de acessos" alt="Imprimir lista de acessos"></a></div>
<h3>Listagem de acessos ao sistema de administração [LOGS]</h3>

<table id="users" class="sortable" summary="Listagem de acessos ao sistema de administração">
  <th width="80">Data</th><th width="80" class="sorttable_nosort">Hora</th><th width="580" class="sorttable_nosort">Registo</th>
<%
Function writeLog (str) 
            Dim objFSO, objTStream
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.openTextFile(Server.MapPath(vdir & "/upload/logs/admin.log"), 8, True)
			dia=day(now)
			mes=month(now)
			ano=year(now)
			hora=hour(now)
			minuto=minute(now)
			segundo= second(now)
			if len(segundo)=1 then segundo= "0" & segundo
			linha = dia & "-" & mes & "-" & ano & ";" & hora & ":" & minuto & ":" & segundo  & ";" & str
			objTStream.WriteLine linha & " [" & Request.ServerVariables("Remote_Addr") & "]" 
			objTStream.Close
			Set objTStream = nothing
			Set objFSO = nothing
			Application.Unlock
 End Function 
Set ObjectoFicheiro = CreateObject("Scripting.fileSystemObject")
Set LerTexto = ObjectoFicheiro.OpenTextFile (Server.MapPath(vdir & "/upload/logs/admin.log"), 1)
if err.number <>0 then
    response.write "<p style=""aviso"">Erro ao ler o ficheiro LOGS.</p>"
	response.write "Por favor contacte o administrador.</p>" 
	writeLog("Erro ao ler o ficheiro LOG")
	response.end 
end if 
'	on error goto 0
flag=0
While NOT LerTexto.AtEndOfStream
    response.write "<tr>"
	linha= LerTexto.ReadLine
	flag=1
	str=split(linha,";")
	if ubound(str)>0  then
	  if trim(str(0))<>"" then 
	   for l=0 to 2
	      response.write "<td> " & str(l) & "</td>" & vbcrlf
	   next
	  else
	    for l=0 to 2
	     response.write "<td>&nbsp;</td>" &vbcrlf
		next 
	  end if  
	end if
	response.write "</tr>"				
Wend
Set LerTexto = nothing		     
if flag=0 then response.write "<tr height=""200""><td colspan=""3"" align=""center"">Ficheiro vazio</td></tr>"   
response.write "</table><br><br>"
%>