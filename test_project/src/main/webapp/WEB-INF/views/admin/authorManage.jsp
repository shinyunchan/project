<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/authorManage.css">
 
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
</head>
<body>
 
    <div class="wrapper">
        <div class="wrap">
         	<c:import url="adminHeader.jsp"/>
            <!-- top_subject_area -->
            <!-- contents-area -->
            <div class="admin_wrap">
                <!-- 네비영역 -->
                <c:import url="adminNav.jsp"/>
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 목록</span></div>
                    <div class="author_table_wrap">
                    	<table class="author_table">
                    		<thead>
                    			<tr>
                    				<td class="th_column_1">상품 번호</td>
                    				<td class="th_column_2">상품 이름</td>
                    				<td class="th_column_3">등록 날짜</td>
                    			</tr>
                    		</thead>
                    		<c:forEach items="${list}" var="list">
                    		<tr>
                    			<td><a href="${contextPath }/admin/goodsDetail?productId=${list.productId}">${list.productId}</a></td>
                    			<td><c:out value="${list.productName}"></c:out></td>
                    			<td><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd"/></td>
                    		</tr>
                    		</c:forEach>
                    	</table>                			
                    </div>   
                </div>
                <div class="pageMaker_wrap" >
                    
	                    <ul class="pageMaker">
	                    
	                    	<!-- 이전 버튼 -->
	                    	<c:if test="${pageMaker.prev}">
	                    		<li class="pageMaker_btn prev">
	                    			<a href="${pageMaker.pageStart - 1}">이전</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    	<!-- 페이지 번호 -->
	                    	<c:forEach begin="${pageMaker.pageStart}" end="${pageMaker.pageEnd}" var="num">
	                    		<li class="pageMaker_btn ${pageMaker.cri.pageNum == num ? " active":""}">
	                    			<a href="${num}">${num}</a>
	                    		</li>
	                    	</c:forEach>
	                    	
	                    	<!-- 다음 버튼 -->
	                    	<c:if test="${pageMaker.next}">
	                    		<li class="pageMaker_btn next">
	                    			<a href="${pageMaker.pageEnd + 1 }">다음</a>
	                    		</li>
	                    	</c:if>
	                    	
	                    </ul>
	                    
                    </div>   
                    <form id="moveForm" action="/admin/authorManage" method="get">
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
						<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
						<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
					</form> 
                </div>
                <div class="clearfix"></div>
            </div>
        
        <!-- Footer 영역 -->

<script>
let moveForm = $('#moveForm');

/* 페이지 이동 버튼 */
$(".pageMaker_btn a").on("click", function(e){
    
    e.preventDefault();
    
    moveForm.find("input[name='pageNum']").val($(this).attr("href"));
    
    moveForm.submit();
});

let delete_result = '${delete_result}';

if(delete_result == 1){
	alert("삭제 완료");
}
</script>
</body>
</html>
