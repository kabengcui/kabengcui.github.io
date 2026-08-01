@echo off
chcp 65001 >nul
echo ========================================
echo   Quartz 网站部署脚本
echo ========================================
echo.

echo [1/5] 正在构建网站...
npx quartz build
if %errorlevel% neq 0 (
    echo ❌ 构建失败，错误代码：%errorlevel%
    pause
    exit /b %errorlevel%
)
echo ✅ 构建完成！
echo.

echo [2/5] 正在添加所有修改到 Git...
git add .
if %errorlevel% neq 0 (
    echo ❌ Git add 失败，错误代码：%errorlevel%
    pause
    exit /b %errorlevel%
)
echo ✅ 添加完成！
echo.

echo [3/5] 正在提交修改...
git commit -m "更新笔记 - %date% %time%"
if %errorlevel% neq 0 (
    echo ⚠️ 没有需要提交的修改，或提交失败
    echo 继续尝试推送...
)
echo.

echo [4/5] 正在推送到 GitHub（main 分支）...
git push origin main
if %errorlevel% neq 0 (
    echo ❌ 推送失败！错误代码：%errorlevel%
    echo.
    echo 可能原因：
    echo   - 网络连接问题
    echo   - 没有权限
    echo   - 远程仓库有新的提交，需要先 pull
    echo.
    echo 请尝试：
    echo   1. 检查网络
    echo   2. 用 GitHub Desktop 推送
    echo   3. 或手动执行 git push
    pause
    exit /b %errorlevel%
)
echo ✅ 推送成功！
echo.

echo [5/5] 完成！
echo ========================================
echo   ✅ 网站已更新！
echo.
echo   请前往 Cloudflare Pages 手动触发重试部署：
echo   https://dash.cloudflare.com/
echo.
echo   或等待自动部署（约 1-2 分钟）
echo ========================================
pause