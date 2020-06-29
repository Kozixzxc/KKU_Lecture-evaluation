<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import ="javax.mail.Transport" %>
<%@ page import ="javax.mail.Message" %>
<%@ page import ="javax.mail.Address" %>
<%@ page import ="javax.mail.internet.InternetAddress" %>
<%@ page import ="javax.mail.internet.MimeMessage" %>
<%@ page import ="javax.mail.Session" %>
<%@ page import ="javax.mail.Authenticator" %>
<%@ page import ="java.util.Properties" %>
<%@ page import ="user.UserDAO" %>
<%@ page import ="util.SHA256" %>
<%@ page import="util.Gmail" %>
<%@ page import="java.io.PrintWriter"%>

<%
	UserDAO userDAO = new UserDAO();
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요합니다');");
		script.println("location.href='userLogin.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
	
	boolean emailChecked = userDAO.getUserEmailChecked(userID);
	if(emailChecked==true){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 인증된 회원입니다');");
		script.println("location.href='index.jsp'");
		script.println("</script>");
		script.close();
		return;
	}
	
	String host = "http://localhost:8091/KKU_Lecture_Evaluation/";
	String from = "kozixzxc@gmail.com";
	String to = userDAO.getUserEmail(userID);
	String subject = "강의평가 사이트 이메일 인증 메일입니다";
	String content = "다음 링크에 접속하여 이메일 인증을 진행하세요" + "<a href='" + host + "emailCheckAction.jsp?code=" + new SHA256().getSHA256(to) +"'> 이메일 인증하기 </a>";

	Properties p = new Properties();
	p.put("mail.smtp.user" , from);
	p.put("mail.smtp.host" , "smtp.googlemail.com");
	p.put("mail.smtp.port" , "465");
	p.put("mail.smtp.starttls.enable" , "true");
	p.put("mail.smtp.auth" , "true");
	p.put("mail.smtp.debug" , "true");
	p.put("mail.smtp.socketFactory.port" , "465");
	p.put("mail.smtp.socketFactory.class" , "javax.net.ssl.SSLSocketFactory");
	p.put("mail.smtp.socketFactory.fallback" , "false");
	
	try{
		Authenticator auth = new Gmail();
		Session ses = Session.getInstance(p,auth);
		ses.setDebug(true);
		MimeMessage msg = new MimeMessage(ses);
		msg.setSubject(subject);
		Address fromAddr = new InternetAddress(from);
		msg.setFrom(fromAddr);
		Address toAddr = new InternetAddress(to);
		msg.addRecipient(Message.RecipientType.TO, toAddr);
		msg.setContent(content, "text/html;charset=UTF8");
		Transport.send(msg);
	} catch(Exception e){
		e.printStackTrace();
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('error');");
		script.println("history.back();");
		script.println("</script>");
		script.close();
		return;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
  <html>
  <head>

    <title>강의평가 웹 사이트</title>

    <meta charset="utf-8">

    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- 부트스트랩 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <link rel="stylesheet" href="./css/bootstrap.css">
    <link rel="stylesheet" href="./css/bootstrap-theme.css">

    <!-- 커스텀 CSS 추가하기 -->

    <link rel="stylesheet" href="./css/custom.css">

  </head>

  <body>

  <nav class="navbar navbar-expand-lg navbar-light bg-light">

      <a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>

      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">

        <span class="navbar-toggler-icon"></span>

      </button>

      <div class="collapse navbar-collapse" id="navbar">

        <ul class="navbar-nav mr-auto">

          <li class="nav-item">

            <a class="nav-link" href="index.jsp">메인</a>

          </li>

          <li class="nav-item dropdown">

            <a class="nav-link dropdown-toggle" id="dropdown" data-toggle="dropdown">

              회원 관리

            </a>

            <div class="dropdown-menu" aria-labelledby="dropdown">

              <a class="dropdown-item" href="userLogin.jsp">로그인</a>

              <a class="dropdown-item active" href="userJoin.jsp">회원가입</a>

              <a class="dropdown-item" href="userLogout.jsp">로그아웃</a>

            </div>

          </li>

        </ul>

		<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">

          <input type="text" name="search" class="form-control mr-sm-2"  placeholder="내용을 입력하세요." aria-label="Search">

          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>

        </form>

      </div>

    </nav>
    
   <section class="container mt-3" style="max-width: 560px;">
   
   	<div class="alert alert-success mt-4" role="alert">
   		이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일에 들어가서 인증해주세요
   	</div>
  
   </section>
   
    <footer class="bg-dark mt-4 p-5 text-center" style="color: #FFFFFF;">

      Copyright ⓒ 2020 범장어 All Rights Reserved.

    </footer>
    
    
    </section>

    <!-- 제이쿼리 자바스크립트 추가하기 -->

    <script src="./js/jquery.min.js"></script>

    <!-- Popper 자바스크립트 추가하기 -->

    <script src="./js/popper.js"></script>

    <!-- 부트스트랩 자바스크립트 추가하기 -->

    <script src="./js/bootstrap.min.js"></script>

  </body>

</html>

