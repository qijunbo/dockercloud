
<span id="自动化部署Shell脚本" />  
自动化部署Shell脚本
===


<span id="文件清单auto" />  
文件清单:
----

<table width="100%">
<tr><th>File Name</th><th>Description</th><th>备注</th> </tr>
<tr><td>auto/createcontainer.sh</td><td>创建LIMS产品容器和数据库容器. 传入参数 userid </td><td> </td></tr>
<tr><td>auto/getmysqlport.sh</td><td>获取指定用户数据库容器占用的端口. 传入参数 userid</td><td> </td></tr>
<tr><td>auto/getport.sh</td><td>获取指定用户LIMS容器占用的端口. 传入参数 userid</td><td> </td></tr>
<tr><td>auto/startmysql.sh</td><td>测试脚本,启动demo环境数据库</td><td> </td></tr>
</table>


<span id="操作提示auto" />  
操作提示:
----

这些脚本都是给前端Webapp调用的, 原则上不提倡手动执行这些脚本. 避免前端系统的记录和后端的行为不一致.

