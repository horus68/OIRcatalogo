<!--#include file="admin/functions.asp"-->
<!--#include file="admin/config.asp"-->
<%
  strURL=strROOT & "/cgi/www.exe/[in=getpar.in]"
  strHTML=getUrl(strURL)
  valores= split(strHTML,",")
  session("portal")=valores(2)
  strURL=strROOT & "/cgi/www.exe/[in=getrates.in]?expr=MFN $"
  strHTML=getUrl(strURL)
  votos= split(strHTML,",")
  sentidadelonga = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "entidadelonga")
  sversao = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "versao")
  surlRBE = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "urlRBE")
  surlPORTAL = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "urlPORTAL")
  sentidade = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "entidade")
  stitulo = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "PORTAL", "titulo")
  slogo = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "PORTAL", "imglogo")
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="pt" lang="pt">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="robots" content="follow,index" />
	<title>Identificar bibliotecas <%=stitulo%></title>
	<link rel="stylesheet" href="css/default.min.css" type="text/css" />
	<script type="text/javascript" src="js/geral.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
    if (typeof jQuery == 'undefined') {
    document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
    } 
    </script>
	<script defer src="https://use.fontawesome.com/releases/v5.0.13/js/all.js" integrity="sha384-xymdQtn1n3lH2wcu0qhcdaOpQwyoarkgLVxC/wZ5q7h9gHtxICrpcaSUfygqZGOe" crossorigin="anonymous"></script>
	<link rel="icon" href="favicon.ico" type="image/ico"/>
 	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
	<meta name="description" content="Identificar bibliotecas no Cat�logo coletivo da Rede de Bibliotecas do Concelho"/>
	<meta name="keywords" content="Cat�logo coletivo, Bibliotecas, pesquisar biblioteca" />
	<meta name="author" content="Rede Concelhia de Bibliotecas" />
  <meta property="og:title" content="Identificar bibliotecas Cat�logo da Rede de bibliotecas" />
  <meta property="og:type" content="library" />
  <meta property="og:site_name" content="Cat�logo - Rede de bibliotecas" />
  <meta property="og:description" content="Cat�logo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos existentes nas bibliotecas deste concelho" />
</head>

<body>
  <div class="destaque1">
    <h2>Cat�logo Coletivo: <%=sentidadelonga%></h2>
  </div>
<!-- Segmento Navega��o topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">� <a href="default.asp">Entrada</a> � Ajuda: Dicas de pesquisa</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
    </div>
  </div>
<!-- Segmento Navega��o topo - FIM -->
    <div id="principal">
	  <div align="center">
<img src="<%=slogo%>" alt="Log�tipo">
</div>
	<h2><span class="fa-layers fa-fw" style="font-size:3em"><i class="fas fa-circle-notch" ></i><i class="fas fa-graduation-cap" data-fa-transform="shrink-8" title="Identificar e localizar uma biblioteca"></i></span>Como saber a que Biblioteca pertence um documento?</h2> 
<p>Em cada resultado de pesquisa surge uma indica��o de qual a biblioteca onde se encontra o documento, os contactos e morada da biblioteca bem como a localiza��o no mapa.</p> 
<p>Como � que chegamos at� l�? Comece por pesquisar o que procura. Ao fazer uma pesquisa obt�m os seus resultados, sob a forma de registos bibliogr�ficos.<br /><img src="imagens/ajuda/pesquisa_simplificada.png" alt="Pesquisa simplificada" border=0 align="center">
</p>
	<dl>
		<dt>Para ver a indica��o das bibliotecas onde pode consultar esses documentos veja a linha "Localiza��o" e carregue na sigla da biblioteca ou no sinal "+"</dt>
			<dd>Todos os resultados t�m uma indica��o de �Localiza��o� onde surgem as siglas das v�rias bibliotecas.</dd>
			<dd>Como se trata de um cat�logo coletivo v�o aparecer v�rias siglas de acordo com os v�rios exemplares existentes no cat�logo.</dd>
			<dd>Clicando na sigla (ou no sinal +) surge uma informa��o detalhada sobre a Biblioteca onde est� aquele documento.</dd>	
			</dl>
			<br />
<img src="imagens/ajuda/bib_identificar1.png" alt="Resultado da pesquisa" border=0 align="center">
	</p>
	<div class="destaquetexto">
		<h2>Como chegar � biblioteca?</h2>
	<p>Para saber como chegar � biblioteca pode carregar no �cone do carro/percurso para que se abra uma janela com o mapa de localiza��o.<br />
<img src="imagens/ajuda/bib_identificar2.png" alt="Resultado da pesquisa" border=0 align="center">
<br />
Na p�gina inicial do cat�logo pode ainda consultar os contactos das bibliotecas, clicando na hiperliga��o �Contactos das Bibliotecas�.
	</p>
	</div>
	<br />
	<p>Em caso de d�vidas, dirija-se � biblioteca mais pr�xima onde o podem ajudar nas pesquisas e empr�stimos.
	<br />Boas leituras!
	</p>
	<div align="center" style="clear:both" class="txtvoltar">
			<a style="text-decoration:none" href="default.asp"><input type="button" name="bt2" value="Voltar" class="botao botao5";></center>
	</div> 
</div>
		<br />
	<br />
</body>
</html>
