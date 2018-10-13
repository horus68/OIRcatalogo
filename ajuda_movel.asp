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
	<title>Cat�logo no telem�vel - <%=stitulo%></title>
	<link rel="stylesheet" href="css/default.min.css?version=001" type="text/css" />
	<script type="text/javascript" src="js/geral.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" crossorigin="anonymous"></script>
	<script>
		if (typeof jQuery == 'undefined') {
            document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
        }
    </script>
	<script defer async src="https://use.fontawesome.com/releases/v5.3.1/js/all.js" integrity="sha384-kW+oWsYx3YpxvjtZjFXqazFpA7UP/MbiY4jvs+RWZo2+N94PFZ36T6TFkc9O3qoB" crossorigin="anonymous"></script>
	<meta name="description" content="Como utilizar o cat�logo coletivo em telem�veis - XPTO - Cat�logo coletivo da Rede de Bibliotecas do concelho" />
	<meta name="keywords" content="Cat�logo coletivo, Bibliotecas, pesquisar biblioteca, OPAC, registo bibliogr�fico" />
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
	<meta property="og:title" content="Cat�logo no telem�vel - XPTO - Rede de bibliotecas" />
	<meta property="og:description" content="XPTO: Como utilizar o cat�logo coletivo em telem�veis. Pesquise os documentos existentes nas bibliotecas deste concelho" />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Cat�logo - XPTO - Rede de bibliotecas" />
</head>

<body>
	<div class="destaque1">
		<h1>Cat�logo Coletivo:
			<%=sentidadelonga%>
		</h1>
	</div>
	<!-- Segmento Navega��o topo -->
	<div class="col3-contentor">
		<div class="col3">
			<p class="fil">� <a href="default.asp">Entrada</a> � Ajuda: Usar no telem�vel </p>
		</div>
		<div class="col3" id="lblutilizador">Utilizador:
			<% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
		</div>
	</div>
	<!-- Segmento Navega��o topo - FIM -->
	<div id="principal">
		<div align="center">
			<img src="<%=slogo%>" alt="Log�tipo">
		</div>
		<h2><span class="fa-layers fa-fw" style="font-size:3em"><i class="fas fa-circle-notch"></i><i class="fas fa-graduation-cap" data-fa-transform="shrink-8" alt="Utilizar o cat�logo coletivo em telem�veis" title="Utilizar o cat�logo coletivo em telem�veis"></i></span>Como utilizar o cat�logo em telem�veis?</h2>
		<div class="col1-contentor">
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-mobile-alt" data-fa-transform="shrink-8" alt="Utiliza��o em telem�veis" title="Utiliza��o em telem�veis"></i></span>No navegador Web e sem aplica��es</h3>
				<p>Pode utilizar o cat�logo no telem�vel com o seu navegador Web habitual, basta entrar no endere�o do cat�logo.
					<br>O cat�logo adapta-se ao seu ecr� e ter� as mesmas funcionalidades que num computador.
					<br><img src="imagens/ajuda/movel_entrada.png" alt="Cat�logo no telem�vel" title="Cat�logo no telem�vel" border=0 align="center">
					<br>Dica: No Google pesquise por "cat�logo + rede bibliotecas + nome do seu concelho"
				</p>
			</div>
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-qrcode" data-fa-transform="shrink-8" alt="QR Code" title="QR Code"></i></span>Entrar por QR Code</h3>
				<p>Escreva o endere�o no navegador ou capture a imagem com o leitor de QR Code do seu telem�vel.</p>
				<p>No seu telem�vel, abra a aplica��o de QR Code e aponte para esta imagem:
					<br>
					<br>
					<img src="imagens/app/qrcode.png" alt="Liga��o em QR Code para o cat�logo" title="Liga��o em QR Code para o cat�logo" border=0 align="center">
					<br>
					<br>A aplica��o vai ler o c�digo diretamente do ecr�. Carregue no endere�o que aparece na aplica��o e entrar� no cat�logo.
				</p>
			</div>
					<br>
		</div>
		<br style="clear:left" />
				<h2>Tenha o cat�logo sempre � m�o... no telem�vel</h2>
		<div class="col1-contentor">
			<div class="col1">
				<h3><span class="fa-layers fa-fw" style="font-size:2.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-th" data-fa-transform="shrink-8" alt="Acesso direto no ecr�" title="Acesso direto no ecr�"></i></span>Atalho no ecr� principal (tipo aplica��o)</h3>
				<p>Depois de abrir o endere�o, no navegador Web do telem�vel, pode carregar no menu principal do navegador e escolher "Adicionar ao ecr� principal".
					<br>Ser� criado um �cone especial no seu ecr� de entrada e ficar� com um acesso tipo App ao cat�logo.
				</p>
				<p>N�o � necess�rio instalar qualquer aplica��o mas funciona de forma semelhante!
				</p>
			</div>
			<div class="col1">
					<img src="imagens/ajuda/movel_adicionar.png" alt="Menu do navegador Web" title="Adicionar ao ecr� principal do telem�vel" border=0 align="center">
			</div>
		</div>
		<br style="clear:left" />
		<div class="destaquetexto1">
			<h4 align="left"><span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="D�vidas" title="D�vidas"></i></span>D�vidas sobre utiliza��o em telem�veis?</h4>
			<p>Encontre respostas (e sugest�es de aplica��es QR Code) aqui: <a style="text-decoration:none" href="https://sites.google.com/view/pesquisarcatalogo/movel" target="_blank">https://sites.google.com/view/pesquisarcatalogo/movel</a>
			</p>
			<p>Em caso de d�vidas, dirija-se � biblioteca mais pr�xima onde o podem ajudar nas pesquisas e empr�stimos.
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
