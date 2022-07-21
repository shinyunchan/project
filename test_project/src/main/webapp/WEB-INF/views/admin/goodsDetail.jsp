<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsDetail.css">
 
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
            <div class="admin_wrap">
                <!-- 네비영역 -->
                <c:import url="adminNav.jsp"/>
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 관리</span></div>
                    <table class="author_table">
                    		<thead>
                    			<tr>
                    				<td class="th_column_1">상품 이미지</td>
	                    			<td>
	                    				<div id="uploadReslut"></div>
	                    			</td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_1">상품 번호</td>
	                    			<td><c:out value="${data.productId}"></c:out></td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_2">상품 이름</td>
	                    			<td><c:out value="${data.productName}"></c:out></td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_3">상품 가격</td>
	                    			<td><c:out value="${data.productPrice}"></c:out> </td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_4">상품 재고</td>
	                    			<td><c:out value="${data.productStock}"></c:out> </td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_4">상품 소개</td>
	                    			<td><c:out value="${data.productIntro}"></c:out> </td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_5">상품 목차</td>
	                    			<td><c:out value="${data.productContents}"></c:out> </td>
                    			</tr>
                    			<tr>
                    				<td class="th_column_6">등록 날짜</td>
	                    			<td><fmt:formatDate value="${data.regDate}" pattern="yyyy-MM-dd"/></td>
                    			</tr>
	                    		<tr>
	                    			<td class="th_column_8">수정</td>
	                    			<td>
	                    				<div class="btn_section">
		                    				<form id="moveForm" action="/admin/authorManage.jsp" method="get" >
				                    			<button id="modifyBtn" class="btn-gradient">수정 </button>
				                    			<button id="deleteBtn" class="btn-gradient">삭제</button>
						                	</form>
				                    			
				                    			
	                    				</div> 
	                    			</td>
	                    		</tr>
                    		</thead>
                    	</table>                			
                </div>
                <div class="clearfix"></div>
            </div>
           </div>
          </div>
        
        <!-- Footer 영역 -->
<script>
let productId = '<c:out value="${data.productId}"/>';
let uploadReslut = $("#uploadReslut");			

$.getJSON("/getAttachList", {productId : productId}, function(arr){	
	if(arr.length === 0){			
		let str = "";
		str += "<div id='result_card'>";
		str += "<img src='/resources/img/logo.png'>";
		str += "</div>";
		
		uploadReslut.html(str);
	}	
	let str = "";
	let obj = arr[0];	
	
	let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
	str += "<div id='result_card'";
	str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
	str += ">";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "</div>";		
	
	uploadReslut.html(str);						
	
});	

$("#modifyBtn").on("click", function(e){
	e.preventDefault();
	let addInput = '<input type="hidden" name="productId" value="${data.productId}">';
	$("#moveForm").append(addInput);
	$("#moveForm").attr("action", "/admin/goodsModify");
	$("#moveForm").submit();
});	

$("#deleteBtn").on("click", function(e){
	e.preventDefault();
	let moveForm = $("#moveForm");
	moveForm.append('<input type="hidden" name="productId" value="${data.productId}">');
	moveForm.attr("action", "/admin/goodsDelete");
	moveForm.attr("method", "post");
	moveForm.submit();
});
</script>

</body>
</html>