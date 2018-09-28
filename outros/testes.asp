<%
for each thing in request.servervariables
   tempvalue=request.servervariables(thing)
   response.write thing & "=" & tempvalue & "<br>"
next
%>