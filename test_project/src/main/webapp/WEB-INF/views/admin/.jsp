<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsManage.css">
 
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
            <div class="admin_top_wrap">
                <span>관리자 페이지</span>
                
            </div>
            <!-- contents-area -->
            <div class="admin_wrap">
                <!-- 네비영역 -->
                <div class="admin_navi_wrap">
                  <ul>
                      <li >
                          <a class="admin_list_01" href="/admin/goodsEnroll">상품 등록</a>
                      </li>
                      <li>
                          <a class="admin_list_02" href="/admin/goodsManage">상품 관리</a>
                      </li>
                      <li>
                          <a class="admin_list_03" href="/admin/authorEnroll">작가 등록</a>                            
                      </li>
                      <li>
                          <a class="admin_list_04" href="/admin/authorManage">작가 관리</a>                            
                      </li>
                      <li>
                          <a class="admin_list_05">회원 관리</a>                            
                      </li>                                                                                             
                  </ul>
                </div>
                <div class="admin_content_wrap">
                     <div class="admin_content_subject"><span>상품 수정</span></div>
                      <div class="admin_content_main">
                    	<form action="${contextPath }/admin/modify" enctype="multipart/form-data" method="post">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품명</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productName">
                    				<span class="ck_warn productName_warn">상품명을 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 아이디</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productId">
                    				<span class="ck_warn productId_warn">상품 아이디를 입력해주세요</span>
                    			</div>   
                    		</div>	
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productPrice" value="0">
                    				<span class="ck_warn productPrice_warn">상품 가격을 입력해주세요.</span>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productStock" value="0">
                    				<span class="ck_warn productStock_warn">상품 재고를 입력해주세요.</span>
                    			</div>
                    		</div>           		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 소개</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productIntro">
                    				<span class="ck_warn productIntro_warn">상품 소개를 입력해주세요.</span>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 목차</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productContents">
                    				<span class="ck_warn productContents_warn">상품 내용을 입력해주세요.</span>
                    			</div>
                    		</div>
                   			<div class="btn_section">
                   				<input id="cancelBtn" class="btn" type="submit" value="수정">
	                    	</div> 
                   		</form>
                    </div>  
                </div>
                <div class="clearfix"></div>
            </div>
        
        <!-- Footer 영역 -->
<c:import url="../default/footer.jsp"/>


</body>
</html>