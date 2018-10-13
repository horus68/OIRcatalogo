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
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="pt-PT" lang="pt-PT">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name=viewport content="width=device-width, initial-scale=1" />
	<meta name="robots" content="index, follow" />
	<title>Catálogo no telemóvel - <%=stitulo%></title>
	<link rel="stylesheet" href="css/default.min.css?version=001" type="text/css" />
	<script type="text/javascript" src="js/geral.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" crossorigin="anonymous"></script>
	<script>
		if (typeof jQuery == 'undefined') {
            document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
        }
    </script>
	<script defer async src="https://use.fontawesome.com/releases/v5.3.1/js/all.js" integrity="sha384-kW+oWsYx3YpxvjtZjFXqazFpA7UP/MbiY4jvs+RWZo2+N94PFZ36T6TFkc9O3qoB" crossorigin="anonymous"></script>
	<meta name="description" content="Como utilizar o catálogo coletivo em telemóveis - XPTO - Catálogo coletivo da Rede de Bibliotecas do concelho" />
	<meta name="keywords" content="Catálogo coletivo, Bibliotecas, pesquisar biblioteca, OPAC, registo bibliográfico" />
	<meta name="author" content="Rede Concelhia de Bibliotecas - XPTO" />
	<!-- Favicon Geral -->
	<link rel="icon" href="/rbcatalogo/favicon.ico" type="image/x-icon" />
	<link rel="icon" type="image/png" sizes="32x32" href="/rbcatalogo/imagens/app/favicon-32x32.png?v=001" />
	<!-- Favicon Android -->
	<link rel="manifest" href="manifest.json?v=001" />
	<meta name="theme-color" content="#cdc8b1" />
	<!-- Favicon Windows IE -->
	<meta name="msapplication-config" content="IEconfig.xml?v=001" />
	<meta name="application-name" content="Cat.RB XPTO" />
	<meta name="msapplication-TileColor" content="#afa782" />
	<meta name="msapplication-starturl" content="/rbcatalogo/default.asp" />
	<!-- Favicon iOS -->
	<link rel="apple-touch-icon-precomposed" href="/rbcatalogo/imagens/app/apple-touch-icon-precomposed.png?v=001" />
	<link rel="mask-icon" href="/rbcatalogo/imagens/app/safari-pinned-tab.svg?v=001" color="#5bbad5" />
	<!-- OpenGraph Facebook -->
	<meta property="og:title" content="Catálogo no telemóvel - XPTO - Rede de bibliotecas" />
	<meta property="og:description" content="XPTO: Como utilizar o catálogo coletivo em telemóveis. Pesquise os documentos existentes nas bibliotecas deste concelho" />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Catálogo - XPTO - Rede de bibliotecas" />
</head>

<body>
	<div class="destaque1">
		<h1>Catálogo Coletivo:
			<%=sentidadelonga%>
		</h1>
	</div>
	<!-- Segmento Navegação topo -->
	<div class="col3-contentor">
		<div class="col3">
			<p class="fil">» <a href="default.asp">Entrada</a> » Ajuda: Usar no telemóvel </p>
		</div>
		<div class="col3" id="lblutilizador">Utilizador:
			<% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
		</div>
	</div>
	<!-- Segmento Navegação topo - FIM -->
	<div id="principal">
		<div align="center">
			<img src="<%=slogo%>" alt="Logótipo">
		</div>
		<h2><span class="fa-layers fa-fw" style="font-size:3em"><i class="fas fa-circle-notch"></i><i class="fas fa-graduation-cap" data-fa-transform="shrink-8" alt="Utilizar o catálogo coletivo em telemóveis" title="Utilizar o catálogo coletivo em telemóveis"></i></span>Como utilizar o catálogo em telemóveis?</h2>
		<div class="col1-contentor">
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-mobile-alt" data-fa-transform="shrink-8" alt="Utilização em telemóveis" title="Utilização em telemóveis"></i></span>No navegador Web e sem aplicações</h3>
				<p>Pode utilizar o catálogo no telemóvel com o seu navegador Web habitual, basta entrar no endereço do catálogo.
					<br>O catálogo adapta-se ao seu ecrã e terá as mesmas funcionalidades que num computador.
					<br><img src="imagens/ajuda/movel_entrada.png" alt="Catálogo no telemóvel" title="Catálogo no telemóvel" border=0 align="center">
					<br>Dica: No Google pesquise por "catálogo + rede bibliotecas + nome do seu concelho"
				</p>
			</div>
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-qrcode" data-fa-transform="shrink-8" alt="QR Code" title="QR Code"></i></span>Entrar por QR Code</h3>
				<p>Escreva o endereço no navegador ou capture a imagem com o leitor de QR Code do seu telemóvel.</p>
				<p>No seu telemóvel, abra a aplicação de QR Code e aponte para esta imagem:
					<br>
					<br>
					<img src="imagens/app/qrcode.png" alt="Ligação em QR Code para o catálogo" title="Ligação em QR Code para o catálogo" border=0 align="center">
					<br>
					<br>A aplicação vai ler o código diretamente do ecrã. Carregue no endereço que aparece na aplicação e entrará no catálogo.
				</p>
			</div>
					<br>
		</div>
		<br style="clear:left" />
				<h2>Tenha o catálogo sempre à mão... no telemóvel</h2>
		<div class="col1-contentor">
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-th" data-fa-transform="shrink-8" alt="Acesso direto no ecrã" title="Acesso direto no ecrã"></i></span>Atalho no ecrã principal (tipo aplicação)</h3>
				<p>Depois de abrir o endereço, no navegador Web do telemóvel, pode carregar no menu principal do navegador e escolher "Adicionar ao ecrã principal".
					<br>Será criado um ícone especial no seu ecrã de entrada e ficará com um acesso tipo App ao catálogo.
				</p>
				<p>Não é necessário instalar qualquer aplicação mas funciona de forma semelhante!
				</p>
			</div>
			<div class="col1">
					<img src="imagens/ajuda/movel_adicionar.png" alt="Menu do navegador Web" title="Adicionar ao ecrã principal do telemóvel" border=0 align="center">
			</div>
		</div>
		<br style="clear:left" />
		<div class="destaquetexto1">
			<h4 align="left"><span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Dúvidas" title="Dúvidas"></i></span>Dúvidas sobre utilização em telemóveis?</h4>
			<p>Encontre respostas (e sugestões de aplicações QR Code) aqui: <a style="text-decoration:none" href="https://sites.google.com/view/pesquisarcatalogo/movel" target="_blank">https://sites.google.com/view/pesquisarcatalogo/movel</a>
			</p>
			<p>Em caso de dúvidas, dirija-se à biblioteca mais próxima onde o podem ajudar nas pesquisas e empréstimos.
				<br>Boas leituras!
			</p>
		</div>
		<div align="center" style="clear:both" class="txtvoltar">
			<a style="text-decoration:none" href="default.asp">
				<input type="button" name="bt2" value="Voltar" class="botao botao5" ;>
			</a>
		</div>
	</div>
	<br>
	<br>
</body>

</html>
