@echo off
echo 正在构建网站...
npx quartz build
echo 正在推送到 GitHub...
git add .
git commit -m "更新笔记"
git push origin main
echo 完成！请等待 Cloudflare 自动部署。
pause