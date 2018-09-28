<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">
<head>
<title>Imprimir email</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="../css/default.min.css?version=001" type="text/css" />
<body><br><br>
<%    
	destinatario=request("destinatario")
	mensagem=request("mensagem")
	assunto=request("assunto")
	response.write "<fieldset class=""users"" style=""margin:8px;text-align:left;width:500px;font-size:1.1em"">"
	response.write "<legend >Email enviado para " & destinatario & "</legend>"
	response.write "<p style=""margin-left:7px"">Assunto: <b>" & assunto & "</b> </p>"
	response.write "<p style=""margin-left:7px"">" & mensagem & "</p>"
	response.write "</fieldset>"
%>
<br><br>
<div style="float:right; margin-right: 20px; font:0.8em;">Imprimir<a href="javascript:window.print()"><img src="../imagens/picactions/icon_imprimir.gif" border=0 align="absmiddle"></a></div>

<!--<center><input type="button" onclick="javascript:window.print()" value="Imprimir"></center>-->
</body>