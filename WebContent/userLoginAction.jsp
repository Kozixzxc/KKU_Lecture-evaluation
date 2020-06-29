<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="user.UserDTO" %>
<%@ page import ="user.UserDAO" %>
<%@ page import ="util.SHA256" %>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userID = null;
	String userPassword = null;
	
	if(request.getParameter("userID") != null ){
		userID = (String) request.getParameter("userID");
	}
	if(request.getParameter("userPassword") != null ){
		userPassword = (String) request.getParameter("userPassword");
	}
	
	if(userID == null || userPassword == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력되지 않은 항목이 있습니다');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(userID, userPassword);
	// 예외처리	
	if(result == 1){
		session.setAttribute("userID" , userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	} else if (result == 0){ // 사용자가 회원가입을 하자마자 이메일 인증이 가능하도록 href
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸습니다')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		}
	else if (result == -1){ // 사용자가 회원가입을 하자마자 이메일 인증이 가능하도록 href
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		}
	else if (result == -2){ // 사용자가 회원가입을 하자마자 이메일 인증이 가능하도록 href
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생하였습니다. 관리자에게 연락 주세요')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
		}
%>