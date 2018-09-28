<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
	   Dim objXmlHttp
       Dim strHTML
       response.charset="iso-8859-1"
       expr=request("expressao")
	   base=request("base")
	   letra=request("letra")
	   tab=request("tab")
	   formato="index_cat"
       surl= strROOT & "/cgi/www.exe/[in=index_cat.in]?expressao="&expr&"&base="&base&"&formato0="&formato&"&letra="&letra&"&tab="&tab&"&limites=25&d="&Clng(now)
	   
	Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
	
    objXmlHttp.open "GET", surl, False
	objXmlHttp.send
	
	On Error Resume Next  

	'Wait for up to 15 seconds to receive the data.   
	If objXmlHttp.ReadyState <> 4 Then  
	  objXmlHttp.WaitForResponse 15   
	End If  
	  
	If (objXmlHttp.ReadyState <> 4) Or (objXmlHttp.Status <> 200) Then  
	  'Abort the request.   
	  objXmlHttp.Abort   
	  strHTML = "<p class=""aviso"">Servidor Indisponível.<br>Não é possível continuar...</p>"
	  response.write strHTML
	  response.end   
	End if		


	strHTML = objXmlHttp.responseBody
	strHTML= BinaryToString(strHTML)
      
       response.write strHTML 
	set objXmlHttp = nothing


Function BinaryToString(xBinary)

Dim Binary
Dim RS, LBinary

If VarType(xBinary)=8 Then Binary = MultiByteToBinary(xBinary) Else Binary = xBinary
Const adLongVarChar = 201
Set RS = CreateObject("ADODB.Recordset")
LBinary = LenB(Binary)

If LBinary>0 Then
	RS.Fields.Append "mBinary", adLongVarChar, LBinary
	RS.Open
	RS.AddNew
	RS("mBinary").AppendChunk Binary 
	RS.Update
	BinaryToString = RS("mBinary")
Else
	BinaryToString = ""
End If

Set RS=Nothing

End Function
%>