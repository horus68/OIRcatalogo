<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  sversao = ReadIniFile(Server.MapPath("/rbcatalogo/cgi/cgi.ini"), "GERAL", "versao")
  surlRBE = ReadIniFile(Server.MapPath("/rbcatalogo/cgi/cgi.ini"), "GERAL", "urlRBE")
  surlPORTAL = ReadIniFile(Server.MapPath("/rbcatalogo/cgi/cgi.ini"), "GERAL", "urlPORTAL")
  sentidadelonga = ReadIniFile(Server.MapPath("/rbcatalogo/cgi/cgi.ini"), "GERAL", "entidadelonga")
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="pt-PT" lang="pt-PT">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name=viewport content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title><%=stitulo%></title>
<link rel="stylesheet" href="../css/default.min.css?version=001" type="text/css" />
<link rel="stylesheet" href="../css/tabcontent.min.css" type="text/css" />
<script type="text/javascript" src="../js/geral.min.js"></script>
<script type="text/javascript" src="../js/prototype.js"></script>
<script type="text/javascript" src="../js/tabcontent.min.js"></script>		
<script type="text/javascript" src="../js/users.min.js"></script>
<script type="text/javascript" src="../js/md5.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script>
    if (typeof jQuery == 'undefined') {
    document.write(unescape("%3Cscript src='js/jquery-3.3.1.min.js' type='text/javascript'%3E%3C/script%3E"));
    } 
    </script>
<script src="../js/jqPrint.js"></script>
<script>

$(document).ready(function(){ 
	 getfdados();       
});

function mudagrafop(ob)
{
  if (ob.checked && ob.id=='gcoltip2') document.getElementById("grafori").style.display='none'; else document.getElementById("grafori").style.display=''; 
}
function act_param_res()
{
var lres = document.getElementById('limres').value;
	 var mres = document.getElementById('maxres').value;
	 var estado = document.getElementById('estado1').checked? 'S':'N';
	 var ei = document.getElementById('ei1').checked? 'S':'N';
	 var eib = document.getElementById('eib1').checked? 'S':'N';
	 var valida = document.getElementById('valida1').checked? 'S':'N';
	 var gres = document.getElementById('gres1').checked?'S':'N';
	 var gcol = document.getElementById('gcol1').checked?'S':'N';
	// var grestip = document.getElementById('grestip1').checked?'S':'N';
	 var gcoltip = document.getElementById('gcoltip1').checked?'S':'N';
	 var params="v10="+lres+"&v20="+mres+"&v30="+estado+"&v40="+ei+"&v50="+eib+"&v60="+valida+"&v70="+gres+"&v80="+gcol+"&v100="+gcoltip;
	 url ="../cgi/www.exe/[in=updpar1.in]?"+params;
     window.location.href=url;

}

function addBtPrint(id) {
 var c= '<input class="no-printable" type="image" src="../imagens/picactions/icon_imprimir.gif" onclick="javascript:printContents(&quot;'+id+'&quot;);return false;">';
 $("#bPrint").html(c);
}


function printContents(id) {
      
       $('#'+id).jqprint({
       });
    
}



function VRegisto(mfn,base) {
   var janela =  "vregisto"; 
   var loc = "../cgi/www.exe/[in=vregisto.in]?base="+base+"&expressao="+mfn;
   popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=580,height=370,left=150%,top=150%");
   ndoc=popup.document;
   ndoc.location.href=loc;
   if(window.focus) popup.focus();

}

function showDBanom() {
     var url;
     var diff= $("#MFNate").val()-$("#MFNde").val()+1;
     var expr= $("#canom").val();
     var subc= $("#scanom").val();
     var oper= $("#opanom").val();
	 if (oper=='in' || oper=='notin')
	 var cs = $('#case').attr('checked') ? 1 : 0; 
     var nocc= (oper=='in' || oper=='notin')? (cs==0? $("#txtanom").val().toUpperCase(): $("#txtanom").val()): $("#ncanom").val();
     $("#anomalias").html('<p class="aviso"><img src="../imagens/picactions/wait.gif" align="absmiddle"> Aguarde um momento</p>');
     switch(expr){
	 case '005': case '010': case '011': case '021': case '035': case '100': 
	 case '101': url ="../cgi/www.exe/[in=getDBanom.in]?base=";break;
	 case '200': 
	 case '205':  
	 case '210': 
	 case '215': 
	 case '225': url ="../cgi/www.exe/[in=getDBanom1.in]?base=";break;  
	 case '300': case '307':  case '465':  case '467': case '500': case '600': case '606': 
	 case '675': case '700':  case '701':  case '702':  case '710':  case '711':  case '712':  case '720':  case '721':  case '722':  case '801': 
	 case '856': case '859':  case '921':  case '922':  case '923':  case '955': 
	 case '966': url ="../cgi/www.exe/[in=getDBanom2.in]?base=";break;
	 }
	 <% if lcase(session("user"))="admin" then %>
	 url = url+$("select#base option").filter(":selected").val();
	 <% else %>
	 url = url+$("#base").val();
     <% end if%>
     url= url+"&expr="+expr+"&lim_inicio="+$("#MFNde").val()+"&limites="+ diff+"&subc="+subc+"&nocc="+nocc+"&oper="+oper+"&cs="+cs+"&d="+new Date().getTime(); 
	 new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
                $("#anomalias").html(response); 
		
        },    
     onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function getfdados(){
     <% if lcase(session("user"))="admin" then %>
	 var user = $("select#base2 option").filter(":selected").val();
	 <% else %>
     var user="<%=lcase(session("user"))%>";
	 <% end if %>
	 if (user=='' || user==null) return;
     var url ="getftime.asp?file="+user+".iso";
     new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
		if (response!="\n") {var aresp= response.split("#");$("#time").html(aresp[0]);$("#fsize").html(" ("+Math.floor(aresp[1]/1000)+" kb)");$("#fiso").html(user+".iso");} 
        else {
		     $("#time").html("---"); 
			 $("#fsize").html("---");
			 }
				
        },    
     onFailure: function(){$("#time").html("----"); $("#fsize").html(""); }  }); 
     var url ="chkiso.asp?file="+user+".iso";
     new Ajax.Request (url, {
     method:"get",   
     onSuccess: function(transport) {    
     var response = transport.responseText; 
      if (response !='Erro')
	  {
      var url ="../cgi/www.exe/[in=getpariso.in]?ut="+user.toUpperCase()+"&resp="+response;
      new Ajax.Request (url, {
      method:"get",   
      onSuccess: function(transport) {    
      var response = transport.responseText; 
      var aresp= response.split("%%");
      $("#soft").html(aresp[0]);
      $("#codepage").html(aresp[1]);
      if (aresp[1]!=aresp[2])
		  if (aresp[2]=="Erro") 
		  {
			 $("#fiso").html('<img style="cursor:pointer" src="../imagens/picactions/info_stop.png" width="15" border="0" align="absmiddle" title="Ficheiro ISO NÃO ENCONTRADO ou não foi possível ler o ficheiro.">');
		  } else 
			  if (aresp[2]=="misc") 
			    $("#alerta").html('<img style="cursor:pointer" src="../imagens/picactions/info_question.png" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente com mistura do padrão ANSI com o padrão ASCII.\r\nATENÇÃO: convém notar que o método heurístico de validação não é absolutamente garantido">');
			  else 
			    $("#alerta").html('<img style="cursor:pointer" src="../imagens/picactions/info_aviso.png" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente NÃO CONFERE com a parametrização.\r\nATENÇÃO: convém notar que o método heurístico de validação não é absolutamente garantido">');
     else   $("#alerta").html('<img style="cursor:pointer" src="../imagens/picactions/info_checked.png" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente VÁLIDA.\r\nATENÇÃO: convém notar que o método heurístico de validação não é absolutamente garantido">');
     }, 
     onFailure: function() {alert("Ocorreu um erro. Contacte o administrador.")}
      });
     } else {$("#soft").html("----"); $("#codepage").html("");$("#alerta").html('<img style="cursor:pointer" src="../imagens/picactions/info_stop.png" width="15" border="0" align="absmiddle" title="Ficheiro ISO NÃO ENCONTRADO ou não foi possível ler o ficheiro.">');}	  
   }, 
   onFailure: function() {alert("Ocorreu um erro. Contacte o administrador.")}
   });   

}

function checkValInput(ob){
    if (isNaN(ob.value)) ob.value='1';
}

function getbiblio()
 {
     var selObj = $('v100');
	 if (selObj == null) return;
	 var selIndex = selObj.selectedIndex==-1?  0: selObj.selectedIndex;
	 if (selIndex==0) {$('labelbib').innerHTML=""; return};
	 //alert(selObj.options[selIndex].text);
	 
	  url ="../cgi/www.exe/[in=getuser.in]?expressao=SIGLA " + selObj.options[selIndex].text;
	  new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
		$("labelbib").innerHTML=response;
      },    
	   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function attachFile(){
  document.forms[0]['file'].click();
  alert(document.forms[0]['file'].value);
  var pos = document.forms[0]['file'].value.lastIndexOf('\\');
  var fich = document.forms[0]['file'].value.substr(pos+1);
  var img=document.createElement('img');
  img.setAttribute('src','../imagens/'+fich);
  $('imgLeitor').appendChild(img)
  
  return;
}

function getDirImg(){
        window.open("images.asp?op=novo", "ImgUpload", "width=500, height=340, dependent=yes, left=150 , top=150, menubar=no, scrollbars=no,status=yes");		
}
function muda_base(ob){
   for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
   if (ob.id=='base2') {document.getElementById("fiso").innerHTML = ob.options[i].value+".iso"; getfdados(); return }
   if (ob.id=='base') {document.getElementById("nocat1").innerHTML ="<center><img src='../imagens/picactions/wait.gif' border='0'></center>";}
   else {document.getElementById("nocat2").innerHTML ="<center><img src='../imagens/picactions/wait.gif' border='0'></center>";
     document.getElementById("exportparam").style.display="none";
   }
             		   
   url ="../cgi/www.exe/[in=getmfns.in]?base=" + ob.options[i].value+"&d="+new Date().getTime();
   new Ajax.Request(url, {     
   method:"get",  
   onSuccess: function(transport){       
   var response = transport.responseText;  
   if (ob.id=='base')
   {
	   document.getElementById("anomalias").innerHTML='';
	   document.getElementById("nregs").value=response;
	   document.getElementById("MFNate").value=response;
	   if (response=="") { 
		 document.getElementById("validar").style.display="none";
		 document.getElementById("nocat1").innerHTML="<center>Nota: Este utilizador não tem catálogo na REDE</center>";
	   } else
	   {
		 document.getElementById("validar").style.display="";
		 document.getElementById("nocat1").innerText="";
	   }			   
   }else{
	   document.getElementById("limites").value=response;
	   document.getElementById("MFNate1").value=response;
	   if (response=="") {
		 //document.getElementById("validar").style.display="none";
		 document.getElementById("nocat2").innerHTML="<center>Nota: Este utilizador não tem catálogo na REDE</center>";
	   } else
	   {
		 //document.getElementById("validar").style.display="";
		 document.getElementById("exportparam").style.display="";
		 document.getElementById("nocat2").innerText="";
	   }
	  
	 }  
  },    
   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function muda_oper(ob) {
   for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
   switch (ob.options[i].value) {
     case 'in': 
	 case 'notin':{$("#inputTextoAnom").show();$("#case-sensitive").show(); $("#inputOcorrAnom").hide();break;}
	 default: {$("#inputOcorrAnom").show();$("#inputTextoAnom").hide();$("#case-sensitive").hide();break;}
   }
}


function muda_campo(ob) {
    var subc;
	$("#anomalias").html('');
	document.getElementById('scanom').options.length = 0;
    for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
    switch (ob.options[i].value) {
     case '005': subc=new Array();break;
	 case '010': subc=new Array('','a','b','d','z');break;
	 case '011': subc=new Array('','a','b','d','y','z');break;
	 case '021': subc=new Array('','a','b','z');break;
	 case '035': subc=new Array('','a','z');break;
	 case '100': subc=new Array('','a');break;
	 case '101': subc=new Array('','a','b','c','d','e','f','g','h','i','j');break;
	 case '200': subc=new Array('','a','b','c','d','e','f','g','h','i','v','z','5');break;
	 case '205': subc=new Array('','a','b','d','f','g');break;
	 case '210': subc=new Array('','a','b','c','d','e','f','g','h');break;
	 case '215': subc=new Array('','a','c','d','e');break;
	 case '225': subc=new Array('','a','d','e','f','h','i','v','x');break;
	 case '300': subc=new Array('','a');break;
	 case '307': subc=new Array('','a');break;
	 case '465': subc=new Array('');break;
	 case '467': subc=new Array('');break;
	 case '500': subc=new Array('','a','b','h','i','j','k','l','m','n','q','r','s','u','v','w','x','y','z','2','3');break;
	 case '600': subc=new Array('','a','b','c','d','f','g','j','p','t','x','y','z','2','3');break;
	 case '606': subc=new Array('','a','j','x','y','z','2','3');break;
	 case '675': subc=new Array('','a','v','z');break;
	 case '700': subc=new Array('','a','b','c','d','f','g','p','3','4');break;
	 case '701': subc=new Array('','a','b','c','d','f','g','p','3','4');break;
	 case '702': subc=new Array('','a','b','c','d','f','g','p','3','4','5');break;
	 case '710': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4');break;
	 case '711': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4');break;
	 case '712': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4','5');break;
	 case '720': subc=new Array('','a','f','3','4');break;
	 case '721': subc=new Array('','a','f','3','4');break;
	 case '722': subc=new Array('','a','f','3','4','5');break;
	 case '801': subc=new Array('','a','b','c','g','2');break;
	 case '856': subc=new Array('','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');break;
	 case '859': subc=new Array('','a','u','z');break;
	 case '921': subc=new Array('');break;
	 case '922': subc=new Array('');break;
	 case '923': subc=new Array('');break;
	 case '955': subc=new Array('');break;
	 case '966': subc=new Array('','a','c','e','l','m','p','s','0','1','2','3','4','5');break;
	 default: subc=new Array(); break;
	} 
	var $input = $("select[name='scanom']")
	$(subc).each(function(i, v){ 
      $input.append($("<option>", { value: v, html: v }));
	});
}


String.prototype.trim = function () {
return this.replace(/^\s*(\b.*\b|)\s*$/, '');
}
function Right(str, n)
{
      if (n <= 0)
          return "";
      else if (n > String(str).length)
          return str;
      else
   {
          var iLen = String(str).length;
          return String(str).substring(iLen, iLen - n);
      }
}

function chkfields(){
      document.getElementById("msgISO").style.display="";
	  
      var tmp=document.getElementById("expfile").value.toLowerCase();
	  var msg="";
      var x=document.getElementById("MFNate1").value;
	  var y=document.getElementById("MFNde1").value;
	  if (isNaN(y)) document.getElementById("MFNde1").value="1";
	  if (isNaN(x))  document.getElementById("MFNate1").value="9999999";
	  if (document.getElementById("expfile").value=="") msg="Erro: Falta indicar o nome do ficheiro de destino";
	  else if (Right(tmp,3) != "iso") msg="Erro: O ficheiro de destino deve ter a entensão ISO";
	  if (msg != "") {document.getElementById("expfile").focus();document.getElementById("expfile").select();alert(msg);} 
	  else { 
	  document.getElementById("msgISO").innerHTML='<br><span style="margin-left:-60px;color:red;font-size:0.8em;text-align:center">A processar... Aguarde um momento. </span>';
	  url ="../cgi/www.exe/[in=export3.in]?base="+document.getElementById("base1").value+"&expfile="+tmp+"&isofilepath=../tmp/&user=<%=lcase(session("user"))%>&tmppath=../tmp/&lim_inicio=" + document.getElementById("MFNde1").value+ "&limites="+document.getElementById("MFNate1").value+"&expressao=$";
	  new Ajax.Request(url, {     
	  method:"get",  
	  onSuccess: function(transport){       
	  var response = transport.responseText;
	  document.getElementById("msgISO").innerHTML=response; 
	  },    
	   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
      }
}
function limpa_msg(){
   document.getElementById('msgISO').innerHTML='';
}

function setText(){
var txt=document.getElementById('expfile');
if (txt.fireEvent)
	{
	txt.fireEvent('onchange');
	}
if (document.createEvent)
{
	var evt= document.createEvent('HTMLEvents');
	if (evt.initEvent)
	{
		evt.initEvent ('change',true,true);
	}
	if (txt.dispatchEvent)
	{
		txt.dispatchEvent(evt);
	}
}
}
function importar_ficheiro(str){
   var newwindow;
   switch(str){
   case "users": tmp="UT";break;
   case "leitores":tmp="LT";break;
   }
   newwindow=window.open('admin_imp_'+str+'.asp' , 'Upload'+tmp, 'width=480, height=470, dependent=yes, left=150 , top=150, menubar=no, scrollbars=no,status=yes');
   if (window.focus) {newwindow.focus()}
}

function mudahist(ob){  
   for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
      switch(ob.options[i].value) {
	     case 'X':  document.getElementById('exata').style.display='none';
		            document.getElementById('incampo').style.display='none';
					break;
		 case 'l':  
		 case 'b':  
		 case 'a':  document.getElementById('exata').style.display='';
		            document.getElementById('incampo').style.display='';
                    break;
		 case 'e':  document.getElementById('incampo').style.display='none';
		            document.getElementById('exata').style.display='';
                    break;		 
	  }     
}
</script>
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>
<% Function URLDecode(str) 
			str = Replace(str, "+", " ") 
			For i = 1 To Len(str) 
				sT = Mid(str, i, 1) 
				If sT = "%" Then 
					If i+2 <= Len(str) Then 
						sR = sR & _ 
							Chr(CLng("&H" & Mid(str, i+1, 2))) 
						i = i+2 
					End If 
				Else 
					sR = sR & sT 
				End If 
			Next 
            URLDecode = sR 
        End Function 
%>
<% Function writeLog (str) 
            Application.Lock()
			Dim objFSO, objTStream
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.openTextFile(Server.MapPath(vdir &"/upload/logs/admin.log"), 8, True)
			dia=day(now)
			mes=month(now)
			ano=year(now)
			hora=hour(now)
			minuto=minute(now)
			segundo= second(now)
			if len(segundo)=1 then segundo= "0" & segundo
			linha = dia & "-" & mes & "-" & ano & ";" & hora & ":" & minuto & ":" & segundo  & ";" & str
			objTStream.WriteLine linha & " [" & Request.ServerVariables("Remote_Addr") & "]" 
			objTStream.Close
			Set objTStream = nothing
			Set objFSO = nothing
			Application.Unlock
 End Function 
%>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>

<body >
  <div class="destaque1">
    <h1 style="font-variant: small-caps">Catálogo Coletivo:<br />  <%=sentidadelonga%></h1>
  </div>   
<%if not  Request.QueryString("Logout") = "1" then%>
	<form style="margin: 0px; padding: 0px;">
	<input type="file" name="file" style="display: none" />
	</form>    
	<%If Not Session("LoggedIn") = True  Then %>
<div class="destaque2">
			<h2>Autenticação de utilizadores</h2>
</div>
			<p class="fil">» <a href="../default.asp">Entrada</a> » Ativar modo de administração </p>		
	<%else%>
<!-- Segmento Navegação topo -->
  <div class="col3-contentor">
    <div class="col3">
    <p class="fil">» <a href="../default.asp">Zona pública</a>
		<%if request("op")="add" then %>
		» <a href="admin.asp<% if request("tipo")="lt" then response.write "?mnut=2" else response.write "?mnut=1" %>">Administração</a> » Novo utilizador</p>
		<%else%>
		 » Administração </p>
		<% end if%>	</p>
    </div>
    <div class="col3" id="lblutilizador">Utilizador: <span id="utilizador"> 
        <% if session("user")="" then response.write "Visitante" else response.write ucase(session("user"))%>
		<%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
		<%end if%>
	</span> 
    </div>
  </div>
<!-- Segmento Navegação topo - FIM -->						
			<div id="principal"> 
<% end if
If Request.QueryString("Logout") = "1" Then
    writeLog("LOGOUT - " & ucase(session("user")))
	Session("LoggedIn") = False
	session.Abandon()
	Response.Write("<meta http-equiv='Refresh' content='0; URL=admin.asp'>")
	response.end
End If

If Session("LogError") < 3 Then
		If Not Session("LoggedIn") = True Then			
				If Request.QueryString("Login") = "1" Then
				      
					  dim nm, pw, metodo  
  					  metodo = Request.ServerVariables("REQUEST_METHOD")  
					  if metodo = "POST" then  
							nm=ucase(Server.HTMLEncode(Replace(Request.Form("nickname"),"'","''"))) 
			 				pw = trim(lcase(Server.HTMLEncode(Replace(Request.Form("Password"),"'","''"))))
							strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkperm.in]?expressao=SIGLA "& nm)
							pos=instr(strHTML,"^c")
                            
							if pos>0 and mid(strHTML,pos+2,1)="1" then 
							    							    
								strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkuser.in]?expressao=SIGLA "& nm)
                            else
							    writeLog("LOGIN (insucesso) - " & ucase(nm))
								response.write "<h3 style=""margin-top:50px;color:red"">Acesso negado. O utilizador não tem permissões de administração no sistema...</h3>"
								response.write "<br>Contacte o administrador"
								Session("LogError")=Session("LogError")+1        
								response.end
							end if 							
													
							snh=OnlyAlphaNumericChars(Server.HTMLEncode(strHTML))             
							
						      'response.write "'"+snh+"'" & "<br>"
							  'response.write "'"+pw+"'" & "<br>"
							  'response.write strcomp(snh,pw,0) & "<br>"
							  'response.end
							  if strcomp(snh,pw,0)=0 then
								Session("LoggedIn") = True
								Session("user")= nm
								writeLog("LOGIN (sucesso) - " & ucase(session("user"))) 
								strPath=URLDecode(request("reqPath"))
								'response.write strPath
								'response.end
								if strPath<>"" then
								if instr(strPath,"admin")=0 then
									if instr(strPath,"www.exe")>0 then
										posi=instr(strPath,"ut=")
										if posi>0 then 
											posf= instr(posi,strPath,"&")
											termo= mid(strPath,posi,posf-posi)			
											strPath=replace(strPath,termo,"ut=" & session("user"))
									
										end if
										
									end if
									response.redirect strPath
								end if
							   end if
							   response.write "<p>&nbsp;</p>"
							   Response.Write("<p >Bem-vindo.</p>")
							   Response.Write("<p >Aguarde um momento para voltar à zona pública ou <br /><a href='admin.asp'>clique aqui para entrar diretamente</a> na administração!</p>")
							   Response.Write("<meta http-equiv='Refresh' content='3; URL=../default.asp'>")
							else
							   Session("LoggedIn") = false   
							end if     
							if not Session("LoggedIn") then
							   writeLog("LOGIN (insucesso) - " & ucase(nm))
							   response.write "<p>&nbsp;</p>"
							   Response.Write("<br /><br /><p >Dados incorretos. Por favor <a href=""admin.asp"">tente novamente</a>.</p>")
							   Session("LogError")=Session("LogError")+1        
							end if
					end if				
				Else
		%>	
				
					<form name="Login" action="admin.asp?Login=1" method="post" onSubmit="Password.value = hex_md5(Password.value);">
					<input type="hidden" name="reqPath" value="<%=server.URLEncode(replace(replace(replace(request.ServerVariables("HTTP_REFERER"),"%5B","["),"%5D","]"),"%3D","="))%>">
					<table  border="0" cellpadding="1" cellspacing="4" >					 
					  <tr>									
					  <td align="right" valign="middle"> Nome: </td>
						<td valign="middle"><input type="text" name="Nickname" size="20"></td>					
					  </tr>
					  <tr>								
					     <td align="right" valign="middle"> Senha: </td>
					     <td ><input type="password" name="Password" size="20"></td>
            </tr>
            <tr>
					  <td></td> 	
					  <td><input type="submit" value="Ok" class="botao botao5" onClick="return Password.value!=''"></td>					
					  </tr> 					  					 
					</table>
					</form> 		       
	<p>Nota: depois de se autenticar será enviado para a entrada do catálogo, mas já como utilizador identificado. 
	<br />Para aceder à administração do catálogo terá então de clicar na ligação direta 
	<br />que ficará visível, à direita, no topo e ao fundo da página de entrada.</p>
	<p>>> Também pode cancelar e <a href='../default.asp'>clicar aqui para voltar à entrada do catálogo</a> sem se autenticar.</p>
<%				End If
	
		Else 
			 
						
%>			 
            
			
			<% if request("op")<>"" then %>
			    
	<div id="admbotoes" style="float:right"><a href="admin.asp<% if ucase(session("user"))="ADMIN" then if request("tipo")="lt" then response.write "?mnut=2" else response.write "?mnut=1" end if else response.write "?id=5" %>"><img src="../imagens/picactions/icon_close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a></div><h3>Novo registo</h3>

    <% select case request("tipo")
	case "ut" %>
	<form name="frminuser" id="frminuser" action="" method="post">  
	<input type="hidden" name="ut" value="admin">
	<input type="hidden" name="base" value="users">
	<fieldset class="users"><legend>Dados da entidade</legend><br />
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
			<label for="v1">Código ID</label><input type="text" id="v1" name="v1" value=""onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
		<div class="col6">
			<label for="v3" >Nome</label> <input type="text" id="v3" name="v3" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" style="background-color:#f5f5dc">
			<label class="esp" for="v2">Sigla</label><input type="text" id="v2" name="v2" value=""  onBlur="chgColor(this,false);this.value=this.value.toUpperCase();" onFocus="chgColor(this,true)">
		</div>
		<div class="col6" style="background-color:#f5f5dc">
		<label class="esp" for="v7" >Senha</label><input type="password" id="v7" name="v7" value=""   maxlength="18" onKeyUp="pwdRob(this)" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)"><span id="pwd"></span>
		<label class="esp" for="confirma">Senha (repetir)</label><input type="password" id="confirma" name="confirma" value=""   maxlength="18" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>	
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<label for="v4" >Morada</label> <input type="text" id="v4" name="v4" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
		<div class="col6">
		<label for="v10" >Localidade</label><input type="text" id="v10" name="v10" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>	
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<label for="v6" >C.Postal (número e local)</label> <input type="text" id="v6" name="v6" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
		<div class="col6">
		<label for="v5" >Concelho</label> <input type="text" id="v5" name="v5" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<label for="v9" >Telefone</label><input type="text" id="v9" name="v9" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
		<div class="col6">
		<label for="v11" >Email biblioteca</label><input type="text" id="v11" name="v11" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<!--<label for="v12" >Sítio Web</label><input type="text" id="v12" name="v12" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">-->
		</div>
		<div class="col6">
		<!--<label for="v18" >Blogue</label><input type="text" id="v18" name="v18" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">-->
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<!--<label for="v17" >Responsável</label><input type="text" id="v17" name="v17" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">-->
		</div>
		<div class="col6">
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" >
		<label for="v23">Lat.(GPS) ex.: 38,703862</label><input type="text" id="v23" name="v23" value="" size="25" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
		<div class="col6">
		<label for="v22">Long.(GPS) ex.: -9,165374</label><input type="text" id="v22" name="v22" value="" size="25" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" style="background-color:#f9f9ed">
			<label for="v24" >Software de catalogação</label><select id="v24" name="v24" onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
			<option value="">Não definido</option><option value="Bibliobase" >Bibliobase</option><option value="Porbase" >Porbase5/Prisma</option><option value="Docbase" >Docbase/Docbase 3W</option><option value="GIB" >GIB</option><option value="Horizon" >Horizon</option><option value="Biblionet" >Biblio.net</option><option value="Docbaseisis" >Docbase Isis</option><option value="Koha" >Koha</option></select>
		</div>
		<div class="col6" style="background-color:#f9f9ed">
			<label for="v26" >Codificação do ISO2709 (Bibliobase, Docbase Isis = ASCII. Outros = ANSI)</label><select id="v26" name="v26" onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
			<option value="ansi">Ansi</option><option value="ascii" >Ascii</option></select>
		</div>
	</div>
	<div class="col6-contentor" style="width:100%">
		<div class="col6" style="min-width:50%;background-color:#f5f5dc">
			<label class="esp" for="v21">Sigla do Agrupamento</label><input type="text" id="v21" name="v21" value=""  onBlur="chgColor(this,false);this.value=this.value.toUpperCase();" onFocus="chgColor(this,true)">
		<br />(Se é Agrupamento = vazio)
		</div>
		<div class="col6" style="min-width:50%;background-color:#f5f5dc">
			<label class="esp" for="v25">Estatuto no catálogo</label><select id="v25" name="v25"  onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
			<option value="0">Autónoma</option><option value="1">Não autónoma</option></select>
			<br />(Se é Agrupamento = Autónoma / Se pertence a agrup. = Não autónoma)
		</div>
		</div>
		<br /><br /><center><input  type="submit" name="bt1" class="botao botao4" value="Confirmar" onClick="return chkuser();">
		<input type="button" name="bt2" class="botao botao5" value="Cancelar" onClick="javascript:history.back()"></center>
		</fieldset>
		</form>
		 <% case "lt" %>
			<form name="frminleitor" id="frminleitor" action="" method="post">  
			<input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
			<input type="hidden" name="base" value="leitor">
			<% 
			strLT=getUrl(strROOT & "/cgi/www.exe/[in=getnlt.in]")					  
			%>
		<fieldset class="users"><legend>Dados de leitor</legend><br />
			<div>
			<label for="v1" ><span>Nº leitor </span></label><input type="text" id="v1" name="v1" value="<%=strLT%>" size="12" readonly>
			<label for="v20"><span>Biblioteca</span></label>
			<%if ucase(session("user"))="ADMIN" then%>
			<select id="v20" name="v20" onChange="javascript:getbiblio()" style="margin-bottom:3px">
			<option value="">Selecionar</option>
			<% 
				strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relinstB.in]")
				entidades=split(strHTML,",")
				for i=0 to ubound(entidades)-1
				response.write "<option value='" & entidades(i) & "'>" & entidades(i) & "</option>"
			next							  
				%>
			</select>
			<% else %>
				<input type="text" name="v20" id="v20" readnoly value="<%=ucase(session("user"))%>">							   
			<%end if%>	
			<label class="esp1" id="labelbib" name="labelbib"></label>
			</div>
      <br />
		<div id="imgLeitor"><img id="imlt" name="imlt" src="../imagens/picextra/no_photo.jpg" width="100" height="105" alt="Foto do(a) leitor(a)" title="Foto do(a) leitor(a)"></div>
		<label for="v2" ><span>Nome</span></label><input class="extra1" type="text" id="v2" name="v2" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<label for="v3" ><span>Data nasc.</span></label><input class="extra1" type="text" id="v3" name="v3" value="" size="12" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
        <br />(formato data: mm-dd-aaaa)<br />
		<label for="v4" ><span>Morada</span></label><input class="extra1" type="text" id="v4" name="v4" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<label for="v6" ><span>C.Postal</span></label><input class="extra1" type="text" id="v6" name="v6" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<label for="v5" ><span>Concelho</span></label><input class="extra1" type="text" id="v5" name="v5" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<label for="v7" ><span>Telefone</span></label><input class="extra1" type="text" id="v7" name="v7" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<label for="v9" ><span>Email</span></label><input class="extra1" type="text" id="v9" name="v9" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
		<!--<label for="v10" ><span>Sítio Web</span></label><input class="extra2" type="text" id="v10" name="v10" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">-->
		<!--<label for="v8" ><span>Profissão</span></label><input class="extra2" type="text" id="v8" name="v8" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">-->
		<label for="v11" ><span>Foto</span></label><input class="extra1" type="text" id="v11" name="v11" value="" size="81" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)"><input type="button" name="btim" onClick="javascript:getDirImg();" value="Carregar ficheiro... " class="botao botao3"  
		<br /><br /><center><input  type="submit" name="bt1" class="botao botao4" value="Confirmar" onClick="return chkleitor();">
							<input type="button" name="bt2" class="botao botao5" value="Cancelar" onClick="javascript:history.back()"></center>
							</fieldset>
						 </form>
					 <% end select %>	 
            <% else  %>
                <br><br>
	 <ul id="tabs" class="shadetabs">
<%if lcase(session("user"))="admin" then %>		  
      <li><a href="#" rel="tab1" class="selected">Utilizadores</a></li>											  
      <li><a href="#" rel="tab2">Acessos</a></li>
<% else %>
      <li><a href="#" rel="tab3" class="selected">&nbsp;&nbsp;&nbsp;Perfil&nbsp;&nbsp;&nbsp;</a></li> 												
      <li><a href="#" rel="tab4">O meu catálogo</a></li>					
<% end if %>            
      <li><a href="#" rel="tab6">Reservas</a></li>
      <li><a href="#" rel="tab7">Coleção</a></li>
      <li><a href="#" rel="tab9">Bases</a></li>	
<%if lcase(session("user"))<>"admin" then %>
      <li><a href="#" rel="tab10">Utilizadores</a></li>
<% else %>
      <li><a href="#" rel="tab10">Parametrizações</a></li>	  
<% end if %>
      <!--<li><a href="#" rel="tab11">Social</a></li>-->
      <li><a href="#" rel="tab12">Infos</a></li> 
	 </ul>
	 <div id="painel">      			
     				<div id="tab1" class="tabcontent">					     						  
						   <dl style="margin-left:5px;margin-top:15px;">
						   <dt style="font: 10pt Arial"><a href="admin.asp?mnut=1" <% if request("mnut")="1" or request("mnut")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>">Institucionais</a><a href="admin.asp?mnut=2" <% if request("mnut")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>">Individuais</a></dt><br><br>
						   </dl>
						   <dl class="tabsubmenu">
						   <% select case request("mnut")
						     		 
					         case "","1" %> 

							<dd><a href="../cgi/www.exe/[in=relusers.in]?ut=<%=ucase(session("user"))%>&d=<%=datediff("s", "1/1/1970 12:00:00 AM", now())%>">Editar entidade</a></dd>
							<form name="frmnovouser" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="admin">
				    		<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="ut">
							</form>	
							<dd><a href="javascript:document.frmnovouser.submit()">Nova entidade</a></dd> 
							<form name="frmlistauser" action="../cgi/www.exe/[in=listuser.in]" method="post" >
					   		<input type="hidden" name="ut" value="admin">
				 			</form>  
							<dd><a href="javascript:document.frmlistauser.submit()">Lista geral</a></dd>
							<dd><a href="#" onClick="javascript:importar_ficheiro('users');">Importar ficheiro externo</a></dd>

							<%case "2"%>
							
							 <dd><a href="../cgi/www.exe/[in=pesqleitor.in]?expressao=$&ut=<%=ucase(session("user"))%>&from=1&to=25">Editar leitor</a></dd>
							<form name="frmnovoleitor" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="admin">
				    		<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="lt">

							</form>	
							<dd><a href="javascript:document.frmnovoleitor.submit()">Novo leitor</a></dd>
							<form name="frmlistaleitor" action="../cgi/www.exe/[in=listleitor.in]" method="post" >
					   		<input type="hidden" name="ut" value="admin">
							<input type="hidden" name="expressao" value="$">
				 			</form>  
							<dd><a href="javascript:document.frmlistaleitor.submit()">Lista geral</a></dd>
							<dd><a href="#" onClick="javascript:importar_ficheiro('leitores');">Importar ficheiro externo</a></dd>
							<%end select %>
							</dl>
					    
					</div> 
					<div id="tab2" class="tabcontent">
					 	
						 <br />
						 <dl class="tabmainmenu"> 		 				
							 
								<form name="frmdisplog" action="displog.asp"  method="post" >
								   <input type="hidden" name="ut" value="admin">

								</form>
							<dd><a href="javascript:document.frmdisplog.submit()">Visualizar acessos ao sistema de administração</a></dd>
								<form name="frmcleanlog" action="cleanlog.asp" method="post" >
								   <input type="hidden" name="ut" value="admin">

								</form>
							<dd><a href="javascript:document.frmcleanlog.submit()"  OnClick= "return confirm('Tem memsmo a certeza que quer reiniciar o ficheiro de acessos ao sistema de administração [LOGS]?')">Reiniciar o ficheiro de acessos</a></dd> 
						</dl>		
                    </div>
					   
					
		     
                 <div id="tab3" class="tabcontent">
					 	
						 <br />
				 <dl class="tabmainmenu"> 		 
				 
				 <dd><a href="../cgi/www.exe/[in=seluser.in]?ut=<%=ucase(session("user"))%>&base=users&expressao=SIGLA <%=ucase(session("user"))%>" >Editar ficha da entidade</a></dd>
				 </dl>
				 </div>
				<div id="tab4" class="tabcontent">
						
						 <br />

				<dl class="tabmainmenu"> 				    
				  
				 <%  
				   dim uflag
				   on error resume next
		           Set fs = CreateObject("Scripting.fileSystemObject")
				   if fs.FileExists(Server.MapPath(vdir & "/bases/" & lcase(session("user"))& ".mst"))=true then	         				  
					  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relbases.in]")
					  entidades=split(strHTML,",")
					  'response.write strHTML
					  for i=0 to ubound(entidades)-1
						  if strcomp(ucase(entidades(i)),ucase(session("user")),0)=0 then 
							   uflag=true
							   exit for
						  end if 	   
					  next
                  end if
				  on error goto 0
				  if  uflag then %>
				     <dd><a href="catind.asp?id=0&base=<%=lcase(session("user"))%>">Pesquisa simplificada</a></dd>
					 <dd><a href="catind.asp?id=1&base=<%=lcase(session("user"))%>">Pesquisa orientada</a></dd>
					 <dd><a href="catind.asp?id=2&base=<%=lcase(session("user"))%>">Pesquisa avançada</a></dd>
					 <dd><a href="catind.asp?id=3&base=<%=lcase(session("user"))%>">Pesquisa por termos</a></dd>
				  <%
				   else 
				     response.write "Nota: Esta entidade não tem catálogo na REDE" 
				     if ucase(session("user"))<>"ADMIN" then writeLog("AVISO: O utilizador " & ucase(session("user")) & " não está definido em 'database.lst'")
				  end if
				  %>
				  </dl>			              				
				 </div>
				    
                 <div id="tab6" class="tabcontent">
					     <dl style="margin-left:5px;margin-top:15px;">
  					     <dt style="font: 10pt Arial">
  					 <a href="admin.asp?id=2&mnres=1" <% if request("mnres")="1" or request("mnres")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Listagens</a>
						 <a href="admin.asp?id=2&mnres=2" <% if request("mnres")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Estatísticas</a>
						 <a href="admin.asp?id=2&mnres=3" <% if request("mnres")="3" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Gestão</a>
						 </dl>
						 <dl class="tabsubmenu1">

						 <% select case request("mnres")
						 
						    case "","1" %> 
						 <h4>Estado da reserva</h4>
						 <p>
						 <form name="frmgesres" id="frmgesres" action="../cgi/www.exe/[in=gesres.in]" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" name="dbmin" value="<%=lcase(session("user"))%>">
						 <input type="hidden" name="base" value="reservas">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" value="9999999">
						 <input type="hidden" name="express" id="express" value="<% if ucase(session("user"))="ADMIN" then %>$<% else %>AGR <%=ucase(session("user"))%> OR BIB <%=ucase(session("user"))%><%end if%>">

						 <select name="estado" id="estado" style="width:75%">
						   <option value="X" selected>[Todas]</option>
						   <option value="0">Pendentes</option>
						   <option value="1">Confirmadas</option>   
						 </select>
						 <input type="button" class="botao botao1" value="Selecionar" onClick="getActionRes();return false;">
						 
						 </form>
						 </p>
						    <% case "2"%>
						 <dd><form name="frmestat" id="frmestat" action="estat.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmestat.submit();">Pedidos de Reserva [entidades requisitantes] </a>
						 </form></dd>
						 <dd><form name="frmestat1" id="frmestat1" action="estat1.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmestat1.submit();">Pedidos de Reserva [entidades requisitadas] </a>
						 </form></dd>
						  <dd><form name="frmtop10" id="frmtop10" action="top10.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmtop10.submit();">Os 10 leitores que mais reservam </a>
			            </form></dd>
			             
			       <% case "3"%>						 
								 <form name="frmHistRes" id="frmHistRes" action="../cgi/www.exe/[in=relres.in]?p=<%=base64%>" method="get">   
								 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
								 <input type="hidden" name="express1" id="express1" value="">
								 <dt style="font-weight:normal">
								 
								 <dd><label for="situacao"><span>Situação: </span></label><input type="checkbox" name="situacao" id="sitpend" value="1" checked> Pendentes <input type="checkbox" name="situacao" id="sitconf" value="3" > Confirmadas <input type="checkbox" name="situacao" id="sitcanc" value="5" > Canceladas</dd>
								 <dd><label for="ambito"><span>Âmbito: </span></label><input type="checkbox" name="ambito" id="recebidas" value="1" checked> Recebidas &nbsp;<input type="checkbox" name="ambito" id="pedidas" value="3" > Efetuadas </dd>
								 <dd><label for="ophist"><span>Critério: </span></label></dd>
								 <select name="ophist" id="ophist" onchange="mudahist(this)">
							       <option value="" selected>&lt;Selecione&gt;</option>
								   <option value="X">[Todas]</option>
								   <option value="l">Leitor nº</option>
								   <option value="b">Biblioteca</option>
								   <option value="a">Agrupamento</option>
								 </select>
								 <input type="text" name="incampo" id="incampo" value="" style="display:none" onkeydown="if (event.keyCode == 13) document.getElementById('btnhistres').click()">
								 <input type="checkbox" name="exata" id="exata" style="display:none" title="pesquisa exata">
								 <input type="button" id="btnhistres" value="Selecionar" class="botao botao1" onClick="getActionHistRes('<%=ucase(session("user"))%>');return false;">
									</form>			             
              </dt>	
						 <% end select %>
					  </dl>
				   </div>
				  <div id="tab7" class="tabcontent" style="margin-left:5px;margin-top:67px">
						 <h4>Avaliação das existências<h4>
						 <form name="frmgescol" id="frmgescol" action="" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" name="base" value="rbcatalogo">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" value="9999999">
						 <input type="hidden" id="mnu" name="mnu" value="">
						 <input type="hidden" name="expressao" id="expressao" value="">

						 <p>Analisar:<br /> <select name="criterio" id="criterio" style="width:75%">
						   <option value="X" selected>[Toda rede]</option>
						   <option value="i">Por Instituição</option>
						   <option value="c">Por CDU</option>  
						 </select>
						 <input type="button" class="botao botao1" value="Selecionar" onClick="getOp(); return false;">			 
						 </form></p>
					</div>	 
				
				  <div id="tab9" class="tabcontent">				 
						 
						 <% if lcase(session("user"))="admin" then 
								strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relinstB.in]")
								entidades=split(strHTML,",")				   
						  end if
						  if lcase(session("user"))="admin" then
						      if ubound(entidades)>0 then
						        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getmfns.in]?base=" & lcase(entidades(0)))
							  end if	
						  else
						        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getmfns.in]?base=" & lcase(session("user")))
						  end if		
						  totregs=strHTML
						  
						  %>
						   
						   <dl style="margin-left:5px;margin-top:15px;">
						   <dt >
						   <a href="admin.asp?id=4&mnbases=1" <% if request("mnbases")="1" or request("mnbases")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Carregar ISO</a>
						   <a href="admin.asp?id=4&mnbases=2" <% if request("mnbases")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Exportar</a>
						   <a href="admin.asp?id=4&mnbases=3" <% if request("mnbases")="3" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Validar registos</a>
						   </dt><br>
						   </dl>
						   <dl class="tabsubmenu1">
						   <% select case request("mnbases")

					       case "","1" 					     		 
						   Set fs = CreateObject("Scripting.fileSystemObject")
						   if uflag or ucase(session("user"))="ADMIN"  then
						   
						   %> 

					 <h4>Enviar ficheiros bibliográficos para o servidor</h4>
<p>A atualização dos registos da sua biblioteca é efetuada pelo carregamento de um ficheiro ISO (formato ISO2709).<br /> Esse ficheiro é o exportado do programa de catalogação da sua biblioteca e deve conter todos os registos da base de dados.</p>
					 <form>
					 <h5 >Carregar o ficheiro ISO: <br /><a href="#" onClick="javascript:window.open('admin_iso_upload.asp?window=yes', 'DocUpload', 'width=600, height=340, dependent=yes, left=150 , top=150, menubar=no, scrollbars=no,status=yes');"><button type="button" class="botao botao3" style="width:50%;">Clique aqui para abrir uma nova janela e escolher o ficheiro a enviar</button></a></h5>
					 </form>
  <div class="destaquemoldura">
<p class="aviso">Importante: o nome do ficheiro terá de ter apenas a sigla concelhia da sua biblioteca mais a extensão .ISO (p. ex.: EBsol.iso). O uso de maiúsculas é indiferente.</p>
<p>Aplicação das atualizações: semanalmente será executada uma rotina automática no servidor para integrar o seu novo ficheiro na base pesquisável pelo público.</p>
			  </div>				
						 <div style="padding-left:20px">
						    <br /><hr>
						    <h4>Último carregamento efetuado: </h4>
							<p><% if lcase(session("user"))="admin" then %>
							  Selecione a entidade: <br />
							  <select id="base2" name="base" style="width:80%" onChange="muda_base(this)">
							  <% for i=0 to ubound(entidades)-1 %>
								 <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
							  <% next%>
							  </select>
							  </p>
							 <% end if %>
							<div style="display:inline-block">
							<ul style="padding-left:40px;list-style-type: none;">
								<li><div style="width:100px;display:inline-block">ISO 2709: </div> <span class="aviso" id="fiso"></span><span class="aviso" id="fsize"></span></li>
								<li><div style="width:100px;display:inline-block">Data/hora:</div> <span class="aviso" id="time"></span></li>
								<li><div style="width:100px;display:inline-block">Software:</div> <span class="aviso" id="soft"></span></li>
								<li><div style="width:100px;display:inline-block">Codificação:</div> <span class="aviso" id="codepage"></span>&nbsp;<span class="aviso" id="alerta"></span></li>
							</ul> 
							</div>   
						</div>
                           <% else 
						      response.write "Nota: Esta entidade não tem catálogo na REDE" 
						  end if %>	 
					    
						 <% case "2" %>	

						 <% if uflag or ucase(session("user"))="ADMIN"  then %>
						<h4>Exportação de registos [formato ISO 2709]</h4>
						 				
						 <input type="hidden" name="user" value="<%=lcase(session("user"))%>">
						 <input type="hidden" name="isofilepath" value="../tmp/">
						 <input type="hidden" name="tmppath" value="../tmp/">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" id="limites" value="<%=totregs%>">
						 <input type="hidden" name="expressao" id="expressao" value="$">
<div class="col5-contentor">
    <div class="col5">					 
						 <% if lcase(session("user"))="admin" then %>				 
						  Base de dados: <br /> 
						  <select id="base1" name="base" onChange="muda_base(this)">
						  <% for i=0 to ubound(entidades)-1 %>
						     <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
						  <% next%>
						  </select>  
					<% else %>
					 	<input type="hidden" id="base1" name="base" value="<%=lcase(session("user"))%>"> 
					<%end if%>
						  </div>
    <div class="col5">MFN's: (de) <br /><input type="text" id="MFNde1" name="MFNde" value="1" size="7">&nbsp; 

    </div>
    <div class="col5">até (de) <br /><input type="text" id="MFNate1" name="MFNate" value="<%=totregs%>" size="7"  onkeyup="checkValInput(this)">
    </div>
	</div>
				 
						 <div id="exportparam"> 
						 <p><b>Nome do ficheiro (guardar como)</b>
						 <br />
						 Nota: No final do nome deve adicionar <b>.iso</b> (a extensão é precedida de um ponto, como em <b>exportado.iso</b>)<br />	
						 <input type="text" id="expfile" name="expfile" size="30" style="width:80%" onChange="limpa_msg();" onClick="setText();"> <input type="button" name="exportar" value="Exportar" class="botao botao1" onClick="chkfields();">
						 <br>
						 </div>
						 <div id="nocat2" style="margin:0 0 0 -80px"></div> 
						 <div id="msgISO" style="display:none;text-align:center"></div>
						  <% else 
						      response.write "Nota: Esta entidade não tem catálogo na REDE" 
						  end if %>
						 </p>			  

						  <%case "3" %>
						     
							 <form name="frmvalid" id="frmvalid" action="valida.asp" method="post">  
							 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
							 <input type="hidden" id="mnu" name="mnu" value="6">
							<div id="caixa" style="float:left:width:90%">
                                  <h4>Listagem de erros</h4>
						   	<div> 
<div class="col5-contentor">
    <div class="col5">
	<% if lcase(session("user"))="admin" then %>Base de dados: 
							  <select id="base" name="base" onChange="muda_base(this)">
							  <% for i=0 to ubound(entidades)-1 %>
								 <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
							  <% next%>
							  </select>
							 <% else %>
								<input type="hidden" id="base" name="base" value="<%=lcase(session("user"))%>"> 
							 <%end if%>
    </div>
    <div class="col5"><input type="hidden" id="nregs" name="nregs" value="<%=totregs%>">
							 <input type="hidden" name="expressao" id="expressao" value="$">
							 MFN's: (de) <input type="text" id="MFNde" name="MFNde" value="1" size="7" onkeyup="checkValInput(this)">
    </div>
    <div class="col5">(até) <input type="text" id="MFNate" name="MFNate" value="<%=totregs%>" size="7" onkeyup="checkValInput(this)">
							<input type="submit" value="Ok" class="botao botao1" id="validar" name="Submit">
    </div>
</div>
<h4>Análise seletiva (campo/subcampo/nº de ocorrências ou texto)</h4>
<p>(pesquisa na base e registos acima definidos)</p>
<div>
<div class="col5-contentor" style="background-color:#f9f9ed;">
    <div class="col5">
	Campo: &nbsp;&nbsp;&nbsp;<select id="canom" name="canom" onChange="muda_campo(this)">
								<option value="005">005-Identificador da versão</option>
								<option value="010">010-ISBN </option>
								<option value="011">011-ISSN</option>
								<option value="020">020-Número bibliográfico nacional</option>
								<option value="021">021-Depóstito legal</option>
								<option value="035">035-Outros números de identificação</option>
								<option value="100">100-Dados gerais de processamento</option>
								<option value="101">101-Língua</option>
								<option value="200">200-Título e menção de responsabilidade</option>
								<option value="205">205-Edição</option>
								<option value="210">210-Publicação</option>
								<option value="215">215-Descrição física</option>
								<option value="225">225-Séries</option>
								<option value="300">300-Notas gerais</option>
								<option value="307">307-Notas (descrição física)</option>
								<option value="465">465-</option>
								<option value="467">467-</option>
								<option value="600">600-Assunto (nome de pessoa)</option>
								<option value="606">606-Assunto (nome comum)</option>
								<option value="675">675-Classificação Decimal Universal</option>
								<option value="700">700-Menção de respons. principal (pessoa)</option>
								<option value="701">701-Outra menção de respons. (pessoa)</option>
								<option value="702">702-Menção de respons. secundária (pessoa)</option>
								<option value="710">710-Menção de respons. principal (coletividade)</option>
								<option value="711">711-Outra menção de respons. (coletividade)</option>
								<option value="712">712-Menção de respons. secundária (coletividade)</option>
								<option value="720">720-Menção de respons. principal (família)</option>
								<option value="721">721-Outra menção de respons. (família)</option>
								<option value="722">722-Menção de respons. secundária (família)</option>
								<option value="801">801-Origem do registo</option>
								<option value="856">856-URL</option>
								<option value="859">859-</option>
								<option value="921">921-Nível hierárquico</option>
								<option value="922">922-Nível bibliográfico</option>
								<option value="930">930-Cota sumário</option>
								<option value="955">955-</option>
								<option value="966">966-Exemplar</option>							
							  </select>
	</div>
    <div class="col5">
	Subcampo: <select id="scanom" name="scanom">
								<option value="" selected></option>
							  </select>	
    </div>
	</div>
  <div class="col5-contentor" style="background-color:#f9f9ed;">
    <div class="col5">
	Operador: <select id="opanom" name="opanom" onChange="muda_oper(this)">
								<option value="<"><</option>
								<option value="=" selected>=</option>
								<option value=">">></option>
								<option value="in">contém</option>
								<option value="notin">não contém</option>
							  </select>
    </div>
    <div class="col5">
	<span id="inputOcorrAnom">Ocorrências): <input type="text" id="ncanom" size="2" value="0"  onKeyup="checkValInput(this)"></span>
                              &nbsp;<span id="inputTextoAnom" style="display:none">Texto <input type="text" id="txtanom" size="12" value="" ></span>
							  <span id="case-sensitive" style="display:none"><img src="../imagens/picactions/case_sensitive.png" align="absmiddle"/><input type="checkbox" value="" id="case" style="margin:-8px 0 0 0;vertical-align:bottom;font-size:1.6m"></span>&nbsp;
				      		  &nbsp;<input type="button" value="Ok" class="botao botao1" onclick="showDBanom();">
    </div>
  </div>

</div>

<div  id="anomalias" ></div>
</div>
							</form>
							<div id="nocat1" style="margin:30px 0 0 -80px"></div> 
							 <br />								 	
					<% end select%>
					</dl>	
					</div>
<!-- Separador Utilizadores -->
					<%if lcase(session("user"))<>"admin" then %>	 	
   					<div>
					<div id="tab10" class="tabcontent">						
						 <br />
						 <dl class="tabmainmenu">
						 <dd><a href="../cgi/www.exe/[in=pesqleitor.in]?expressao=SI <%=ucase(SESSION("user"))%>&ut=<%=ucase(SESSION("user"))%>&from=1&to=25">Editar leitor</a></dd>
							<form name="frmnovoleitor1" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="<%=ucase(SESSION("user"))%>">
							<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="lt">
						
							</form>	
							<dd><a href="javascript:document.frmnovoleitor1.submit()">Novo leitor</a></dd>
							<form name="frmlistaleitor1" action="../cgi/www.exe/[in=listleitor.in]" method="post" >
							<input type="hidden" name="ut" value="<%=ucase(SESSION("user"))%>">
							<input type="hidden" name="expressao" value="SI <%=ucase(SESSION("user"))%>">
							</form>  
							<dd><a href="javascript:document.frmlistaleitor1.submit()">Lista geral</a></dd>						
						</dl>
					</div>
						
<!-- Separador parametrizações -->
					<% else 
					 if lcase(session("user"))="admin" then 
						strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpar.in]")
						valores=split(strHTML,",")
		   
					 end if%>	  
<div id="tab10" class="tabcontent">
<div>						
  <div class="col5-contentor" style="width:100%">
    <div class="col5" style="min-width:50%">
		<p><fieldset ><legend>Sistema</legend>
			<label for="estado" class="param">Estado   :</label><br /><input type="radio" name="estado" id="estado1" <% if valores(2)="S" then response.write " checked" end if %>> Em linha  <input type="radio" name="estado" id="estado2" <% if valores(2)="N" then response.write " checked" end if %>>Manutenção
		</fieldset></p>
	<p><fieldset><legend>Empréstimos</legend>
			<label for="empind" class="param">Individual:</label><br /><span name="empind" ><input type="radio" name="ei" id="ei1"  <% if valores(3)="S" then response.write " checked" end if %>>Ativado <input type="radio" name="ei" id="ei2"  <% if valores(3)="N" then response.write " checked" end if %>>Desativado</span><br><span style="clear:left"></span> <br />
			<label for="empbib" class="param" >Interbibliotecas:</label><br /><span name="empbib"><input type="radio" name="eib" id="eib1"  <% if valores(4)="S" then response.write " checked" end if %>>Ativado <input type="radio" name="eib" id="eib2"  <% if valores(4)="N" then response.write " checked" end if %>>Desativado</span> 
		</fieldset></p>
	<p><fieldset><legend>Reservas</legend>
		<label for="limres" class="param">Documentos - Limite máximo:</label><input type="text" name="limres" id="limres" value="<%=valores(0)%>" size="2">
		<label for="maxres" class="param">Reservas - N.º de dias:</label> &nbsp;<input type="text" name="maxres" id="maxres" value="<%=valores(1)%>" size="2"><br>
		<form name="frmsetcal" id="frmsetcal" action="calendario.asp" method="post" style="margin:6px;font-size:0.9em;height:20px">  
		<input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
		<input type="hidden" id="mnu" name="mnu" value="2">
		<input type="hidden" name="expressao" id="expressao" value="">
		<input type="button" class="botao botao5" onClick="javascript:document.frmsetcal.submit();" value="Férias e feriados">
		</form>
		<br /><br />
		</fieldset></p>
    </div>
    <div class="col5" style="min-width:50%;background-color:#f9f9ed;">
		<p><fieldset><legend>Bases bibliográficas</legend>
			<label for="valida" class="param">Validação:</label><br /><input type="radio" name="valida" id="valida1"  <% if valores(5)="S" then response.write " checked" end if %>>Ativado <br /><input type="radio" name="valida" id="valida2"  <% if valores(5)="N" then response.write " checked" end if %>>Desativado 
		</fieldset></p>
		<p><fieldset><legend>Gráficos [orientação]</legend>
			<label for="gres" class="param">Reservas:</label><br /><input type="radio" name="gres" id="gres1"  <% if valores(6)="S" then response.write " checked" end if %>>Horizontal <br /><input type="radio" name="gres" id="gres2" <% if valores(6)="N" then response.write " checked" end if %>>Vertical <br /><br /><span style="clear:left"></span>
		</fieldset></p>
		<p><fieldset><legend>Gráficos [tipo/orientação]</legend>
			<label for="gcol" class="param">Coleção :</label><br /><input type="radio" name="gcoltip" id="gcoltip1"  <% if valores(9)="S" then response.write " checked" end if %> onClick="mudagrafop(this)">Colunas <input type="radio" name="gcoltip" id="gcoltip2"  <% if valores(9)="N" then response.write " checked " end if %> onClick="mudagrafop(this)">Circular <br /><br /><span id="grafori" <% if valores(9)="N" then response.write "style=display:none"  end if %>><input type="radio" name="gcol" id="gcol1"  <% if valores(7)="S" then response.write " checked" end if %>>Col. Horizontal <br /><input type="radio" name="gcol" id="gcol2"  <% if valores(7)="N" then response.write " checked" end if %>>Col. Vertical</span>			   
		</fieldset></p>
    </div>
		</div>
	</div>
		<div style="margin-top:20px;text-align:center;"><input type="button" class="botao botao1" value="Atualizar" onClick="act_param_res()"> </div>
	<%end if%>
</div>
	<!-- Separador parametrizações FIM -->
<!-- Separador Social -->
					<div id="tab11" class="tabcontent">							
						 <dl style="margin-left:5px;margin-top:67px;">
					     <dd><a href="/rbcatalogo/cgi/www.exe/[in=lstcomm.in]?expr=$&ut=<%=session("user")%>">Comentários</a></dd>
					     <dd><a href="lstvotos.asp?id=7" >Votações</a></dd>			
						 </dl>
					</div>				
<!-- Separador Social FIM -->
<!-- Separador Infos -->
					<div id="tab12" class="tabcontent">
						 <dl style="margin-left:5px;margin-top:27px;">
						 <dt>Catálogo Coletivo</dt>
  					     <dd>Entidade: <a style="text-decoration:none" href="<%=surlPORTAL%>" target="_blank"><%=sentidadelonga%></a></dd>
  					     <dd>Bibliotecas parceiras: <a style="text-decoration:none" href="/rbcatalogo/admin/fpdf/main.asp" target="_blank">Nomes e contactos (em PDF)</a></dd>
						  <br />
						  <dt>Guias e Apoio</dt>
  					     <dd>Guia de Utilização (básico) - <a style="text-decoration:none" href="../ajuda_dicas.asp">Público em geral</a></dd>
  					     <dd>Guia de Utilização (avançado) - <a style="text-decoration:none" href="https://sites.google.com/view/pesquisarcatalogo" target="_blank">Público em geral</a></dd>
  					     <dd>Guia de Utilização - <a style="text-decoration:none" href="https://sites.google.com/view/opacrbe/biblio" target="_blank">Bibliotecários</a></dd>
  					     <dd>Guia de Utilização - <a style="text-decoration:none" href="https://sites.google.com/view/opacrbe/tec" target="_blank">Informáticos</a></dd>
						 <br />
						  <dt>Tecnologia</dt>
  					     <dd>Software: <%=sversao%></dd>
  					     <dd>Desenvolvimento: <a style="text-decoration:none" href="<%=surlRBE%>" target="_blank">Projeto RBE-Redes Concelhias</a></dd>
  					     <dd>Contacto: redes.concelhias@mail-rbe.org</dd>
  					     </dl>
					</div>
				</div>
			</div>
		  <%end if%>		
		  
		    
		<script type="text/javascript">
       <% if request("op")="" then %>
		var menus=new ddtabcontent("tabs")
		menus.setpersist(true)
		menus.setselectedClassTarget("link") //"link" or "linkparent"
		menus.init()
	
		</script>
		
		<script>menus.expandit(<% if request("id")="" then response.write 0 else response.write request("id") end if%>)</script> 
		<%end if%>
     <%
       end if
	   	
	Else
		writeLog("LOGIN (insucesso): nº máx de tentativas")
		Response.Write("<br /><br /><p>Esgotou as três tentativas de ENTRADA no sistema de administração. <br />Terá de fechar o browser e iniciar nova sessão!</p>")
		
	End If
%> 
</div>
<%
Public Function OnlyAlphaNumericChars(ByVal OrigString)
'***********************************************************
'INPUT:  Any String
'OUTPUT: The Input String with all non-alphanumeric characters 
'        removed
'EXAMPLE Debug.Print OnlyAlphaNumericChars("Hello World!")
         'output = "HelloWorld")
'NOTES:  Not optimized for speed and will run slow on long
'        strings.  If you plan on using long strings, consider 
'        using alternative method of appending to output string,
'        such as the method at
'        http://www.freevbcode.com/ShowCode.Asp?ID=154
'***********************************************************
    Dim lLen
    Dim sAns 
    Dim lCtr     
	Dim sChar
    
    OrigString = Trim(OrigString)
    lLen = Len(OrigString)
    For lCtr = 1 To lLen
        sChar = Mid(OrigString, lCtr, 1)
        If (Mid(OrigString, lCtr, 1) >="0" and Mid(OrigString, lCtr, 1) <="9") or (Mid(OrigString, lCtr, 1) >="a" and Mid(OrigString, lCtr, 1) <="z") Then
            sAns = sAns & sChar
        End If
   
    Next
        
    OnlyAlphaNumericChars = sAns

End Function

sub lista_bases

end sub
 
%>
	