
<span id="自动化部署Shell脚本" />  
自动化部署Shell脚本
===


<span id="文件清单auto" />  
文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>conf </td> <td>Mysql 默认配置文件</td> <td> </td></tr>
<tr><td>createcontainer.sh </td> <td> 为指定用户创建工作目录, 并启动mysql初始化过程.</td> <td> </td></tr>
<tr><td>getmysqlport.sh </td> <td>获取mysql占用端口, 可用于判断数据库是否初始化成功.</td> <td> </td></tr>
<tr><td>getport.sh </td> <td>获取应用的端口.</td> <td> </td></tr>
<tr><td>initsql </td> <td>mysql数据库初始化脚本.</td> <td> </td></tr>
<tr><td>README.md </td> <td>本文档.</td> <td> </td></tr>
<tr><td>reloadnginx.sh </td> <td> 重启nginx服务. </td> <td> </td></tr>
<tr><td>startlimsforuser.sh </td> <td>启动lims服务.</td> <td> </td></tr>
<tr><td>startmysql.sh </td> <td> </td> <td>调试用, 启动mysql. </td></tr>
<tr><td>tomcat </td> <td> </td>tomcat 配置文件.<td> </td></tr>
</table>


<span id="操作提示auto" />  
操作提示:
----

这些脚本都是给前端Webapp调用的, 原则上不提倡手动执行这些脚本. 避免前端系统的记录和后端的行为不一致.


查看日志
---
写操作都有日志.
```
tail -f   /var/log/messages
```