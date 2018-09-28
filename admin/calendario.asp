<%
If Not Session("LoggedIn") = True  Then response.redirect "admin.asp" %>
<%
Dim objXmlHttp
Dim strHTML
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
select case request("op")
case "gravar"
    timeStart = "1/1/1970 12:00:00 AM" 
    dias=datediff("s", timeStart, request("data") & "-" & year(now) & " 12:00:00 AM")	
	resp=getUrl(strROOT & "/cgi/www.exe/[in=chktabff.in]?expressao="& mid(replace(request("data"),"-",""),3,2) & mid(replace(request("data"),"-",""),1,2))
	if resp="nao" then
			getUrl strROOT & "/cgi/www.exe/[in=newtabff.in]?data=" & mid(replace(request("data"),"-",""),3,2) & mid(replace(request("data"),"-",""),1,2) & "&motivo=" & request("motivo") & "&diasdiff=" & dias		 
	else
			getUrl strROOT & "/cgi/www.exe/[in=updtabff.in]?from=" & request("nreg") & "&data=" & mid(replace(request("data"),"-",""),3,2) & mid(replace(request("data"),"-",""),1,2) & "&motivo=" & request("motivo") & "&diasdiff=" & dias
	end if
case "del"
            getUrl strROOT & "/cgi/www.exe/[in=deltabff.in]?mfn=" & request("nreg")    
end select
Set objXmlHttp = nothing
%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">
<head>
<title>F�rias e feriados></title> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="robots" content="noindex, nofollow" />
<meta name=viewport content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/default.min.css" type="text/css" />
<script type="text/javascript" src="../js/sorttable.min.js"></script>
<script type="text/javascript" src="../js/tableH.js"></script>
<script type="text/javascript">
onload = function() {
    if (!document.getElementsByTagName || !document.createTextNode) return;
    var rows = document.getElementById('users').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    for (i = 0; i < rows.length; i++) {
        rows[i].onclick = function() {
		    var data=rows[this.rowIndex-1].cells[1].innerText || rows[this.rowIndex-1].cells[1].textContent;
			var motivo=rows[this.rowIndex-1].cells[2].innerText || rows[this.rowIndex-1].cells[2].textContent;
			var nreg=rows[this.rowIndex-1].cells[0].innerText || rows[this.rowIndex-1].cells[0].textContent;
			document.getElementById("data").value=data;
			document.getElementById("motivo").value=motivo;
			document.getElementById("nreg").value=nreg;
        }
    }
}
function submeter(id){
    var msg="";
	var flag=false;
	var vdt = new Date();
	var ano= vdt.getYear();
		    
    switch (id){
	  case 0:  var data = document.getElementById("data").value;	
			   data = data.replace(/-/g,'');
			   var dia=parseInt(data.substring(0,2));
			   var mes=parseInt(data.substring(3,4));
			   if((mes==4 && dia > 30) || (mes==6 && dia > 30) || (mes==9 && dia > 30) || (mes==11 && dia > 30))
					 flag=true;    
			   else
					 if(ano%4!=0 && mes==2 && dia>28) flag=true; 
					 else 
						 if(ano%4==0 && mes==2 && dia>29) flag=true;
				if (data.length !=4) 
				   flag=true;
				else if (isNaN(data)) 
						flag=true;
					 else 
						  if (parseInt(data.substring(0,2)) < 1 || parseInt(data.substring(0,2)) > 31)
							 flag=true;
				if (flag) {alert ("Erro no formato da data [dd-mm]"); document.getElementById("data").focus();return}
						  document.getElementById("frmTabela").action="calendario.asp?op=gravar";
						  document.getElementById("frmTabela").submit();
						  break;
	  case 1: document.getElementById("frmTabela").action="calendario.asp?op=del";
	  		  document.getElementById("frmTabela").submit();
			  break;
	  		  
	}
}
</script>
<style>
table#users {width: 350px;font-size:1em}
</style>
<link rel="icon" href="../favicon.ico" type="image/ico"/>
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>

<body>
  <div class="destaque1">
    <h1>Cat�logo Coletivo: Calend�rio</h1>
  </div> 
<!-- Segmento Navega��o topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">� <a href="../default.asp">Zona p�blica</a> � <a href="admin.asp?id=5">Administra��o</a> � Calend�rio</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <span id="utilizador"> 
        <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user")) end if%>
		<%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]
		<%end if%>
	</span> 
    </div>
  </div>
<!-- Segmento Navega��o topo - FIM -->
<div id="principal">
<div id="admbotoes" style="float:right"><a href="../admin/admin.asp?id=5"><img src="../imagens/picactions/icon_close.gif" border=0 title="Voltar � p�gina anterior" alt="Voltar � p�gina anterior"></a><% if flag=1 then %><a href="javascript:window.print()"><img src="../imagens/picactions/icon_imprimir.gif" border=0 title="Imprimir esta p�gina" alt="Imprimir esta p�gina"></a><%end if%></div><h3>F�rias e feriados [<%=year(date)%>]</h3>  
<br>
<%
resp=getUrl(strROOT & "/cgi/www.exe/[in=getcal.in]")
tabela=split(resp,",")
response.write "<form name=""frmtabela"" id=""frmTabela"" method=""post"" action="""">"
response.write "<div>Data: <input type=""text"" size=""4"" maxlength=""5"" name=""data"" id=""data""> Motivo: <input type=""text"" size=""30"" name=""motivo"" id=""motivo""> <a href=""javascript:submeter(0);""><img  src=""../imagens/picactions/icon_save.gif"" border=""0""></a><a href=""javascript:submeter(1)""><img  src=""../imagens/picactions/icon_delete.gif"" border=""0""></a></div>"
response.write "<input type=""hidden"" id=""nreg"" name=""nreg"">"
response.write "</form>"
response.write "<table class=""sortable"" id=""users"" summary=""Tabela de f�rias e feriados"">"
response.write "<th align=""center"">ID</th><th>Data</th><th>Designa��o</th>"
for i=0 to ubound(tabela)-1
   pos1=instr(tabela(i),"^a")
   pos2=instr(tabela(i),"^b")
   pos3=instr(tabela(i),"^c")
   if pos3>0 then compr=pos3 else compr=len(tabela(i))
   data=mid(tabela(i),pos1+2,4)
   texto=mid(tabela(i),pos2+2, compr-pos2-2)       
   response.write "<tr><td >" & mid(tabela(i),1,pos1-1) & "</td><td width=""40"">" & mid(data,3,2) & "-" & mid(data,1,2) & "</td><td width=""180"">" & texto & "</td></tr>"
 next
 response.write "</table>"   
%>
</div>