## 设置全局用户名和email，作为每次提交的记录  
git config --global user.name “name"  
git config --global user.email “mail.com”  
  
## 添加一个仓库  
git remote add origin git@….git  
git push -u origin master  
  
## 当提示权限不够时，添加ssh公钥  
##在用户的.ssh目录下找id_rsa.pub等文件，没有的话去生成  
ssh-keygen -t rsa -C "youremail@example.com”  
  
## 设置pull的默认地址  
git branch --set-upstream-to=origin/master  
## 设置push的默认地址  
git remote add origin git@….git  
  
## 配置别名  
git config --global alias.xx ''  
  
## 临时保存工作区  
git stash  
git stash pop  
  
## 回滚  
git reset —hard 版本号  
  
## 强行回滚远程服务器  
git push -f  
