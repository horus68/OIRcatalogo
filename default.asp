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
%>
<!DOCTYPE html "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="pt-PT" lang="pt-PT">

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name=viewport content="width=device-width, initial-scale=1" />
	<meta name="robots" content="index, follow" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>Cat�logo - <%=stitulo%></title>
	<link rel="stylesheet" href="css/default.min.css?v=001" type="text/css" />
	<script defer type="text/javascript" src="js/geral.min.js"></script>
	<link rel="dns-prefetch" href="https://www.google-analytics.com">
	<link rel="dns-prefetch" href="https://ajax.googleapis.com">
	<link rel="dns-prefetch" href="https://use.fontawesome.com">
	<link rel="dns-prefetch" href="https://cdnjs.cloudflare.com">
	<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js" crossorigin="anonymous"></script>
	<script>
		if (typeof jQuery == 'undefined') {
			document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
		}

	</script>
	<script type="text/javascript" src="js/jqueryRater/jquery.rater.min.js"></script>
	<script defer async src="https://use.fontawesome.com/releases/v5.3.1/js/all.js" integrity="sha384-kW+oWsYx3YpxvjtZjFXqazFpA7UP/MbiY4jvs+RWZo2+N94PFZ36T6TFkc9O3qoB" crossorigin="anonymous"></script>
	<meta name="description" content="Cat�logo coletivo da Rede de Bibliotecas do Concelho - XPTO - Pesquise os documentos no OPAC e saiba onde os pode requisitar. Ler, ver, sentir e viver" />
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
	<!-- Favicon iOS -->
	<link rel="apple-touch-icon-precomposed" href="/rbcatalogo/imagens/app/apple-touch-icon-precomposed.png?v=001" />
	<link rel="mask-icon" href="/rbcatalogo/imagens/app/safari-pinned-tab.svg?v=001" color="#5bbad5" />
	<!-- OpenGraph Facebook -->
	<meta property="og:title" content="XPTO - Cat�logo da Rede de bibliotecas" />
	<meta property="og:description" content="XPTO: Cat�logo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos no OPAC e saiba onde os pode requisitar. Ler, ver, sentir e viver" />
	<meta property="og:image" content="http://www.pesquisardocumentos.com/rbcatalogo/partilhasocial.png" />
	<meta property="og:type" content="website" />
	<meta property="og:site_name" content="Cat�logo - XPTO - Rede de bibliotecas de XPTO" />
	<meta property="og:locale" content="pt_PT" />
	<span itemscope itemtype="http://schema.org/Organization">
		<meta itemprop="name" content="XPTO" />
		<meta itemprop="alternateName" content="XPTO" />
		<meta itemprop="description" content="Cat�logo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos no OPAC e saiba onde os pode requisitar. Ler, ver, sentir e viver">
		<meta itemprop="url" href="http://www.pesquisardocumentos.com/rbcatalogo/" />
		<meta itemprop="logo" src="http://www.pesquisardocumentos.com/rbcatalogo/imagens/logotipo.png" />
		<meta itemprop="image" src="http://www.pesquisardocumentos.com/rbcatalogo/partilhasocial.png" />
		<meta itemprop="sameAs" href="https://www.facebook.com/rbeportugal/" />
	</span>
	<!-- Dublin Core metadata -->
	<link rel="schema.DC" href="http://purl.org/dc/elements/1.1/">
	<meta name="DC.Title" content="Cat�logo RB XPTO" />
	<meta name="DC.Creator" content="RB XPTO" />
	<meta name="DC.Publisher" content="Projeto RedesConcelhias.RBE">
	<meta name="DC.Subject" content="OPAC, cat�logo, registo bibliogr�fico, biblioteca" />
	<meta name="DC.Description" content="Cat�logo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos e saiba onde os pode requisitar" />
	<meta name="DC.date.created" content="2018-07-20" />
	<meta name="DC.type" content="Dataset">
	<meta name="DC.Format" content="text/html">
	<meta name="DC.Source" content="Cat�logos das bibliotecas integrantes da Rede Concelhia" />
	<meta name="DC.Language" content="pt-PT" />
	<meta name="DC.audience" content="leitores, bibliotecas, docentes, alunos" />
	<meta name="DC.coverage" content="Portugal" />
	<!-- C�digo Google Analytics - Global site tag (gtag.js) -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-71820207-1" defer crossorigin="anonymous"></script>
	<script>window.dataLayer = window.dataLayer || [];  function gtag(){dataLayer.push(arguments);} gtag('js', new Date());  gtag('config', 'UA-71820207-1');</script>
	<!-- Registo de service works para m�veis - Utilizar apenas em https
    <script>
    if ('serviceWorker' in navigator) {
    navigator.serviceWorker.register('/rbcatalogo/sw.js');
    }
    </script> -->
</head>

<body>
	<div class="destaque1">
		<h1 style="font-variant: small-caps">Cat�logo Coletivo<br />
			<%=sentidadelonga%>
		</h1>
	</div>
	<!-- Segmento Destaque Promo -->
	<div class="destaquepromo">
		<p align="center">Pesquise. Encontre. Contacte. Visite. Requisite. Leia. Sinta. Viva.</p>
	</div>
	<!-- Segmento Destaque Promo - FIM -->
	<!-- Segmento Alerta Manuten��o -->
	<% if session("portal")="N" then %>
	<br>
	<h3 style="color:red">O cat�logo encontra-se em MANUTEN��O.<br> Retomaremos o servi�o logo que poss�vel...</h3>
	<%else %>
	<!-- Segmento Alerta Manuten��o - FIM -->
	<!-- Segmento Navega��o de topo autenticado - Reservas desativado -->
	<%if Session("LoggedIn") or session("LeitorIn") then %>
	<div class="navegatopo">
		<% if session("nuser")<>"" then %>
		<a href="javascript:void(0)" onclick="javascript:alterarPin()" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch"></i><i class="fas fa-user" data-fa-transform="shrink-8" alt="Alterar o meu PIN" title="Alterar o meu PIN"></i></span></a>
		<% end if%>
		<!--
  <%if (session("user")<>"" and session("user")<>"ADMIN") or session("nuser")<>"" then %> <a href="javascript:void(0)" onclick="javascript:build_reservas(&quot;<%=session("user")%>&quot;,&quot;<%=session("nuser")%>&quot;)" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-shopping-cart" data-fa-transform="shrink-9" alt="As minhas reservas" title="As minhas reservas"></i></span></a><br>
  <% end if%>
-->
		<% if session("LoggedIn") then response.write "Utilizador: " &  DecodeUTF8(session("user"))%>
		<% if Session("LoggedIn") or session("LeitorIn") then %> [ <a href="logout.asp?sys=admin" rel="nofollow">Sair</a> ]
		<% end if%>
		<%if Session("LoggedIn") then %><br><a href="admin/admin.asp" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:1.5em"><i class="fas fa-circle-notch"></i><i class="fas fa-cog" data-fa-transform="shrink-8" alt="Administra��o" title="Administra��o"></i></span>Ir para zona de administra��o</a>
		<% end if%>
	</div>
	<% end if%>
	<!-- Segmento Navega��o de topo autenticado FIM -->
	<!-- Segmento Pesquisas - Tipo -->
	<h2 style="font-variant: small-caps">Escolha um tipo de pesquisa</h2>
	<div class="col1-contentor" style="text-align:center;">
		<div class="col1">
			<h4 style="font-variant: small-caps"><a href="catpesq.asp?id=0&bd=col">Pesquisa Simplificada</a></h4>
			<p><a href="catpesq.asp?id=0&bd=col" alt="Pesquisa r�pida" title="Pesquisa tudo"><span class="fa-layers fa-fw" style="font-size:6.0em"><i class="fas fa-circle-notch"></i><i class="fab fa-searchengin" data-fa-transform="shrink-7"></i></span></a>
				<br> Rapidez. Basta escrever uma ou mais palavras
				<br>
				<i>(ir� procurar em todos os dados ao mesmo tempo)</i></p>
		</div>
		<div class="col1">
			<h4 style="font-variant: small-caps"><a href="catpesq.asp?id=1&bd=col">Pesquisa orientada</a></h4>
			<p><a href="catpesq.asp?id=1&bd=col" alt="Pesquisa detalhada" title="Pesquisa com detalhe"><span class="fa-layers fa-fw" style="font-size:6.0em"><i class="fas fa-circle-notch"></i><i class="fas fa-crosshairs" data-fa-transform="shrink-8"></i></span></a>
				<br> Exatid�o. Para quando se sabe o que se pretende encontrar
				<br>
				<i>(ou limitar a pesquisa a algumas bibliotecas)</i></p>
		</div>
		<div class="col1">
			<h4 style="font-variant: small-caps"><a href="catindex.asp">Listas de termos</a></h4>
			<p><a href="catindex.asp" alt="Listagem de termos" title="Navega numa listagem"><span class="fa-layers fa-fw" style="font-size:6.0em"><i class="fas fa-circle-notch"></i><i class="fas fa-sort-alpha-down" data-fa-transform="shrink-7"></i></span></a>
				<br> Organiza��o. Navegar no cat�logo sem ter de escrever
				<br>
				<i>(e descobrir o que nem se sabe que existe)</i></p>
		</div>
		<!--<% if ucase(session("user"))="ADMIN" or session("LeitorIn") then %>
    <div class="col1">
        <h4><a href="catpesq.asp?id=3&bd=col" rel="nofollow">Etiquetas pessoais</a></h4>
        <p><a href="catpesq.asp?id=3&bd=col" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:6.0em"><i class="fas fa-circle-notch" ></i><i class="fas fa-tags" data-fa-transform="shrink-9"></i></span></a>
            <br> Etiquetas criadas pelos leitores
            <br><i>(dispon�vel apenas a leitores autenticados)</i></p>
  </div>
    </div><%end if%>-->
	</div>
	<!-- Segmento Pesquisas - Tipo - FIM -->
	<br>
	<!-- Segmento Top T�tulos -->
	<div class="col-contentor">
		<div class="col">
			<%
        if ubound(votos)>0 then 
    %>
			<fieldset style="margin:5px 5px 0 0;padding:5px">
				<legend>Top t�tulos</legend>
				<br>
				<table style="width:100%;font-size:0.9em">
					<% on error resume next
                s="":t="":u="":x=""
			    for i=1 to ubound(votos)-1 step 4
				criterio=replace(replace(votos(i),"^a",""),"^b","")

				strURL=strROOT & "/cgi/www.exe/[in=gettit.in]?base=rbcatalogo&expr=" & criterio   '& string(7 - Len(votos(i)),"0") & votos(i)
				strHTML=getUrl(strURL)

				if strHTML<>"" then
					tmp=split(strHTML,"�")
					
					if ubound(tmp)>2 then
						med=Clng(tmp(2))/Clng(tmp(3))
						s=s & med & "#":t=t & tmp(0) & "�":z=z & tmp(4) & "�"             'string(7 - Len(votos(i)),"0") & votos(i) & "," 				
					end if
				end if
			     next
			     if s<>"" then
   
					v=split(s,"#"):	t0=split(t,"�"): t3=split(z,"�")
					
					sortArrayD v, t0, t3
					if session("user")="" then us="guest" else us=session("user") 
					limite=4
					if ubound(v)<5 then limite=ubound(v)-1
					for i=0 to limite
					 response.write "<tr><td width=""70%"" align=""left""><a style=""text-decoration:none"" href=""/rbcatalogo/cgi/www.exe/[in=pesqger.in]?base=rbcatalogo&expressao="+t3(i)+"&limites=25&lim_inicio=1&formato=wiusr&id=0&nomenu=catpesq.asp&ut="& us & "&nut=" &session("nuser") &""">" &replace(replace(t0(i),"<",""),">","") &"</a></td><td width=""30"" align=""left""><span class=""ui-rater""><span class=""ui-rater-starsOff"" style=""width:90px;""><span class=""ui-rater-starsOn"" style=""width:"&round(v(i)*18,0)&"px""></span></span></span> (" & round(v(i),1) & ") </td></tr>"   '<td> votos:" & string(4 - Len(t2(i)),chr(160)) & t2(i) &"</td>'
					next
			     end if
			     on error goto 0		
			 %>
				</table>
				<br>
			</fieldset>
			<% end if %>
		</div>
		<div class="col">
			<p class="fil"><a style="text-decoration:none" href="ajuda_dicas.asp">
					<span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Como pesquisar" title="Como pesquisar"></i>
					</span>Ajuda - <b>Dicas de pesquisa</b></a>
				<br />Pequenos truques para obter melhores resultados
				<br />na pesquisa de documentos
			</p>
			<p class="fil"><a style="text-decoration:none" href="ajuda_identificar.asp">
					<span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Como identificar bibliotecas" title="Como identificar bibliotecas"></i>
					</span>Ajuda - <b>Identificar e localizar bibliotecas</b></a>
				<br />A pesquisa permite identificar no mapa
				<br />a biblioteca que tenha o documento pretendido
			</p>
			<p class="fil"><a style="text-decoration:none" href="ajuda_movel.asp">
					<span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-question" data-fa-transform="shrink-8" alt="Como identificar bibliotecas" title="Como identificar bibliotecas"></i>
					</span>Ajuda - <b>Usar o cat�logo no telem�vel</b></a>
				<br />Aceder no telem�vel sem instalar aplica��es
				<br />Pode entrar com acesso por QR Code
			</p>
		</div>
	</div>
	<!-- Segmento Top T�tulos - FIM -->
	<!-- Segmento Extra -->
	<div>
		<p align="center"><span class="fa-layers fa-fw" style="font-size:1.8em"><i class="fas fa-circle-notch"></i><i class="fas fa-book" data-fa-transform="shrink-8" alt="O que pode fazer aqui?" title="O que pode fazer aqui?"></i></span>Pesquise os <b>documentos</b> existentes nas <b>bibliotecas</b> deste concelho.
			<br>
			<b>Contacte ou visite</b> a biblioteca onde esteja o livro ou audiovisual que pretende <b>consultar</b>.
			<br />Conhe�a ainda as <b>atividades</b> das nossas bibliotecas ao visitar o nosso <b>portal</b>.
		</p>
	</div>
	<!-- Segmento Extra FIM -->
	<!-- Segmento M�vel e Antiframe -->
	<div id="noprint">
		<br>
		<p align="center"><span class="fa-layers fa-fw" style="font-size:1.8em"><i class="fas fa-circle-notch"></i><i class="fas fa-desktop" data-fa-transform="shrink-9" alt="Abrir numa janela a toda a largura" title="Abrir numa janela a toda a largura"></i></span><b><i>Est� a ver no computador?</i></b><br>Abra no telem�vel capturando este QR Code:
			<br>
			<img src="imagens/app/qrcode.png" alt="Liga��o em QR Code para o cat�logo" title="Capture a imagem com o leitor de QR Code do seu telem�vel" border=0 align="center">
			<br> Nota: depois de abrir o endere�o, no browser do telem�vel, pode carregar em
			<br> "Adicionar ao ecr� principal" e ficar� com uma App para o cat�logo (ver <a href="ajuda_movel.asp">ajuda aqui</a>).</p>
		<br>
		<p align="center"><span class="fa-layers fa-fw" style="font-size:1.8em"><i class="fas fa-circle-notch"></i><i class="fas fa-mobile-alt" data-fa-transform="shrink-8" talt="Abrir numa janela a toda a largura" title="Abrir numa janela a toda a largura"></i></span><b><i>Est� a ver no telem�vel ou numa janela pequena?</i></b>
			<br>
			<a href="default.asp" target="_blank" rel="noopener">
				<button type="button" class="botao botao5" style="width:50%;">Carregue aqui para abrir numa janela a toda a largura</button>
			</a>
		</p>
		<br>
	</div>
	<br>
	<!-- Segmento M�vel e Antiframe - FIM -->
	<!-- Segmento Log�tipo -->
	<br>
	<div class="col2-contentor">
		<div class="col2">
			<p class="rodape" align="center" style="font-variant: small-caps"><a style="text-decoration:none" href="creditos.asp">Infos e Cr�ditos do Cat�logo Coletivo:<br> &copy; <b>
						<%=sentidadelonga%> </b><span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-info" data-fa-transform="shrink-8" alt="Informa��es t�cnicas e cr�ditos do cat�logo" title="Informa��es t�cnicas e cr�ditos do cat�logo"></i></span></a></p>
		</div>
		<div class="col2">
			<p class="rodape" align="center">
				<a style="text-decoration:none" href="creditos.asp"><img src="imagens/logotipo.png" alt="Log�tipo da Rede" title="Log�tipo da Rede" border=0 align="absmiddle" hspace="3"></a>
			</p>
		</div>
		<div class="col2">
			<p class="rodape" align="center" style="font-variant: small-caps"><a style="text-decoration:none" href="<%=surlPORTAL%>" target="_top">Portal de atividades e not�cias da Rede: <br> <b>
						<%=sentidadelonga%></b><span class="fa-layers fa-fw" style="font-size:1.3em"><i class="fas fa-circle-notch"></i><i class="fas fa-external-link-alt" data-fa-transform="shrink-9" alt="Not�cias das bibliotecas" title="Not�cias das bibliotecas"></i></span></a></p>
		</div>
	</div>
	<!-- Segmento Log�tipo - FIM -->
	<!-- AddToAny - Local de exibi��o dos bot�es de partilha -->
	<div align="center" class="a2a_kit a2a_kit_size_32 a2a_default_style">
		<a class="a2a_dd" href="https://www.addtoany.com/share"></a>
		<a class="a2a_button_facebook"></a>
		<a class="a2a_button_twitter"></a>
		<a class="a2a_button_google_plus"></a>
		<a class="a2a_button_blogger"></a>
		<a class="a2a_button_diigo"></a>
		<a class="a2a_button_evernote"></a>
	</div>
	<script>
		var a2a_config = a2a_config || {};
		a2a_config.icon_color = "grey";
		a2a_config.onclick = 1;
		a2a_config.locale = "pt-PT";

	</script>
	<script async src="https://static.addtoany.com/menu/page.js"></script>
	<!-- AddToAny - Local de exibi��o dos bot�es de partilha - FIM -->
	<br>
	<!-- Segmento Autentica��o Principal - Reservas e leitores desativados -->
	<div class="navega">
		<% if session("nuser")<>"" then %><a href="javascript:void(0)" onclick="javascript:alterarPin()" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:2.2em"><i class="fas fa-circle-notch"></i><i class="fas fa-user" data-fa-transform="shrink-8" alt="Alterar o meu PIN" title="Alterar o meu PIN"></i></span></a>
		<% end if%>
		<!--
    <%if (session("user")<>"" and session("user")<>"ADMIN") or session("nuser")<>"" then %> <a href="javascript:void(0)" onclick="javascript:build_reservas(&quot;<%=session("user")%>&quot;,&quot;<%=session("nuser")%>&quot;)" rel="nofollow"><span class="fa-layers fa-fw" style="font-size:2.2em"><i class="fas fa-circle-notch" ></i><i class="fas fa-shopping-cart" data-fa-transform="shrink-9" alt="As minhas reservas" title="As minhas reservas"></i></span></a><%end if%>
-->
	</div>
	<div class="navega">
		<p>�
			<% if session("user")="" then response.write "<b>�rea reservada:</b> " else response.write "Utilizador: " &  DecodeUTF8(session("user"))%>
			<%if Session("LoggedIn") or session("LeitorIn") then%> [ <a href="logout.asp?sys=admin" rel="nofollow">Sair</a> ]
			<%else%> &nbsp;
			<!--
     <a href="javascript:void(0)" onClick="window.open('admin/logleitor.asp','login','width=420,height=320,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no')" rel="nofollow">Leitores</a>
-->
			&nbsp;<a href="admin/admin.asp" rel="nofollow">Autenticar</a>
			<%end if%>
			<br>
			<%if Session("LoggedIn") then %> � <a href="admin/admin.asp" rel="nofollow">Ir para zona de administra��o</a>
			<% end if%>
		</p>
	</div>
	<!-- Segmento Autentica��o Principal - FIM -->
	<!-- Software: <%=sversao%> - <%=surlRBE%> -->
	<!-- Fecho de c�digo da aplica��o -->
	<% end if%>
	<!-- Fecho de c�digo da aplica��o FIM -->
	<!-- Cookie Consent script https://cookieconsent.insites.com - In�cio -->
	<script defer src="https://cdnjs.cloudflare.com/ajax/libs/cookieconsent2/3.0.3/cookieconsent.min.js"></script>
	<script>
		window.addEventListener("load", function() {
			window.cookieconsent.initialise({
				"palette": {
					"popup": {
						"background": "#285E6C",
						"text": "#ffffff"
					},
					"button": {
						"background": "#62ffaa"
					}
				},
				"theme": "classic",
				"position": "bottom-left",
				"content": {
					"message": "O uso de Cookies neste s�tio destina-se apenas a uma melhor experi�ncia de utiliza��o. N�o s�o recolhidos dados pessoais.",
					"dismiss": "Ok, compreendi!",
					"link": "Mais detalhes",
					"href": "https://sites.google.com/view/opacrbe/utilizadores"
				}
			})
		});

	</script>
	<noscript><a href="https://sites.google.com/view/opacrbe/utilizadores" target="_blank" rel="noopener">C�digo para consentimento de Cookies</a></noscript>
	<!-- Cookie Consent script - FIM -->
</body>

</html>
<%sub sortArrayD(byref arrShort, byref t0, byref t3)

    for i = UBound(arrShort) - 1 To 0 Step -1
        for j= 0 to i
            if arrShort(j)<arrShort(j+1) then
                temp=arrShort(j+1)
				tmp0=t0(j+1)
				
				tmp3=t3(j+1)
                arrShort(j+1)=arrShort(j)
				t0(j+1)=t0(j)
				
				t3(j+1)=t3(j)
                arrShort(j)=temp
				t0(j)=tmp0
				
				t3(j)=tmp3
            end if
        next
    next
 
end sub%>
