<template:user_backend htmlTitle="在线用户" bodyTitle="在线用户列表">
    当前系统共有 ${numberOfSessions} 活动用户.<br /><br />
    <c:forEach items="${sessionList}" var="s">
        会话ID:${s.id} - 用户名:${s.getAttribute("username")}
        <c:if test="${s.id == pageContext.session.id}">&nbsp;(当前用户)</c:if><br/>
    </c:forEach>
</template:user_backend>

