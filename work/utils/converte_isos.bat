@echo off
if "%3%"=="Porbase" goto PB
if "%3%"=="Horizon" goto HOZ
if "%3%"=="Docbase" goto DBS
if "%3%"=="Docbaseisis" goto DBA
if "%3%"=="Gib" goto GIB
if "%3%"=="Koha" goto KOH
if "%3%"=="mrc" goto MC
if "%4%"=="ansi"  goto NEXT
mx iso=%1 iso=%2 gizmo=gpbmrc now -all
goto FIM
:NEXT
mx iso=%1 iso=%2 gizmo=gpbmrc gizmo=gans850 now -all
goto FIM
:MC
if "%4%"=="ascii" goto MC1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc gizmo=gans850  now -all
goto FIM
:MC1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc now -all
goto FIM
:PB
if "%4%"=="ascii" goto PB1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:PB1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:HOZ
if "%4%"=="ascii" goto HOZ1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:HOZ1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:GIB
if "%4%"=="ascii" goto GIB1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:GIB1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:KOH
if "%4%"=="ascii" goto KOH1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:KOH1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:DBS
if "%4%"=="ascii" goto DBS1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:DBS1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:DBA
if "%4%"=="ansi" goto DBA1 
mx iso=%1  gizmo=gpbmrc  proc=@docb.prc iso=%2 -all now
goto FIM
:DBA1
mx iso=%1  gizmo=gpbmrc  gizmo=gans850 proc=@docb.prc iso=%2 -all now
:FIM