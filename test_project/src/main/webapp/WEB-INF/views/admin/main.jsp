<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/main.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
</head>
<body>
 
    <div class="wrapper">
        <div class="wrap">
            <!-- gnv_area -->    
            <c:import url="adminHeader.jsp"/>
            <!-- top_subject_area -->
            <!-- contents-area -->
             <c:import url="adminNav.jsp" />
            <div class="admin_wrap">
                <!-- 네비영역 -->
                <div class="admin_content_wrap">
                    <div>관리자 페이지 입니다.</div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
 
</body>
</html>