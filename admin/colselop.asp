<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-PT" lang="pt-PT">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name=viewport content="width=device-width, initial-scale=1" />
	<meta name="robots" content="noindex, nofollow" />

	<title><%=stitulo%></title>
	<link rel="stylesheet" href="../css/default.min.css?version=001" type="text/css" />
	<script type="text/javascript" src="../js/users.min.js"></script>
	<link rel="icon" href="../favicon.ico" type="image/x-icon" />
	<link rel="icon" type="image/png" sizes="32x32" href="../imagens/app/favicon-32x32.png?v=001" />
</head>

<body>
	<div class="destaque1">
		<h1>Catálogo Coletivo: Gestão da coleção</h1>
	</div>
	<!-- Segmento Navegação topo -->
	<div class="col3-contentor">
		<div class="col3">
			<p class="fil">» <a href="../default.asp">Zona pública</a> » <a href="admin.asp?id=3">Administração</a> » Avaliação das existências
			</p>
		</div>
		<div class="col3" id="lblutilizador">Utilizador:
			<% if session("user")="" then response.write "Visitante" else response.write ucase(session("user")) end if%>
			<%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]
			<%end if%>
		</div>
	</div>
	</div>
	<!-- Segmento Navegação topo - FIM -->
	<h3>Avaliação das existências<div id="admbotoes" style="float:right"><a href="admin.asp?id=3"><img src="../imagens/picactions/icon_close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a></div>
	</h3>
	<div id="principal">
		<div style="border:solid 1px #999">
			<%Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
			objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getuser.in]?expressao=SIGLA " & ucase(request("users")), False
			objXmlHttp.send
			strHTML = objXmlHttp.responseText
			if strHTML<>"" then
			siglaEXT= mid(strHTML,1,len(strHTML)-2)
			end if
		 %>
			<h4>
				<% if request("criterio")="X" then  response.write "Toda a rede" else response.write "Instituição: " & ucase(request("users")) & " (" & siglaEXT & ")"  end if%>
			</h4>
			<div class="col5-contentor">
				<div class="col5" style="width:40%">
					<form name="frmselcri" id="frmselcri" action="../cgi/www.exe/[in=gescol.in]" method="post" onSubmit="return false">
						<input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						<input type="hidden" id="base" name="base" value="<% =lcase(request("base")) %>">
						<input type="hidden" name="lim_inicio" value="1">
						<input type="hidden" name="expressao" id="expressao" value="">
						<input type="hidden" id="op" name="op" value="<% if request("users")<>"" then response.write lcase(request("users")) else response.write "X" end if %>">
						<input type="hidden" name="entidade" id="expressao" value="<%=sentidade%>">
						<p>Selecione o critério:<br>
							<select name="opges" id="opges">
								<option value="" selected>Por palavra</option>
								<option value="AS">Por assunto</option>
								<option value="CDU">Por CDU</option>
								<option value="AU">Por autor</option>
								<option value="TI">Por título</option>
								<option value="COL">Por coleção</option>
							</select></p>
						<p>Registos por página:<br><input type="text" size="10" id="limites" name="limites" value="25"></p>

				</div>
				<div class="col5" style="width:60%">
					Termo a pesquisar:<br><input type="text" size="60" id="termo" "name="termo"><br />Apenas ocorrências exatas: <input type="checkbox" id="PFX" name="PFX">
				</div>
			</div>
			<div align="center"><input type="button" value="Pesquisar" class="botao botao1" onClick="getOpCol();return false;"></div>
			</form>

		</div>
	</div>
</body>

</html>
