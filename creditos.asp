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

  sversao = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "versao")
  surlRBE = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "urlRBE")
  surlPORTAL = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "urlPORTAL")
  sentidadelonga = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "entidadelonga")
  stitulo = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "PORTAL", "titulo")
  slogo = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "PORTAL", "imglogo")
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="pt" lang="pt">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="robots" content="follow,index" />
	<meta name=viewport content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Créditos - <%=stitulo%></title>
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
	<meta name="description" content="Créditos e informações - Catálogo coletivo da Rede de Bibliotecas do Concelho"/>
	<meta name="keywords" content="Catálogo coletivo, Bibliotecas, pesquisar biblioteca" />
	<meta name="author" content="Rede Concelhia de Bibliotecas" />
  <meta property="og:title" content="Catálogo - Rede de bibliotecas" />
  <meta property="og:type" content="library" />
  <meta property="og:site_name" content="Catálogo - Rede de bibliotecas" />
  <meta property="og:description" content="Catálogo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos existentes nas bibliotecas deste concelho" />
</head>
<body>
  <div class="destaque1">
    <h3>Catálogo Coletivo: <%=sentidadelonga%></h3>
  </div>
<!-- Segmento Navegação topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">» <a href="default.asp">Entrada</a> » Ajuda: Dicas de pesquisa</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
    </div>
  </div>
<!-- Segmento Navegação topo - FIM -->
	<br /> 
  <div id="principal">
  <div class="col5-contentor" style="width:100%">
    <div class="col5">
  <h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fas fa-info" data-fa-transform="shrink-8" title="Informações"></i></span><br />Informações sobre o catálogo</h3> 
		<dl>
		<dt>Propriedade e gestão do catálogo:</dt>
			<dd><%=sentidadelonga%></dd>	
			</dl>
			<div align="center"><img src="<%=slogo%>" alt="Logótipo da Rede" title="Logótipo da Rede"></div>
		<br />    
    </div>
    <div class="col5">
	<div class="destaquetexto1">	
	<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fas fa-id-card" data-fa-transform="shrink-8" title="Contactos da rede de bibliotecas"></i></span><br />Contactos</h3>
      <dl>
		<dt>Portal da Rede Concelhia</dt>
			<dd>Atividades e recursos - Visitar sítio<br />
			<a href="<%=surlPORTAL%>" target="_top"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="Notícias das bibliotecas"></i></span>Sítio web da rede</a></dd>
			<br />
		<dt>Contactos individuais das bibliotecas parceiras</dt>
			<dd>Descarregar listagem completa<br />
			<a href="admin/fpdf/main.asp" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="far fa-file-pdf" data-fa-transform="shrink-8" title="Bibliotecas parceiras - PDF"></i></span>Contactos das Bibliotecas (PDF)</a></dd>
		</dl>
			<br />
    </div>    
    </div>
  </div>
	<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fab fa-cuttlefish" data-fa-transform="shrink-8" title="Direitos de autor"></i></span><br />Direitos de autor</h3> 
		<dl>
		<dt>Direitos de autor e de utilização</dt>
			<dd>Direitos do catálogo coletivo e conteúdos: <%=sentidadelonga%></dd>
			<dd>É permitida a impressão ou exportação dos registos bibliográficos para utilização individual ou por outras bibliotecas.</dd>
			<dd>Não é permitida a comercialização dos registos bibliográficos nem a sua disponibilização em pacotes comerciais.</dd>	
			</dl>
		<br />
	<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fas fa-user-secret" data-fa-transform="shrink-8" title="Privacidade e dados pessoais - RGPD"></i></span><br />Proteção de dados pessoais</h3> 
<dl>
<dt>Privacidade e cumprimento do Regulamento Geral da Proteção de Dados (RGPD)</dt>
<dd>Informação utilizada: não é utilizada qualquer informação pessoal de visitantes, leitores ou de técnicos de bibliotecas.</dd>
<dd>O sistema de OPAC permite apenas a funcionalidade de pesquisa de documentos em bases de dados bibliográficas. Não existem funcionalidades de empréstimos ou de comentários.</dd>
<dd>Não existem contas de utilizador individuais. As contas dos utilizadores institucionais não utilizam dados pessoais.</dd>
<dd>As bases de dados bibliográficas são fornecidas e atualizadas pelas bibliotecas parceiras de cada catálogo.</dd>
<dd>As informações sobre bibliotecas são dados de contacto disponíveis publicamente: Entidade da biblioteca, morada, telefone e endereço de email.
Estes dados foram fornecidos pelos responsáveis pelas bibliotecas listadas e são editáveis pelos próprios utilizando a autenticação interna da sua biblioteca.</dd>
<dd>Informação de navegação recolhida/Cookies: na operação do sistema na web não é recolhida informação pessoal dos visitantes.
Pode existir recolha anónima de dados através de cookies destinados apenas ao funcionamento do programa. 
Ver <a style="text-decoration:none" href="https://sites.google.com/view/opacrbe/utilizadore" target="_blank" rel="noopener">mais detalhes aqui</a></dd>
		<br />
  <div class="col5-contentor" style="width:100%">
    <div class="col5">
	<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fa fa-puzzle-piece" data-fa-transform="shrink-9" title="Créditos e tecnologia"></i></span><br />Créditos e tecnologia</h3> 
		<dl>
		<dt>Catalogação e bases bibliográficas</dt>
			<dd>Bibliotecas parceiras da <a style="text-decoration:none" href="<%=surlPORTAL%>" target="_top"><%=sentidadelonga%></a></dd>
			<br />
		<dt>Tecnologia do Catálogo:</dt>
			<dd>Software OIR - Desenvolvido pela Rede de Bibliotecas Escolares<br />
			<a style="text-decoration:none" href="<%=surlRBE%>" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="RBE.RedesConcelhias"></i></span>Projeto RBE.RedesConcelhias <img src="imagens/logotipo_rbe.png" alt="Rede de Bibliotecas Escolares" title="Rede de Bibliotecas Escolares" width="169" height="40" border=0 align="absmiddle" hspace="3"></a></dd>
		</dl>
	<br />
    </div>
    <div class="col5">
	<div class="destaquetexto1">			
	<h3><span class="fa-layers fa-fw" style="font-size:4em"><i class="fas fa-circle-notch" ></i><i class="fas fa-folder-open" data-fa-transform="shrink-8" title="Guias e Tutoriais"></i></span><br />Guias de utilização</h3> 
      <dl>
		<dt>Guia do utilizador (Básico)</dt>
			<dd><a style="text-decoration:none" href="ajuda_dicas.asp"><a style="text-decoration:none" href="ajuda_dicas.asp"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-question" data-fa-transform="shrink-8" title="Como pesquisar"></i></span>Ajuda: Dicas de pesquisa</a></dd>
			<dd><a style="text-decoration:none" href="ajuda_identificar.asp"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-question" data-fa-transform="shrink-8" title="Como identificar bibliotecas"></i></span>Ajuda: Como identificar bibliotecas</a></dd>
				<br />			
		<dt>Guia do utilizador (Avançado)</dt>
		<dd><a href="https://sites.google.com/view/pesquisarcatalogo/" target="_blank" rel="noopener">
		<span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="Sítio de apoio à utilização do Catálogo"></i></span>Apoio à utilização do Catálogo </a></dd>
				<br />	
		<dt>Apoio a bibliotecários</dt>
			<dd><a href="https://sites.google.com/view/opacrbe/biblio" target="_blank" rel="noopener">
			<span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="Bibliotecários - Sítio de apoio"></i></span>Administração e utilização do Catálogo</a></dd>
				<br />	
		<dt>Apoio a técnicos informáticos</dt>	
			<dd><a href="https://sites.google.com/view/opacrbe/tec" target="_blank" rel="noopener"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" title="Técnicos - Sítio de apoio"></i></span>Instalação e manutenção do Catálogo</a></dd>
			</dl>
		<br />
    </div>

    </div>
  </div>
	<br />
	<div align="center" style="clear:both" class="txtvoltar">
	<a style="text-decoration:none" href="default.asp"><input type="button" name="bt2" value="Voltar" class="botao botao5";></center>
	</div> 
</div>
		<br />
	<br />
</body>
</html>
