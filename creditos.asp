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
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Cr�ditos - <%=stitulo%></title>
	<link rel="stylesheet" href="css/default.min.css?version=001" type="text/css" />
	<script type="text/javascript" src="js/geral.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" crossorigin="anonymous"></script>
	<script>
		if (typeof jQuery == 'undefined') {
            document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
        }
    </script>
	<script defer async src="https://use.fontawesome.com/releases/v5.3.1/js/all.js" integrity="sha384-kW+oWsYx3YpxvjtZjFXqazFpA7UP/MbiY4jvs+RWZo2+N94PFZ36T6TFkc9O3qoB" crossorigin="anonymous"></script>
	<meta name="description" content="Cr�ditos e informa��es - XPTO - Cat�logo coletivo da Rede de Bibliotecas do concelho" />
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
	<meta property="og:title" content="Cr�ditos - XPTO - Rede de bibliotecas" />
	<meta property="og:description" content="XPTO: Cat�logo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos existentes nas bibliotecas deste concelho" />
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
			<p class="fil">� <a href="default.asp">Entrada</a> � Ajuda: Dicas de pesquisa</p>
		</div>
		<div class="col3" id="lblutilizador">Utilizador:
			<% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
		</div>
	</div>
	<!-- Segmento Navega��o topo - FIM -->
	<br>
	<div id="principal">
		<div class="col5-contentor" style="width:100%">
			<div class="col5">
				<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fas fa-info" data-fa-transform="shrink-8" alt="Informa��es" title="Informa��es"></i></span><br>Informa��es sobre o cat�logo</h3>
				<dl>
					<dt>Propriedade e gest�o do cat�logo:</dt>
					<dd>
						<%=sentidadelonga%>
					</dd>
				</dl>
				<div align="center"><img src="<%=slogo%>" alt="Log�tipo da Rede" title="Log�tipo da Rede"></div>
				<br>
			</div>
			<div class="col5">
				<div class="destaquetexto1">
					<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fas fa-id-card" data-fa-transform="shrink-8" alt="Contactos da rede de bibliotecas" title="Contactos da rede de bibliotecas"></i></span><br>Contactos</h3>
					<dl>
						<dt>Portal da Rede Concelhia</dt>
						<dd>Atividades e recursos - Visitar s�tio
							<br>
							<a href="<%=surlPORTAL%>" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" alt="Not�cias das bibliotecas" title="Not�cias das bibliotecas"></i></span>S�tio web da rede</a></dd>
						<br>
						<dt>Contactos individuais das bibliotecas parceiras</dt>
						<dd>Descarregar listagem completa (PDF)
							<br>
							<a href="admin/fpdf/main.asp" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="far fa-file-pdf" data-fa-transform="shrink-8" alt="Bibliotecas parceiras - PDF" title="Bibliotecas parceiras - PDF"></i></span>Contactos das Bibliotecas (PDF)</a></dd>
					</dl>
					<br>
				</div>
			</div>
		</div>
		<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fab fa-cuttlefish" data-fa-transform="shrink-8" alt="Direitos de autor" title="Direitos de autor"></i></span><br>Direitos de autor</h3>
		<dl>
			<dt>Direitos de autor e de utiliza��o</dt>
			<dd>Direitos do cat�logo coletivo e conte�dos:
				<%=sentidadelonga%>
			</dd>
			<dd>� permitida a impress�o ou exporta��o dos registos bibliogr�ficos para utiliza��o individual ou por outras bibliotecas.</dd>
			<dd>N�o � permitida a comercializa��o dos registos bibliogr�ficos nem a sua disponibiliza��o em pacotes comerciais.</dd>
		</dl>
		<br>
		<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fas fa-user-secret" data-fa-transform="shrink-8" alt="Privacidade e dados pessoais" title="Privacidade e dados pessoais - RGPD"></i></span><br>Prote��o de dados pessoais</h3>
    <p>O sistema de OPAC apenas permite a funcionalidade de pesquisa de documentos em bases de dados bibliogr�ficas. N�o existem funcionalidades de empr�stimos ou de coment�rios nem utiliza��o de dados pessoais.
    </p>
		<dl>
			<dt>Privacidade e cumprimento do Regulamento Geral da Prote��o de Dados (RGPD)</dt>
			<dd>Informa��o pessoal utilizada: n�o � utilizada qualquer informa��o pessoal de visitantes, leitores ou de t�cnicos de bibliotecas.</dd>
			<dd>Dados de utilizadores: N�o existem contas de utilizador individuais. As contas dos utilizadores institucionais n�o utilizam dados pessoais.</dd>
			<dd>Dados bibliogr�ficas s�o neutros: As bases de dados s�o fornecidas e atualizadas pelas bibliotecas parceiras de cada cat�logo.</dd>
			<dd>Contactos de bibliotecas s�o neutros e p�blicos: As informa��es sobre bibliotecas s�o dados dispon�veis publicamente e restritos a: Entidade da biblioteca, morada, telefone e endere�o de email. Estes dados foram fornecidos pelos respons�veis pelas bibliotecas listadas e s�o edit�veis pelos pr�prios utilizando a autentica��o interna da sua biblioteca.</dd>
			<dd>Informa��o de navega��o recolhida/Cookies: na opera��o do sistema na web n�o � recolhida informa��o pessoal dos visitantes. Pode existir recolha an�nima de dados atrav�s de Cookies destinados apenas ao funcionamento t�cnico do software. Ver <a style="text-decoration:none" href="https://sites.google.com/view/opacrbe/utilizadores" target="_blank" rel="noopener">mais detalhes aqui</a></dd>
			<br>
			<div class="col5-contentor" style="width:100%">
				<div class="col5">
					<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fa fa-puzzle-piece" data-fa-transform="shrink-9" alt="Cr�ditos" title="Cr�ditos e tecnologia"></i></span><br>Cr�ditos e tecnologia</h3>
					<dl>
						<dt>Cataloga��o e bases bibliogr�ficas</dt>
						<dd>Bibliotecas parceiras da
							<a style="text-decoration:none" href="<%=surlPORTAL%>" target="_top">
								<%=sentidadelonga%>
							</a>
						</dd>
						<br>
						<dt>Tecnologia do Cat�logo:</dt>
						<dd>Software OIR - Desenvolvido pela Rede de Bibliotecas Escolares
							<br>
							<a style="text-decoration:none" href="<%=surlRBE%>" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" alt="RedesConcelhias.RBE" title="RedesConcelhias.RBE"></i></span>Projeto RedesConcelhias.RBE <img src="imagens/logotipo_rbe.png" alt="Rede de Bibliotecas Escolares" title="Rede de Bibliotecas Escolares" width="169" height="40" border=0 align="absmiddle" hspace="3"></a></dd>
					</dl>
					<br>
				</div>
				<div class="col5">
					<div class="destaquetexto1">
						<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch"></i><i class="fas fa-folder-open" data-fa-transform="shrink-8" alt="Guias" title="Guias e Tutoriais"></i></span><br>Guias de utiliza��o</h3>
						<dl>
							<dt>Guia do utilizador (B�sico)</dt>
							<dd><a style="text-decoration:none" href="ajuda_dicas.asp"><a style="text-decoration:none" href="ajuda_dicas.asp"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Como pesquisar" title="Como pesquisar"></i></span>Ajuda: Dicas de pesquisa</a></dd>
							<dd><a style="text-decoration:none" href="ajuda_identificar.asp"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Como identificar bibliotecas" title="Como identificar bibliotecas"></i></span>Ajuda: Como identificar bibliotecas</a></dd>
							<br>
							<dt>Guia do utilizador (Avan�ado)</dt>
							<dd>
								<a href="https://sites.google.com/view/pesquisarcatalogo/" target="_blank" rel="noopener">
									<span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="S�tio de apoio a utilizadores" title="S�tio de apoio � utiliza��o do Cat�logo"></i></span>Apoio � utiliza��o do Cat�logo</a>
							</dd>
							<br>
							<dt>Apoio a bibliotec�rios</dt>
							<dd>
								<a href="https://sites.google.com/view/opacrbe/biblio" target="_blank" rel="noopener">
									<span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" alt="S�tio de apoio a bibliotec�rios" title="Bibliotec�rios - S�tio de apoio"></i></span>Administra��o e utiliza��o do Cat�logo</a>
							</dd>
							<br>
							<dt>Apoio a t�cnicos de inform�tica</dt>
							<dd><a href="https://sites.google.com/view/opacrbe/tec" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="S�tio de apoio a t�cnicos" title="T�cnicos - S�tio de apoio"></i></span>Instala��o e manuten��o do Cat�logo</a></dd>
						</dl>
						<br>
					</div>

				</div>
			</div>
			<br>
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
