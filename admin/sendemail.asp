<!--#include file="functions.asp"-->
<body style="text-align:center">
<div style="margin:0 auto">
   A enviar a mensagem de correio eletr�nico ...
</div>
<%  

assunto=Request("assunto")
remetente=request("Email")					
destinatario=Request("destino")
mensagem=Request("comentario") & "<br>" & Request("mensagem") & "<br><br>Remetido por:" & "<b>" & ucase(remetente) & "</b>" 			
if SendMail(assunto, remetente, destinatario, mensagem) Then
     if request("flag")="true" then 					
	     response.write "<script>window.resizeTo(0,0);alert('Email enviado com sucesso.');window.close();</script>" 				
     else   		  
	     response.write "<script>window.resizeTo(0,0);window.close();opener.window.alert('Email enviado com sucesso.');opener.window.close();</script>" 				
	 end if
 else 
     if request("flag")="true" then					
	      response.write "Lamentamos, mas ocorreu um erro ao enviar o email."
     else   		  
         response.write "<script>window.resizeTo(0,0);window.close();opener.window.alert('Ocorreu um erro! Lamentamos, mas o seu pedido n�o foi enviado.');opener.window.close();</script>" 
     end if 
end if
%>
</body>