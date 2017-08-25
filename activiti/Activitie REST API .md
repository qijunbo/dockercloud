
Activiti REST API 微服务设计方案(草案)
===


第一部分: 
现有系统难以拆分原因分析.
----

这几天我已经尝试了把工作流独立出来, 发现非常困难, 根本原因是由于**循环依赖**造成的.

正常情况下,  __模块__和__模块__之间的依赖是单向的,  顶层依赖于基层的, 基层的不必要知道顶层在干什么.
这就像人事管理一样, 领导可以随时调用基层, 但是基层从来无权随意调用顶层; 否则就乱套了.
但是我们的系统就出现了比较混乱的调用关系.

 如下图是JDK的层级关系.

![JDK](.\jdk.png)


下图是我们的现有系统调用关系.

如下图所示,  iWork 是工作流所在的包,  它依赖了 iCore,  iFramework 和 MyBatis. 
反过来, 这种依赖关系也存在, 以至于我分不清谁是底层,谁是上层.
尤其奇怪的是 iFramework里面的Util 居然还依赖了表示层JSP和Servlet的东西(看起来它很顶层), 但是它同时又被基层的包调用(说明它很底层).  这样错综复杂的依赖关系,导致我在把iWork包独立出来的时候, 要把iCore, iFramwork里很多东西也剥离出来, 这会带来引入大量bug的风险, 而且还费时.
以上分析,  我们重用现在的代码,  把包分出来的工作量肯定不会小,  而且要想切断其中不合理的依赖关系,必然导致一部分代码的重写.
重写完了,还要和其他系统联调来判断可靠性. 这是弊端之一.
![iframwork](.\depend.png)


 方案构想:
----
 如下是新的 activiti 微服务 rest api 的逻辑架构图.

 1. 中间黑色方框中的是微服务的边界.  它一共提供了4大类接口. 分别是**流程定义类**(Deployment, ProcessDef, Forms),  ** 控制类** (Process Instance, Executions, Tasks), ** 历史类** , **用户和组管理 **

 2.  绿色的框**流程设计器** 不是以REST API的形式提供服务的, 它保持现有的设计模式不变. 

 3.  虚线框 ** 流程定义类** 的接口不是必须的. 按照现在mdm, lims的开发习惯, 是直接调用流程设计器图形界面, 设计好后,保存到数据库即可,  所以** 流程定义类** 的接口不一定用得上.

 4.  关于数据库是共用还是独立, 可以灵活处理.  如果mdm, ec, LIMS 公用一个**工作流微服务**,  那么数据库可以独立出来, 用户和组的创建通过REST API进行, 可以避免三个客户系统相互干扰.   如果mdm, ec, LIMS 各自使用自己的的**工作流微服务**,  那么数据库就不必分开了, 单一数据库即可.

 ![activiti](.\activiti.png)

 
现有系统值得借鉴的部分:
---
1. 基于事件触发邮件发送功能.

2. Task 的定制化 ( 批准, 驳回, 暂停, 继续, 其它等等)


我们在做微服务设计的时候,要把以上功能考虑进去

General Activiti REST principles 
--- 

如下是是摘录维基百科的RESTful API的命名规范, 在定义API,取名字的时候要尽可能的遵守规范.

<table class="wikitable">
<caption>HTTP methods</caption>
<tbody><tr>
<th>Uniform Resource Locator (URL)</th>
<th>GET</th>
<th>PUT</th>
<th>PATCH</th>
<th>POST</th>
<th>DELETE</th>
</tr>
<tr>
<th>Collection, such as <code>https://api.example.com/resources/</code></th>
<td><b>List</b> the URIs and perhaps other details of the collection's members.</td>
<td><b>Replace</b> the entire collection with another collection.</td>
<td>Not generally used</td>
<td><b>Create</b> a new entry in the collection. The new entry's URI is assigned automatically and is usually returned by the operation.<sup id="cite_ref-thereisnorightway_17-0" class="reference"><a href="#cite_note-thereisnorightway-17">[17]</a></sup></td>
<td><b>Delete</b> the entire collection.</td>
</tr>
<tr>
<th>Element, such as <code>https://api.example.com/resources/item17</code></th>
<td><b>Retrieve</b> a representation of the addressed member of the collection, expressed in an appropriate Internet media type.</td>
<td><b>Replace</b> the addressed member of the collection, or if it does not exist, <b>create</b> it.</td>
<td><b>Update</b> the addressed member of the collection.</td>
<td>Not generally used. Treat the addressed member as a collection in its own right and <b>create</b> a new entry within it.<sup id="cite_ref-thereisnorightway_17-1" class="reference"><a href="#cite_note-thereisnorightway-17">[17]</a></sup></td>
<td><b>Delete</b> the addressed member of the collection.</td>
</tr>
</tbody></table>

接口功能定义
===

#流程定义类
===
Deployment 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 2.1. </td><td>List of Deployments</td><td>Deployments列表 </td> </tr>
<tr><td> 2.2. </td><td>Get a deployment</td><td>获取Deployment </td> </tr>
<tr><td> 2.3. </td><td>Create a new deployment</td><td>创建新的Deployment </td> </tr>
<tr><td> 2.4. </td><td>Delete a deployment</td><td>删除Deployment </td> </tr>
<tr><td> 2.5. </td><td>List resources in a deployment</td><td>列出Deployment中的资源 </td> </tr>
<tr><td> 2.6. </td><td>Get a deployment resource</td><td>获取Deployment资源 </td> </tr>
<tr><td> 2.7. </td><td>Get a deployment resource content</td><td>获取Deployment资源内容 </td> </tr>
</table>

Process Definitions 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 3.1. </td><td>List of process definitions</td><td>流程定义列表 </td> </tr>
<tr><td> 3.2. </td><td>Get a process definition</td><td>获取流程定义 </td> </tr>
<tr><td> 3.3. </td><td>Update category for a process definition</td><td>流程定义的更新类别 </td> </tr>
<tr><td> 3.4. </td><td>Get a process definition resource content</td><td>获取进程定义资源内容 </td> </tr>
<tr><td> 3.5. </td><td>Get a process definition BPMN model</td><td>获取进程定义 BPMN 模型 </td> </tr>
<tr><td> 3.6. </td><td>Suspend a process definition</td><td>暂停进程定义 </td> </tr>
<tr><td> 3.7. </td><td>Activate a process definition</td><td>激活流程定义 </td> </tr>
<tr><td> 3.8. </td><td>Get all candidate starters for a process-definition</td><td>获得所有候选者的过程 </td> </tr>
<tr><td> 3.9. </td><td>Add a candidate starter to a process definition</td><td>在流程定义中添加候选启动器 </td> </tr>
<tr><td> 3.10. </td><td>Delete a candidate starter from a process definition</td><td>从进程定义中删除候选启动器 </td> </tr>
<tr><td> 3.11. </td><td>Get a candidate starter from a process definition</td><td>从流程定义中获取候选起始项 </td> </tr>
</table>
 

Forms 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 9.1. </td><td>Get form data</td><td>获取表单数据 </td> </tr>
<tr><td> 9.2. </td><td>Submit task form data</td><td>提交任务表单数据 </td> </tr>
</table>

#流程控制类
==
Process Instances 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 5.1. </td><td>Get a process instance</td><td>获取流程实例 </td> </tr>
<tr><td> 5.2. </td><td>Delete a process instance</td><td>删除流程实例 </td> </tr>
<tr><td> 5.3. </td><td>Activate or suspend a process instance</td><td>激活或挂起流程实例 </td> </tr>
<tr><td> 5.4. </td><td>Start a process instance</td><td>启动流程实例 </td> </tr>
<tr><td> 5.5. </td><td>List of process instances</td><td>流程实例列表 </td> </tr>
<tr><td> 5.6. </td><td>Query process instances</td><td>查询流程实例 </td> </tr>
<tr><td> 5.7. </td><td>Get diagram for a process instance</td><td>获取流程实例的关系图 </td> </tr>
<tr><td> 5.8. </td><td>Get involved people for process instance</td><td>参与流程实例的人员 </td> </tr>
<tr><td> 5.9. </td><td>Add an involved user to a process instance</td><td>将涉及的用户添加到流程实例 </td> </tr>
<tr><td> 5.10. </td><td>Remove an involved user to from process instance</td><td>将涉及的用户从流程实例中删除 </td> </tr>
<tr><td> 5.11. </td><td>List of variables for a process instance</td><td>流程实例的变量列表 </td> </tr>
<tr><td> 5.12. </td><td>Get a variable for a process instance</td><td>获取流程实例的变量 </td> </tr>
<tr><td> 5.13. </td><td>Create (or update) variables on a process instance</td><td>创建 </td> </tr>
<tr><td> 5.14. </td><td>Update a single variable on a process instance</td><td>更新流程实例上的单个变量 </td> </tr>
<tr><td> 5.15. </td><td>Create a new binary variable on a process-instance</td><td>在进程上创建新的二进制变量 </td> </tr>
<tr><td> 5.16. </td><td>Update an existing binary variable on a process-instance</td><td>更新进程中的现有二进制变量 </td> </tr>
</table>

Executions 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 6.1. </td><td>Get an execution</td><td>获得Execution </td> </tr>
<tr><td> 6.2. </td><td>Execute an action on an execution</td><td>在Execution上执行操作 </td> </tr>
<tr><td> 6.3. </td><td>Get active activities in an execution</td><td>在执行过程中获取活动 </td> </tr>
<tr><td> 6.4. </td><td>List of executions</td><td>Execution列表 </td> </tr>
<tr><td> 6.5. </td><td>Query executions</td><td>查询执行 </td> </tr>
<tr><td> 6.6. </td><td>List of variables for an execution</td><td>执行变量列表 </td> </tr>
<tr><td> 6.7. </td><td>Get a variable for an execution</td><td>获取用于执行的变量 </td> </tr>
<tr><td> 6.8. </td><td>Create (or update) variables on an execution</td><td>创建 </td> </tr>
<tr><td> 6.9. </td><td>Update a variable on an execution</td><td>更新Execution中的变量 </td> </tr>
<tr><td> 6.10. </td><td>Create a new binary variable on an execution</td><td>在Execution中创建新的二进制变量 </td> </tr>
<tr><td> 6.11. </td><td>Update an existing binary variable on a process-instance</td><td>更新Process-instance中的现有二进制变量 </td> </tr>
</table>

Tasks 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 7.1. </td><td>Get a task</td><td>获取任务 </td> </tr>
<tr><td> 7.2. </td><td>List of tasks</td><td>任务清单 </td> </tr>
<tr><td> 7.3. </td><td>Query for tasks</td><td>查询任务 </td> </tr>
<tr><td> 7.4. </td><td>Update a task</td><td>更新任务 </td> </tr>
<tr><td> 7.5. </td><td>Task actions</td><td>任务行动 </td> </tr>
<tr><td> 7.6. </td><td>Delete a task</td><td>删除任务 </td> </tr>
<tr><td> 7.7. </td><td>Get all variables for a task</td><td>获取任务的所有变量 </td> </tr>
<tr><td> 7.8. </td><td>Get a variable from a task</td><td>从任务中获取变量 </td> </tr>
<tr><td> 7.9. </td><td>Get the binary data for a variable</td><td>获取变量的二进制数据 </td> </tr>
<tr><td> 7.10. </td><td>Create new variables on a task</td><td>在任务上创建新变量 </td> </tr>
<tr><td> 7.11. </td><td>Create a new binary variable on a task</td><td>在任务上创建新的二进制变量 </td> </tr>
<tr><td> 7.12. </td><td>Update an existing variable on a task</td><td>更新任务的现有变量 </td> </tr>
<tr><td> 7.13. </td><td>Updating a binary variable on a task</td><td>更新任务的二进制变量 </td> </tr>
<tr><td> 7.14. </td><td>Delete a variable on a task</td><td>删除任务上的变量 </td> </tr>
<tr><td> 7.15. </td><td>Delete all local variables on a task</td><td>删除任务中的所有局部变量 </td> </tr>
<tr><td> 7.16. </td><td>Get all identity links for a task</td><td>获取任务的所有标识链接 </td> </tr>
<tr><td> 7.17. </td><td>Get all identitylinks for a task for either groups or users</td><td>为组或用户获取任务的所有 identitylinks </td> </tr>
<tr><td> 7.18. </td><td>Get a single identity link on a task</td><td>在任务上获取单个标识链接 </td> </tr>
<tr><td> 7.19. </td><td>Create an identity link on a task</td><td>在任务上创建标识链接 </td> </tr>
<tr><td> 7.20. </td><td>Delete an identity link on a task</td><td>删除任务上的标识链接 </td> </tr>
<tr><td> 7.21. </td><td>Create a new comment on a task</td><td>创建新的任务注释 </td> </tr>
<tr><td> 7.22. </td><td>Get all comments on a task</td><td>获取任务的所有注释 </td> </tr>
<tr><td> 7.23. </td><td>Get a comment on a task</td><td>获取任务的注释 </td> </tr>
<tr><td> 7.24. </td><td>Delete a comment on a task</td><td>删除任务的注释 </td> </tr>
<tr><td> 7.25. </td><td>Get all events for a task</td><td>获取任务的所有事件 </td> </tr>
<tr><td> 7.26. </td><td>Get an event on a task</td><td>在任务中获取事件 </td> </tr>
<tr><td> 7.27. </td><td>Create a new attachment on a task, containing a link to an external resource</td><td>在任务上创建新附件, 包含指向外部资源的链接 </td> </tr>
<tr><td> 7.28. </td><td>Create a new attachment on a task, with an attached file</td><td>使用附加文件在任务上创建新附件 </td> </tr>
<tr><td> 7.29. </td><td>Get all attachments on a task</td><td>获取任务的所有附件 </td> </tr>
<tr><td> 7.30. </td><td>Get an attachment on a task</td><td>获取任务的附件 </td> </tr>
<tr><td> 7.31. </td><td>Get the content for an attachment</td><td>获取附件的内容 </td> </tr>
<tr><td> 7.32. </td><td>Delete an attachment on a task</td><td>删除任务的附件 </td> </tr>
</table>

#历史类
===
History 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 8.1. </td><td>Get a historic process instance</td><td>获取历史过程实例 </td> </tr>
<tr><td> 8.2. </td><td>List of historic process instances</td><td>历史进程实例列表 </td> </tr>
<tr><td> 8.3. </td><td>Query for historic process instances</td><td>查询历史进程实例 </td> </tr>
<tr><td> 8.4. </td><td>Delete a historic process instance</td><td>删除历史进程实例 </td> </tr>
<tr><td> 8.5. </td><td>Get the identity links of a historic process instance</td><td>获取历史进程实例的标识链接 </td> </tr>
<tr><td> 8.6. </td><td>Get the binary data for a historic process instance variable</td><td>获取历史进程实例变量的二进制数据 </td> </tr>
<tr><td> 8.7. </td><td>Create a new comment on a historic process instance</td><td>创建一个历史进程实例的新注释 </td> </tr>
<tr><td> 8.8. </td><td>Get all comments on a historic process instance</td><td>获取历史过程实例的所有注释 </td> </tr>
<tr><td> 8.9. </td><td>Get a comment on a historic process instance</td><td>获取一个历史过程实例的注释 </td> </tr>
<tr><td> 8.10. </td><td>Delete a comment on a historic process instance</td><td>删除历史进程实例的注释 </td> </tr>
<tr><td> 8.11. </td><td>Get a single historic task instance</td><td>获取单个历史任务实例 </td> </tr>
<tr><td> 8.12. </td><td>Get historic task instances</td><td>获取历史任务实例 </td> </tr>
<tr><td> 8.13. </td><td>Query for historic task instances</td><td>查询历史任务实例 </td> </tr>
<tr><td> 8.14. </td><td>Delete a historic task instance</td><td>删除历史任务实例 </td> </tr>
<tr><td> 8.15. </td><td>Get the identity links of a historic task instance</td><td>获取历史任务实例的标识链接 </td> </tr>
<tr><td> 8.16. </td><td>Get the binary data for a historic task instance variable</td><td>获取历史任务实例变量的二进制数据 </td> </tr>
<tr><td> 8.17. </td><td>Get historic activity instances</td><td>获取历史活动实例 </td> </tr>
<tr><td> 8.18. </td><td>Query for historic activity instances</td><td>查询历史活动实例 </td> </tr>
<tr><td> 8.19. </td><td>List of historic variable instances</td><td>历史变量实例列表 </td> </tr>
<tr><td> 8.20. </td><td>Query for historic variable instances</td><td>查询历史变量实例 </td> </tr>
<tr><td> 8.21. </td><td>Get historic detail</td><td>获取历史细节 </td> </tr>
<tr><td> 8.22. </td><td>Query for historic details</td><td>查询历史细节 </td> </tr>
<tr><td> 8.23. </td><td>Get the binary data for a historic detail variable</td><td>获取历史细节变量的二进制数据 </td> </tr>
</table>

 
#用户和组的管理
===
Users 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 14.1. </td><td>Get a single user</td><td>获取单个用户 </td> </tr>
<tr><td> 14.2. </td><td>Get a list of users</td><td>获取用户列表 </td> </tr>
<tr><td> 14.3. </td><td>Update a user</td><td>更新用户 </td> </tr>
<tr><td> 14.4. </td><td>Create a user</td><td>创建用户 </td> </tr>
<tr><td> 14.5. </td><td>Delete a user</td><td>删除用户 </td> </tr>
<tr><td> 14.6. </td><td>Get a user’s picture</td><td>获取用户的图片 </td> </tr>
<tr><td> 14.7. </td><td>Updating a user’s picture</td><td>更新用户图片 </td> </tr>
<tr><td> 14.8. </td><td>List a user’s info</td><td>列出用户信息 </td> </tr>
<tr><td> 14.9. </td><td>Get a user’s info</td><td>获取用户信息 </td> </tr>
<tr><td> 14.10. </td><td>Update a user’s info</td><td>更新用户信息 </td> </tr>
<tr><td> 14.11. </td><td>Create a new user’s info entry</td><td>创建新用户的信息条目 </td> </tr>
<tr><td> 14.12. </td><td>Delete a user’s info</td><td>删除用户信息 </td> </tr>
</table>

Groups 
--- 

<table width="100%">
<tr><th>序号</th><th>REST API  Item</th> <th> Function </th></tr>

<tr><td> 15.1. </td><td>Get a single group</td><td>获取单个组 </td> </tr>
<tr><td> 15.2. </td><td>Get a list of groups</td><td>获取组列表 </td> </tr>
<tr><td> 15.3. </td><td>Update a group</td><td>更新组 </td> </tr>
<tr><td> 15.4. </td><td>Create a group</td><td>创建组 </td> </tr>
<tr><td> 15.5. </td><td>Delete a group</td><td>删除组 </td> </tr>
<tr><td> 15.6. </td><td>Get members in a group</td><td>获取组中的成员 </td> </tr>
<tr><td> 15.7. </td><td>Add a member to a group</td><td>向组中添加成员 </td> </tr>
<tr><td> 15.8. </td><td>Delete a member from a group</td><td>从组中删除成员 </td> </tr>
</table>