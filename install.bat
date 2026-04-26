@echo off
REM Pointr 安装脚本
setlocal

echo ========================================
echo   Pointr 激光笔配置器 - 安装向导
echo ========================================
echo.
echo 此脚本将安装 Pointr 到您的电脑。
echo.

REM 检查管理员权限
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo 注意: 建议以管理员身份运行此脚本以获得最佳体验。
    echo.
)

REM 获取安装目录
set "INSTALL_DIR=%ProgramFiles%\Pointr"
set /p "INSTALL_DIR=请输入安装目录 [默认: %ProgramFiles%\Pointr]: "

if "%INSTALL_DIR%"=="" set "INSTALL_DIR=%ProgramFiles%\Pointr"

echo.
echo 安装目录: %INSTALL_DIR%
echo.

REM 创建安装目录
if not exist "%INSTALL_DIR%" (
    mkdir "%INSTALL_DIR%"
    if errorlevel 1 (
        echo 错误: 无法创建安装目录，请以管理员身份运行此脚本。
        pause
        exit /b 1
    )
)

REM 复制文件
echo 正在复制文件...
copy /Y "pointr.exe" "%INSTALL_DIR%\" >nul
if errorlevel 1 (
    echo 错误: 文件复制失败。
    pause
    exit /b 1
)

copy /Y "README.txt" "%INSTALL_DIR%\" >nul 2>&1

echo.
echo ========================================
echo   安装完成！
echo ========================================
echo.
echo Pointr 已成功安装到: %INSTALL_DIR%
echo.
echo 您现在可以:
echo   1. 双击 pointr.exe 启动应用
echo   2. 应用将在系统托盘中运行
echo   3. 右键点击托盘图标可打开主窗口或退出
echo.

pause
