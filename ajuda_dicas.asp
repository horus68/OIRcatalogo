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
	<title>Dicas de pesquisa <%=stitulo%></title>
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
 	<meta name="description" content="Dicas de Pesquisa no Catálogo coletivo da Rede de Bibliotecas do Concelho"/>
	<meta name="keywords" content="Catálogo coletivo, Bibliotecas, pesquisar biblioteca" />
	<meta name="author" content="Rede Concelhia de Bibliotecas" />
  <meta property="og:title" content="Dicas de Pesquisa no Catálogo da Rede de bibliotecas" />
  <meta property="og:type" content="library" />
  <meta property="og:site_name" content="Catálogo - Rede de bibliotecas" />
  <meta property="og:description" content="Catálogo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos existentes nas bibliotecas deste concelho" />
</head>

<body>
  <div class="destaque1">
    <h1>Catálogo Coletivo: <%=sentidadelonga%></h1>
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

    <div id="principal"> 
	  <div align="center">
<img src="<%=slogo%>" alt="Logótipo">
</div>
	<h2><span class="fa-layers fa-fw" style="font-size:3em"><i class="fas fa-circle-notch" ></i><i class="fas fa-graduation-cap" data-fa-transform="shrink-8" title="Técnicas de pesquisa"></i></span>Dicas de Pesquisa no catálogo</h1> 
<p><img src="imagens/ajuda/pesquisa.png" alt="Resultado da pesquisa" border=0 align="left">Pesquisar neste catálogo é muito simples: basta escrever uma palavra na caixa de pesquisa e carregar em pesquisar. <br />
Pode fazer muito mais: obter menos resultados, mas mais exatos, filtrar resultados por biblioteca e tipo de documento, alterar o formato de visualização ou ver a biblioteca num mapa.</p>
<br />
<h2>A- Tipos de pesquisa</h2>
<p>O catálogo oferece vários tipos de pesquisa e combináveis com filtros e operadores. Recomendamos que, dependendo do tipo de informação pretendida, utilize a pesquisa Simplificada ou a Orientada.<br />
Nota: pode pesquisar um autor pela forma normal("Nome Apelido") ou forma inversa (“Apelido, Nome”)
</p>
<br style="clear:left;"/>
<br />
<h3>A1- Pesquisa simplificada</h3>
<p>A pesquisa simplificada é uma pesquisa livre que permite encontrar rapidamente sem ter de se indicar muitos detalhes sobre o documento. <br />
Deve ser utilizada quando não se sabe exatamente o nome de um autor ou o título completo de um livro. O número de respostas tende a ser elevado.<br />
<img src="imagens/ajuda/pesquisa_simplificada.png" alt="Pesquisa simplificada" border=0 align="center">
<br style="clear:left;"/>
Este tipo de pesquisa aceita a introdução de uma ou mais palavras e é feita em vários campos ao mesmo tempo (Título, Autor, Assunto, Coleção, Local de edição e Editor).</p>

<br style="clear:left;"/>
<br />
 <div class="destaquetexto">
		<h3>A2- Pesquisa orientada</h3>
<p>A pesquisa orientada permite maior detalhe na pesquisa. <br />
Deve ser utilizada quando sabemos exatamente o que procurar ou para limitar as pesquisas apenas a uma biblioteca.<br />
<img src="imagens/ajuda/pesquisa_orientada.png" alt="Pesquisa orientada" border=0 align="center">
<br style="clear:left;"/>
Na pesquisa orientada encontra vários campos de pesquisa disponíveis (ex.: Autor, Título, Assunto, Coleção, Biblioteca).<br />
Para melhorar a exatidão das pesquisas pode colocar termos em mais de um campo e escolher os operadores [ <b>E</b> ][ <b>OU</b> ][ <b>NÃO</b> ] de forma a limitar os resultados obtidos.
 </p>
   </div>
<br style="clear:left;"/>
<br />
<h3>A3- Pesquisa/navegação por termos</h3>
<p>A pesquisa por termos permite encontrar documentos mesmo sem escrever. É uma lista do que existe no catálogo e com navegação simples<br />
Deve ser utilizada quando não sabemos que tipo de documentos existem numa biblioteca ou quando não sabemos como se escreve um determinado título ou nome de autor.<br />
<img src="imagens/ajuda/pesquisa_termos.png" alt="Pesquisa por termos" border=0 align="center">
<br style="clear:left;"/>
Na entrada da navegação por termos encontra uma listagem de palavras organizadas por alfabeto. Clique no resultado pretendido e irá para a ficha do documento.<br />
Pode limitar as listagens utilizando os vários campos de pesquisa disponíveis (ex.: Autor, Título, Assunto, Coleção).<br />
</p>
<br style="clear:left;"/>
<br />
<div class="destaquetexto1">
		<h2>B- Pesquisar com filtros</h2>
	<p>Na pesquisa simplificada ou na orientada pode filtrar as suas pesquisas por tipo de material ou ano de edição.<br />
	Para tal carregue no ícone (+) de forma a ver as opções <br />
<img src="imagens/ajuda/pesquisa_filtros.png" alt="Filtrar pesquisas" border=0 align="center">
<br />
É igualmente nos filtros que pode alterar o formato de visualização dos resultados.<br />
<img src="imagens/ajuda/pesquisa_filtros1.png" alt="Filtrar pesquisas" border=0 align="center">
	</p>
   </div>
	<br style="clear:left;"/>
<br />
	<h2>C- Pesquisar com operadores</h2>
<p>A utilização de operadores nas pesquisas permite limitar os resultados obtidos<br />
São utilizados os operadores [ E ][ OU ][ NÃO ] que permitem condicionar uma pesquisa de forma a mostrar documentos que, por exemplo, possuam duas palavras específicas ou em que tenham uma mas não a outra palavra.
</p>
	<h3>C1- Operadores na pesquisa orientada</h3>
 <p>Na pesquisa orientada os operadores já estão disponíveis, para escolha, em cada campo.<br />
 <img src="imagens/ajuda/pesquisa_oper_ori.png" alt="Operadores na pesquisa orientada" border=0 align="center">
 </p>
 
 
 <h3>C2- Operadores na pesquisa simplificada</h3>
 
<p>Na pesquisa simplificada a utilização de operadores tem de ser feita através de uma expressão de pesquisa composta por:
  <ul>
    <li>Palavras a pesquisar</li>
    <li>Símbolos para os operadores: + (E) ,  espaço (OU) ,  - (NÃO)</li>
    <li>Sinais de pontuação (aspas, parêntesis)</li>
  </ul>
  </p>
  <p>Exemplo:<br />
 <img src="imagens/ajuda/pesquisa_oper_simp.png" alt="Operadores na pesquisa simplificada" border=0 align="center">
  <br />
  Para mais exemplos de utilização de operadores visite este sítio web: <a style="text-decoration:none" href="https://sites.google.com/view/pesquisarcatalogo/operadores" target="_blank">https://sites.google.com/view/pesquisarcatalogo/operadores</a>  
    </p>
<br style="clear:left;"/>
	<br />
 <div class="destaquetexto">
	<h2>D- Resultados de uma pesquisa</h2>
	<p>Após fazer uma pesquisa obtém os seus resultados com a indicação das bibliotecas onde estão disponíveis <br />
	Para detalhes veja a linha "localização" e carregue na sigla da biblioteca ou no sinal "+"  <br />
<img src="imagens/ajuda/bib_identificar1.png" alt="Resultados de uma pesquisa" border=0 align="center">
<br />
Como identificar a biblioteca onde requisitar o documento? <a style="text-decoration:none" href="ajuda_identificar.asp">Carregue aqui >>>.</a>
	</p>
   </div>	
<br style="clear:left;"/>
 <div class="destaquetexto1">
	<p>
Em caso de dúvidas, dirija-se à biblioteca mais próxima onde terão todo o gosto de o ajudar nas pesquisas e empréstimos, mesmo que o documento não esteja nessa biblioteca.
<br />Boas leituras!
	</p>
	<p>[Mais informações sobre como pesquisar no catálogo: <a style="text-decoration:none" href="https://sites.google.com/view/pesquisarcatalogo" target="_blank">https://sites.google.com/view/pesquisarcatalogo</a> ]
	</p>
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
