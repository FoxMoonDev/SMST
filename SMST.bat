@echo off
title SMST- v1.0
color 0a
setlocal enabledelayedexpansion

:ADMIN_CHECK
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo  [ERRO] Execute como Administrador!
    echo  Clique com botao direito > "Executar como administrador"
    echo  By FoxMoonDev
    echo.
    pause
    exit /b
)

:MENU_PRINCIPAL
cls
echo ================================================
echo      SUPER MENU DE SUPORTE TECNICO - v1.0
echo ================================================
echo 1.  Verificar e Reparar Disco (CHKDSK)
echo 2.  Reparar Arquivos de Sistema (SFC)
echo 3.  Limpar Arquivos Temporarios
echo 4.  Verificar Erros de Memoria (Diagnostico)
echo 5.  Restaurar Sistema
echo 6.  Testar Conectividade de Rede
echo 7.  Gerenciar Processos (Task Manager)
echo 8.  Backup de Drivers
echo 9.  Verificar Atualizacoes do Windows
echo 10. Informacoes do Sistema
echo 11. Limpar Cache DNS
echo 12. Reiniciar Servicos de Rede
echo 13. Desfragmentar Disco
echo 14. Gerenciar Usuarios Locais
echo 15. Verificar Integridade do Sistema (DISM)
echo 16. Gerenciar Firewall
echo 17. Visualizar Logs de Eventos
echo 18. Testar Velocidade de Disco
echo 19. Criar Ponto de Restauracao
echo 20. Executar Comando Personalizado
echo 21. Atualizar Programas (Winget)
echo 22. Verificar Espaco em Disco
echo 23. Analisar Processos Suspeitos
echo 24. Testar Velocidade da Internet
echo 25. Verificar IP Publico
echo 26. Reparar Windows Update
echo 27. Gerenciar Programas de Inicializacao
echo 28. Verificar Hardware (Diagnostico)
echo 29. Monitorar Rede em Tempo Real
echo 30. Sair
echo.
echo By FoxMoonDev
echo ================================================

set /p opcao="Escolha uma opcao [1-30]: "

if %opcao%==1 goto CHKDSK
if %opcao%==2 goto SFC
if %opcao%==3 goto TEMP
if %opcao%==4 goto MEMTEST
if %opcao%==5 goto RESTORE
if %opcao%==6 goto PINGTEST
if %opcao%==7 goto TASKMGR
if %opcao%==8 goto DRIVERBACKUP
if %opcao%==9 goto UPDATES
if %opcao%==10 goto SYSINFO
if %opcao%==11 goto DNS
if %opcao%==12 goto NETRESET
if %opcao%==13 goto DEFRAG
if %opcao%==14 goto USERMGMT
if %opcao%==15 goto DISM
if %opcao%==16 goto FIREWALL
if %opcao%==17 goto EVENTLOG
if %opcao%==18 goto DISKSPEED
if %opcao%==19 goto RESTOREPOINT
if %opcao%==20 goto CUSTOMCMD
if %opcao%==21 goto WINGET
if %opcao%==22 goto DISKSPACE
if %opcao%==23 goto PROCMON
if %opcao%==24 goto SPEEDTEST
if %opcao%==25 goto PUBLICIP
if %opcao%==26 goto WUREPAIR
if %opcao%==27 goto STARTUP
if %opcao%==28 goto HWDIAG
if %opcao%==29 goto NETMON
if %opcao%==30 goto SAIR

echo Opcao invalida! Pressione qualquer tecla para continuar...
pause >nul
goto MENU_PRINCIPAL

:CHKDSK
chkdsk /f /r
goto FIM

:SFC
sfc /scannow
goto FIM

:TEMP
del /f /s /q %temp%\*.*
rd /s /q %temp%
md %temp%
goto FIM

:MEMTEST
mdsched.exe
goto FIM

:RESTORE
rstrui.exe
goto FIM

:PINGTEST
set /p target="Digite o endereco para testar (ex: 8.8.8.8): "
ping -n 8 %target%
goto FIM

:TASKMGR
taskmgr
goto FIM

:DRIVERBACKUP
mkdir "C:\DriverBackup_%date:/=-%" >nul
dism /online /export-driver /destination:"C:\DriverBackup_%date:/=-%"
goto FIM

:UPDATES
wuauclt /detectnow
goto FIM

:SYSINFO
systeminfo
goto FIM

:DNS
ipconfig /flushdns
goto FIM

:NETRESET
netsh int ip reset
netsh winsock reset
ipconfig /flushdns
goto FIM

:DEFRAG
defrag /C /H /V
goto FIM

:USERMGMT
lusrmgr.msc
goto FIM

:DISM
DISM /Online /Cleanup-Image /RestoreHealth
goto FIM

:FIREWALL
wf.msc
goto FIM

:EVENTLOG
eventvwr.msc
goto FIM

:DISKSPEED
winsat disk -drive %systemdrive%
goto FIM

:RESTOREPOINT
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Ponto_Automatico_%date%", 100, 7
goto FIM

:CUSTOMCMD
set /p comando="Digite o comando a ser executado: "
%comando%
goto FIM

:WINGET
winget upgrade --all
goto FIM

:DISKSPACE
wmic logicaldisk get size,freespace,caption
goto FIM

:PROCMON
netstat -ano | findstr /i "estab"
tasklist | findstr /i "tor"
goto FIM

:SPEEDTEST
curl -o speedtest.exe https://install.speedtest.net/app/cli/ookla-speedtest-1.2.0-win64.zip
speedtest.exe
goto FIM

:PUBLICIP
curl https://api.ipify.org
goto FIM

:WUREPAIR
net stop wuauserv
net stop cryptSvc
net stop bits
net stop msiserver
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
net start wuauserv
net start cryptSvc
net start bits
net start msiserver
goto FIM

:STARTUP
taskmgr /0 /startup
goto FIM

:HWDIAG
perfmon /report
goto FIM

:NETMON
perfmon /res
goto FIM

:SAIR
exit

:FIM
echo.
echo =====================================================
echo Operacao concluida! Pressione qualquer tecla...
echo Desenvolvido por FOXMOONDEV - github.com/foxmoondev
echo =====================================================
pause >nul
goto MENU_PRINCIPAL
