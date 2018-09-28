<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt" lang="pt">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <meta name=viewport content="width=device-width, initial-scale=1">
	<meta name="robots" content="noindex, nofollow" />
	
	<title><%=stitulo%></title>
    <link rel="stylesheet" href="../css/default.min.css" type="text/css" />
	<script language="JavaScript" src="../js/geral.min.js"></script> 
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>

<body>
  <div class="destaque1">
    <h1>Cat�logo Coletivo: Cat�logo individual</h1>
  </div> 
<!-- Segmento Navega��o topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">� <a href="../default.asp">Zona P�blica</a> � <a href="admin.asp?id=1">Administra��o</a> � Visualizar o meu cat�logo
</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <span id="utilizador">
        <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> &nbsp;[ <a href="admin.asp?Logout=1">Sair</a> ]<%else%> &nbsp;[ <a href="admin.asp">Entrar</a> ]<%end if%>
        </span>
    </div>
  </div>
<!-- Segmento Navega��o topo - FIM -->
    <div id="principal"> 
		<div id="admbotoes" style="float:right"><a href="admin.asp?id=1"><img src="../imagens/picactions/icon_close.gif" border=0 alt="Voltar � p�gina anterior"></a><% if flag=1 then %><a href="javascript:window.print()"><img src="../imagens/picactions/icon_imprimir.gif" border=0 alt="Imprimir esta p�gina" title="Imprimir esta p�gina"></a><%end if%></div>		
		<h3>O cat�logo da minha biblioteca</h3>
<!-- Segmento pesquisa orientada Filtros Cabe�alho -->
<% if request.querystring("id")=1 then %>
<p><b>Pesquisa orientada</b>:</p>
	<form action="../cgi/www.exe/[in=pesqger.in]" method="get" onSubmit="return ValidaData(this)">
	 	<input type="hidden" name="expressao" value>
		<input type="hidden" name="lim_inicio" value="1">
		<input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="id" value="1">
		<input type="hidden" name="base" value="<%=lcase(session("user"))%>">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
        <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 
  <div class="col5-contentor" style="width:100%">
    <div class="col5" style="background-color:#f9f9ed">
		<p>Tipo de documento <br /> 
		<select  size="1" name="TDOC">
		  <option selected value="XX">Todos os documentos</option>
		  <option value="AM">Monografia (texto impresso)</option>
		  <option value="BM">Monografia (texto manuscrito)</option>
		  <option value="CM">Partituras musicais - Impressas</option>
		  <option value="DM">Partituras musicais - Manuscritas</option>
		  <option value="EM">Material cartogr�fico - Impresso</option>
		  <option value="FM">Material cartogr�fico - Manuscrito</option>
		  <option value="GM">Material de proje��o e v�deo</option>
		  <option value="IM">Registos sonoros n�o musicais</option>
		  <option value="JM">Registos sonoros musicais</option>
		  <option value="KM">Material gr�fico a duas dimens�es</option>
		  <option value="LM">Produtos de computador</option>
		  <option value="MM">Multim�dia</option>
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Anal�tico</option>
		  <option value="AS">Publica��o peri�dica</option>
		</select>
		</p>
		<p>Ano <br />
        <input type="text" size="4" name="DP" maxlength="4"><br /><span class="notas"> (Ex. 2001) </span>
        </p>
    </div>
    <div class="col5" style="background-color:#f9f9ed">
		<p>Formato <br />
		<select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">T�tulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        <p>Registos por p�gina <br />
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		</p>
    </div>
  </div>
<!-- Segmento pesquisa orientada Filtros Cabe�alho - FIM -->
<!-- Segmento pesquisa orientada Filtros Campos -->	
   <h4>Termos a pesquisar </h4> 
		<table>
		<th>Operador</th>
		<th>Campo</th>
		<th>Termo</th>
		<th>Truncatura</th>
		<tr>
			<td>
			</td>
			<td>  <select size="1" name="PRFX1">
              <option selected value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>
              <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
           </td>
		   	<td><input type="text" size="40" name="Termo1" class="form-pesquisa" maxlength="80"> 
            </td>
		   <td><input type="checkbox" value="$" name="TR1" checked>
			</td>
		
			
		</tr>
		<tr>
			<td><select size="1" name="OP2">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
             </select>
			</td>
			
			<td> <select size="1" name="PRFX2">
              <option value="AU">Autor</option>
              <option selected value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>
              <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
			<td><input type="text" size="40" name="Termo2" class="form-pesquisa" maxlength="80">
            </td>
			</td><td><input type="checkbox" value="$" name="TR2" checked>
			</td>
		</tr>
		<tr>
			<td>  <select size="1" name="OP3">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
                  </select>
			</td>
			
			<td>     <select size="1" name="PRFX3">
              <option value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option selected value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>
			  <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
          </td>
			<td><input type="text"  size="40" name="Termo3" class="form-pesquisa" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR3" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1"  name="OP4">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
                  </select>
			</td>
			
			<td>  <select size="1" name="PRFX4">
              <option value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option selected value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>
			  <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
 			</td>
			<td><input type="text"  size="40" name="Termo4" class="form-pesquisa" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR4" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1" name="OP5">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
                  </select>
			</td>
			
			<td>           <select size="1" name="PRFX5">
              <option value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option selected value="ISBN">ISBN</option>
			  <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
      		</td>
			<td><input type="text" size="40" name="Termo5" class="form-pesquisa" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR5" checked>
		    </td>
		</tr>
		<tr>
			<td><select size="1"  name="OP6">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
                  </select>
			</td>
			
			<td>  <select size="1" name="PRFX6">
              <option value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>
			  <option value="ISSN">ISSN</option>
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option selected value="PAL">Palavra</option>
              <option value="CT">Cota</option>
              <option value="SI">SIGLA</option>
            </select>
			</td>
			<td><input type="text" size="40" name="Termo6" class="form-pesquisa" maxlength="80">
			</td>
			<td><input type="checkbox" value="$" name="TR6" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1"  name="OP7">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">N�O</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorr�ncia</option>
                  </select>
			</td>
			
			<td>      <select size="1" name="PRFX7">
              <option value="AU">Autor</option>
              <option value="TI">T�tulo</option>
              <option value="AS">Assunto</option>
              <option value="COL">Cole��o</option>
              <option value="ISBN">ISBN</option>   
			  <option value="ISSN">ISSN</option>     
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
			  <option selected value="SI">SIGLA</option>

            </select>
          </td>
			<td><input type="text"  size="40" name="Termo7" class="form-pesquisa"maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR7" checked>
			</td>
		</tr>

		</table><br>
	
		 <div align="center"><input type="submit" class="botao botao1" value="Pesquisar" onClick="return ValidaExpress(this.form)" name="Submit">
        <input type="reset" value="Limpar" class="botao botao2" name="Reset"></div>
       </form>
<!-- Segmento Caixa Pesquisa orientada FIM -->
<!-- Segmento pesquisa simples Filtros Cabe�alho -->
<% elseif request.QueryString("id")=0 then%>
			<p><b>Pesquisa simplificada</b>:</p>
			<form action="../cgi/www.exe/[in=pesqger.in]" method="GET">     
        <input type="hidden" name="base" value="<%=lcase(session("user"))%>">  
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="lim_inicio" value="1">
		<input type="hidden" name="id" value="0">
        <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
		  <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%>  
<!-- Segmento pesquisa simples Filtros Cabe�alho - FIM -->
<!-- Segmento pesquisa simples Filtros Campos -->	
  <div class="col5-contentor" style="width:100%">
    <div class="col5" style="background-color:#f9f9ed">
        <p>Tipo de documento <br />
		<select  size="1" name="TDOC">
		  <option selected value="XX">Todos os documentos</option>
		  <option value="AM">Monografia (texto impresso)</option>
		  <option value="BM">Monografia (texto manuscrito)</option>
		  <option value="CM">Partituras musicais - Impressas</option>
		  <option value="DM">Partituras musicais - Manuscritas</option>
		  <option value="EM">Material cartogr�fico - Impresso</option>
		  <option value="FM">Material cartogr�fico - Manuscrito</option>
		  <option value="GM">Material de proje��o e v�deo</option>
		  <option value="IM">Registos sonoros n�o musicais</option>
		  <option value="JM">Registos sonoros musicais</option>
		  <option value="KM">Material gr�fico a duas dimens�es</option>
		  <option value="LM">Produtos de computador</option>
		  <option value="MM">Multim�dia</option>
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Anal�tico</option>
		  <option value="AS">Publica��o peri�dica</option>
		</select>
		</p>
		<p>Ano <br />
        <input type="text" size="4" name="DP" maxlength="4"><br /><span class="notas"> (Ex. 2001) </span>
        </p>
    </div>
    <div class="col5" style="background-color:#f9f9ed">
		<p>Formato <br />
       <select  size="1" name="formato">
				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">T�tulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        </p>
		<p>Registos por p�gina <br />
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
    </div>
    </div>
<!-- Segmento pesquisa simples Filtros Campos - FIM -->
<!-- Segmento Caixa Pesquisa Simples -->
  <div class="col5-contentor" style="width:100%">
    <div class="col5">
        <h4>Termo a pesquisar:</h4>
		<p id="caixa">
        <input type="radio" value="" name="PRF" checked>Palavra
		<input type="radio" value="AU" name="PRF"> Autor 
        <input type="radio" value="AS" name="PRF" >Assunto
		<input type="radio" value="TI" name="PRF" >T�tulo
		</p><p>
		<input type="text" size="55" name="termo" maxlength="80">
		<input type="checkbox" value="$" name="truncatura">Exata<br>     
        </p>
	</div>
  </div>

  <br>      
	<div align="center"><input type="submit" value="Pesquisar" class="botao botao1" onClick="return ValidaExpress_3(this.form)" name="Submit">
		<input type="reset" value="Limpar" class="botao botao2" name="Reset"></div>
         </form>
<!-- Segmento Caixa Pesquisa Simples FIM -->
<!-- Segmento Pesquisa Avan�ada -->
	<% elseif request.QueryString("id")=2 then%>
		<p><b>Pesquisa avan�ada</b>:</p>
	<form action="../cgi/www.exe/[in=pesqger.in]" method="GET">     
        <input type="hidden" name="base" value="<%=lcase(session("user"))%>">  
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="lim_inicio" value="1">
        <input type="hidden" name="id" value="2">
        <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
		 <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 

  <div class="col5-contentor" style="width:100%">
    <div class="col5" style="background-color:#f9f9ed">
	<p>Tipo de documento <br />
		<select  size="1" name="TDOC">
		  <option selected value="XX">Todos os documentos</option>
		  <option value="AM">Monografia (texto impresso)</option>
		  <option value="BM">Monografia (texto manuscrito)</option>
		  <option value="CM">Partituras musicais - Impressas</option>
		  <option value="DM">Partituras musicais - Manuscritas</option>
		  <option value="EM">Material cartogr�fico - Impresso</option>
		  <option value="FM">Material cartogr�fico - Manuscrito</option>
		  <option value="GM">Material de proje��o e v�deo</option>
		  <option value="IM">Registos sonoros n�o musicais</option>
		  <option value="JM">Registos sonoros musicais</option>
		  <option value="KM">Material gr�fico a duas dimens�es</option>
		  <option value="LM">Produtos de computador</option>
		  <option value="MM">Multim�dia</option>
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Anal�tico</option>
		  <option value="AS">Publica��o peri�dica</option>
		</select>
		</p>
		<p>Ano <br />
        <input type="text" size="4" name="DP" maxlength="4"><br /><span class="notas"> (Ex. 2001) </span>
        </p>
    </div>
    <div class="col5" style="background-color:#f9f9ed">
		<p>Formato <br />
		<select  size="1" name="formato">
				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">T�tulos</option>
				  <option value="wibol">Boletim</option>
        </select>
        </p>
		<p>Registos por p�gina <br />
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		</p>
    </div>
  </div>	
<h4>Express�o de pesquisa</h4>
  <p id="caixa-avan">
		  <textarea rows=3 cols="53" name="termo" tabindex="1"></textarea>
  </p>
  <div align="center"><input type="submit" value="Pesquisar" class="botao botao1" onClick="return ValidaExpress_4(this.form)" name="Submit">
	  <input type="reset" value="Limpar" class="botao botao2" name="Reset">
    </div>
    </form>
  <br><br>Aqui pode recorrer �s v�rias t�cnicas e formas de cria��o de express�es de pesquisa com
		<br>(<em>operadores booleanos, de n�vel e proximidade, truncatura, restri��o por campos, etc</em>)
		<br>Caso indique mais do que um termo, separe-o por um operador booleano 
    <br><strong>AND</strong> (intersec��o), <strong>OR</strong> (uni�o) ou <strong>AND NOT</strong> (exclus�o).
		</p><br> 
<!-- Segmento Pesquisa Avan�ada FIM -->
<!-- Segmento Pesquisa por termos -->
	<%else%>
	  <p><b>Navega��o por termos</b>:</p>
	 <form ACTION="../cgi/www.exe/[in=pesqtrm.in]" METHOD="get" align="center">
      <input type="hidden" name="expressao" value=" ">
      <input type="hidden" name="base" value="<%=lcase(session("user"))%>">
      <input type="hidden" name="formato0" value="witrm">
	  <input type="hidden" name="id" value="3">
	  <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0"> 
	  <input type="hidden" name="entidade" value="<%=sentidade%>">
	   <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 
  <div class="col5-contentor" style="width:100%">
    <div class="col5" style="background-color:#f9f9ed">
	  <p>Tipo de documento <br /> 
		<select  size="1" name="TDOC">
		  <option selected value="XX">Todos os documentos</option>
		  <option value="AM">Monografia (texto impresso)</option>
		  <option value="BM">Monografia (texto manuscrito)</option>
		  <option value="CM">Partituras musicais - Impressas</option>
		  <option value="DM">Partituras musicais - Manuscritas</option>
		  <option value="EM">Material cartogr�fico - Impresso</option>
		  <option value="FM">Material cartogr�fico - Manuscrito</option>
		  <option value="GM">Material de proje��o e v�deo</option>
		  <option value="IM">Registos sonoros n�o Musicais</option>
		  <option value="JM">Registos sonoros musicais</option>
		  <option value="KM">Material gr�fico a duas dimens�es</option>
		  <option value="LM">Produtos de computador</option>
		  <option value="MM">Multim�dia</option>
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Anal�tico</option>
		  <option value="AS">Publica��o peri�dica</option>
		</select>
		</p>
		<p>Ano<br />
        <input type="text" size="4" name="DP" maxlength="4"><br /><span class="notas"> (Ex. 2001) </span>
		<p>
		</div>
		 <div class="col5" style="background-color:#f9f9ed">
		<p>Formato<br />
       <select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">T�tulos</option>
				  <option value="wibol">Boletim</option>
         </select>
		</p>
		<p>Registos por p�gina<br /> 
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
		 </div>
    </div>	
         <h4>Selecione o campo relativo aos termos a apresentar&nbsp;e digite o termo de pesquisa&nbsp;</h4>
  <div class="col5-contentor" style="width:100%">
    <div class="col5">
		 <p><select size="1" name="PRFX" tabindex="1">
                  <option selected value="AU">Autor</option>
                  <option value="TI">T�tulo</option>
                  <option value="AS">Assunto</option>
                  <option value="CDU">CDU</option>
                  <option value="COL">Cole��o</option>
                  <option value="ISBN">ISBN</option>
				  <option value="ISSN">ISSN</option>     
                  <option value="DL">DL</option>
                  <option value="PAL">Palavra</option>
                  <option value="CT">Cota (Localiza��o)</option>
                  <option value="DP">Data de publica��o</option>
				  <option value="SI">SIGLA</option>
                </select>
           </p>
    </div>
    <div class="col5">
			<input type="text" size="40" name="termo" tabindex="2" maxlength="80">
    </div>
  </div>
           <p>Ser� apresentado o �ndice a partir do termo que indicou. Caso seja deixado em branco ser� apresentada a lista desde o in�cio.
              <br>Cada termo (� excep��o das palavras soltas) aparece identificado por prefixos (Ex. AU, TI, etc)
            </p><br>                    
           <div align="center"><input type="submit" value="Listar termos" class="botao botao1" name="Submit1" onClick="ChkTermo(this.form)" tabindex="4">
		  <input  type="reset" class="botao botao2" value="Limpar" name="Reset"></div>       
       </form>
<!-- Segmento Pesquisa por termos - FIM -->
	<% end if%>  
  </div> 
</body>
</html>