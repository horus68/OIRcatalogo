 <!--#include file="admin/config.asp"-->
<!--#include file="admin/functions.asp"-->
<% base= request("base") 
   if base="" then base="rbcatalogo" %>
<%
  sentidadelonga = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "GERAL", "entidadelonga")
  stitulo = ReadIniFile(Server.MapPath("cgi/cgi.ini"), "PORTAL", "titulo")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="http://www.facebook.com/2008/fbml" xml:lang="pt" lang="pt">
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
  <meta name=viewport content="width=device-width, initial-scale=1">
  <meta name="robots" content="index, follow" />
	<title>Navegar por termos - <%=sentidade%></title>
  <link rel="stylesheet" href="css/default.min.css?version=001" type="text/css" />
	<script language="JavaScript" src="js/geral.min.js"></script> 
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script>
    if (typeof jQuery == 'undefined') {
    document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
    } 
    </script>
  <script language="JavaScript" type="text/javascript">
    var tabs = new Array(26); 
    for(i=0;i<26;i++) tabs[i]='tab'+(i+1);
   var letra="";
   var nval=1;
   function ChkLinkHref(tipo,formato,linha_in)
{
  var dim=0;
  var tmp="",car="";
  tmp=ConvUp(linha_in);
  tmp=FindRepChar(unescape(tmp),"`","\"");
  var param="/rbcatalogo/cgi/www.exe/[in=pesqger.in]?ut=<% if session("Nome")="" then response.write "guest" else response.write session("Nome") end if%>&base=<%=base %>&nomemnu=catindex.asp&formato="+formato+"&lim_inicio=1&limites=100&id=3";
  param+="&letra="+letra+"&user=<%=session("Nome")%>&expressao=";
  dim=tmp.length;
  car=tmp.charAt(dim-1);

  if (tipo=="1" && car==")") tmp=tmp.substring(0,dim-1);

  if (tipo=="3") tmp=TrataCDU(tmp);
  return(param + ChkChars_2(LimpaMais(tmp)));
}

function mudaPainel()
{
  showPanel(nval,letra,false);
}
  </script>
  <script language="JavaScript" type="text/javascript">
			function getXmlHttpRequestObject() {
				if (window.XMLHttpRequest) {
					return new XMLHttpRequest(); //Not IE
				} else if(window.ActiveXObject) {
					return new ActiveXObject("Microsoft.XMLHTTP"); //IE
				} else {
		
					alert("O seu browser não suporta o objecto XmlHttpRequest.");
				}
			}			
		
			var receiveReq = getXmlHttpRequestObject();		
		    
			function showPanel(n,stermo,op) {
                         
				
                var express=document.getElementById("termo").value.toUpperCase();
				var p=express.charCodeAt(0)-64;
                if (op && n!=p) express="";           
                letra= express =="" ?  stermo.charAt(0): express.charAt(0);
                stermo= express =="" ? stermo : express;                                       
				
				nval= express=="" ? n: p;
			    for(i = 0; i < 26; i++)
				    {
						document.getElementById(tabs[i]).className=(nval-1 == i) ? 'tab_sel':'tab';
					}
				for (i=0;i<5;i++)
					if (document.getElementById("PRFX").options[i].selected) {sprefix=document.getElementById("PRFX").options[i].value;break;}
							   
				document.getElementById('panel_a').innerHTML="<span style=\"position:relative;left:50%;top:40%;\"><img  src=\"imagens/picactions/wait.gif\"></span>";
				if (receiveReq.readyState == 4 || receiveReq.readyState == 0) {
				   
					sprefix= (sprefix=="PAL") ? stermo +"$":sprefix + " " + stermo +"$"; 
					var browser= navigator.userAgent.indexOf("MSIE")!=-1? 'ie':'noie';
					var url= "admin/getalfa.asp?expressao="+escape(sprefix)+"&base=rbcatalogo&letra="+letra+"&tab="+n; 
					receiveReq.open("GET", url, true);

				    receiveReq.onreadystatechange = handleResp; 
				    receiveReq.send(null);
				}
			       
			}
	
			function handleResp() {
			
				if (receiveReq.readyState == 4) {
                                 
					
					var elem = document.getElementById("panel_a");
					var newSpan = document.createElement('span');
					newSpan.id = elem.id;
					newSpan.innerHTML = receiveReq.responseText;
					for (var i = 0; i < document.getElementById("panel").childNodes.length; i++) {
  					 	var n = document.getElementById("panel").childNodes[i];
   						n.parentNode.removeChild(n);
					}
					   
					document.getElementById("panel").appendChild(newSpan);				
					
				}
			}
</script>
  <link rel="icon" href="favicon.ico" type="image/ico" />
 	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon" />
 	<meta name="description" content="Catálogo coletivo da Rede de Bibliotecas do Concelho" />
	<meta name="keywords" content="Catálogo coletivo, Bibliotecas, pesquisar biblioteca" />
	<meta name="author" content="Rede Concelhia de Bibliotecas" />
  <meta property="og:title" content="Catálogo - Rede de bibliotecas" />
  <meta property="og:type" content="library" />
  <meta property="og:site_name" content="Catálogo - Rede de bibliotecas" />
  <meta property="og:description" content="Catálogo coletivo da Rede de Bibliotecas do Concelho. Pesquise os documentos existentes nas bibliotecas deste concelho" /> 	
</head>
<body>
  <div class="destaque1">
    <h1 style="font-variant: small-caps">Catálogo Coletivo: <%=sentidadelonga%></h1>
  </div>
<!-- Segmento Navegação topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">» <a href="default.asp">Entrada</a> » Índice de termos</p>
    </div>
    <div class="col3" id="lblutilizador">
		<% if session("user")="" then 
		    response.write "Utilizador: Visitante"
		  elseif session("LeitorIn") then 
		    response.write "Utilizador: " & DecodeUTF8(session("user")) 
		  else response.write "Utilizador: " & ucase(session("user")) 
		  end if%>
		<%if Session("LoggedIn") or session("LeitorIn") then%> [ <a href="logout.asp?sys=admin">Sair</a> ]<%end if%>
    </div>
  </div>
<!-- Segmento Navegação topo - FIM -->
	<br />
    <div id="principal">
		<p>Não sabe o que temos para pesquisar? <b>Navegue nas listas de termos</b>!
		<br />- Pode limitar a lista por Autor, Título, Assunto, Colecção ou Palavra.
		<br />- Na listagem carregue numa das entradas para ver a ficha do documento correspondente.</p>
	<div class="col5-contentor">
    <div class="col5">
			<select size="1" name="PRFX" id="PRFX" tabindex="1" onchange="mudaPainel()">
				<option selected value="AU">Autor</option>
				<option value="TI">Título</option>
				<option value="AS">Assunto</option>
				<option value="COL">Colecção</option>
				<option value="PAL">Palavra</option>
            </select>
    </div>
    <div class="col5">
			<input type="text" id="termo" name="termo" size="25" onkeydown="if (event.keyCode == 13) mudaPainel()">
    </div>
  </div>
	<p>Listas <b>por letra inicial</b></p>
  <div id="tabs">	
		<% for i=65 to 90 %>		   
             <div id="tab<%= i-64%>" class="<% if i=65 then response.write "tab_sel" else response.write "tab" end if%>" align="center" onClick="javascript:showPanel(<%=i-64%>,this.innerHTML, true);"><%=chr(i)%></div>
		<%next%>
        </div>
        <div class="tab_bdr"></div>
		<div  id="panel" style="min-height:120px"><span id="panel_a" style="height:120px"><span style="position:relative;left:50%;top:40%;"><img src="imagens/picactions/wait.gif"></span></span></div>
		 <br />
		<h4><a style="text-decoration:none" href="ajuda_dicas.asp"><img src="imagens/setnav/pic_question.png" alt="Dicas de pesquisa" title="Dicas de pesquisa" border=0 align="absmiddle" hspace="3" width="24" height="24">Dúvidas? Carregue aqui para ver as dicas de pesquisa</a></h4>
  <div class="txtrodape" align="center">
  Catálogo Coletivo<br> &copy; <b><%=sentidadelonga%></b>
  </div>
		</div>    
       <script>var l=(letra=="" ? 'A': letra);showPanel(nval,l)</script>  
</body>