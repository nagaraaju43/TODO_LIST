<!-- ViewTasks.jsp -->
<%@page import="beans.Task"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Display Tasks</title>
<!-- Add Font Awesome for icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    margin: 0;
    padding: 0;
  }
  .welcome-message {
    text-align: right;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    font-size: 18px;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 10px; /* Space between icon and text */
  }
  .welcome-message a {
    color: white;
    text-decoration: none;
    margin-left: 10px;
  }
  .welcome-message a:hover {
    text-decoration: underline;
  }
  .profile-icon {
    font-size: 24px;
    color: white;
  }
  .task-form {
    margin: 20px auto;
    width: 50%;
    background-color: white;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    animation: slideIn 0.5s ease-in-out;
  }
  .task-form table {
    width: 100%;
  }
  .task-form input[type="text"], .task-form input[type="date"], .task-form select {
    width: 100%;
    padding: 8px;
    margin: 5px 0;
    border: 1px solid #ccc;
    border-radius: 4px;
  }
  .task-form input[type="submit"], .task-form input[type="reset"] {
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  .task-form input[type="submit"] {
    background-color: #4CAF50;
    color: white;
  }
  .task-form input[type="reset"] {
    background-color: #f44336;
    color: white;
  }
  .task-form input[type="submit"]:hover, .task-form input[type="reset"]:hover {
    opacity: 0.8;
  }
  .task-table {
    margin: 20px auto;
    width: 70%;
    background-color: white;
    border-collapse: collapse;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    animation: fadeIn 1s ease-in-out;
  }
  .task-table th, .task-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ddd;
  }
  .task-table th {
    background-color: #4CAF50;
    color: white;
  }
  .task-table tr:hover {
    background-color: #f1f1f1;
  }
  .task-table a {
    color: #4CAF50;
    text-decoration: none;
  }
  .task-table a:hover {
    text-decoration: underline;
  }
  .completed-task {
    text-decoration: line-through;
    color: #888;
  }
  @keyframes slideIn {
    from {
      transform: translateY(-20px);
      opacity: 0;
    }
    to {
      transform: translateY(0);
      opacity: 1;
    }
  }
  @keyframes fadeIn {
    from {
      opacity: 0;
    }
    to {
      opacity: 1;
    }
  }
</style>
</head>
<body>
  <div class="welcome-message">
    <i class="fas fa-user-circle profile-icon"></i> <!-- Profile icon -->
    <%
      Object obj=session.getAttribute("regId");
      Integer in=(Integer)obj;
      int regId=in.intValue();
      
      dao.ToDoDAO dao1=dao.ToDoDAOImpl.getInstance();
      String flname=dao1.getFLNameByRegID(regId);
    %>
    Welcome <%=flname%>, <a href="./LogoutServlet">Logout</a>  
  </div>
  
  <div class="task-form">
    <form method="post" action="./AddTaskServlet">
      <table>
        <tr>
          <th>Task Name</th>
          <td><input type="text" name="taskName" required></td>
        </tr>
        <tr>
          <th>Task Date</th>
          <td><input type="date" name="taskDate" required></td>
        </tr>
        <tr>
          <th>Task Status</th>
          <td>
            <select name="taskStatus" size="1" required>
              <option value="1">Not Yet Started</option>
              <option value="2">In Progress</option>
              <option value="3">Completed</option>
            </select>
          </td>
        </tr>
        <tr>
          <th><input type="submit" name="submit" value="Add Task"></th>
          <td><input type="reset" name="reset" value="Clear"></td>
        </tr>
      </table>
    </form>
  </div>
  
  <hr/>
  
  <%
    List<Task> tasks=dao1.findTasksByRegId(regId);
  %>
  <table class="task-table">
    <tr>
      <th>Task ID</th>
      <th>Task Name</th>
      <th>Task Date</th>
      <th>Task Status</th>
      <th>Action</th>
    </tr>
    <%
      for(Task task:tasks) {
        int taskId=task.getTaskid();
        String taskName=task.getTaskname();
        String taskDate=task.getTaskdate();
        int taskStatus=task.getTaskstatus();
    %>
        <tr class="<%= taskStatus == 3 ? "completed-task" : "" %>">
          <td><%=taskId%></td>
          <td><%=taskName%></td>
          <td><%=taskDate%></td>
          <td><%=taskStatus == 1 ? "Not Yet Started" : taskStatus == 2 ? "In Progress" : "Completed"%></td>
          <td>
            <% if(taskStatus != 3) { %>
              <a href="./MarkTaskCompletedServlet?regId=<%=regId%>&taskId=<%=taskId%>">Complete</a>
            <% } else { %>
              Completed
            <% } %>
          </td>
        </tr>
    <%
      }
    %>
  </table>
</body>
</html>