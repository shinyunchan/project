<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/admin/goodsModify.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" />
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
 <script src="https://cdn.ckeditor.com/ckeditor5/26.0.0/classic/ckeditor.js"></script>
 <script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
<script src="//code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
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
                    <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 등록</span></div>
                    <div class="admin_content_main">
                    	<form action="/admin/goodsModify" method="post" id="modifyForm">
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>책 제목</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productName" value="${data.productName}">
                    				<span class="ck_warn bookName_warn">상품 이름을 입력해주세요.</span>
                    			</div>
                    		</div>
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 가격</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productPrice" value="${data.productPrice}">
                    				<span class="ck_warn bookPrice_warn">상품 가격을 입력해주세요.</span>
                    			</div>
                    		</div>               
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 재고</label>
                    			</div>
                    			<div class="form_section_content">
                    				<input name="productStock" value="${data.productStock}">
                    				<span class="ck_warn bookStock_warn">상품 재고를 입력해주세요.</span>
                    			</div>
                    		</div>          		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 소개</label>
                    			</div>
                    			<div class="form_section_content bit">
                    				<textarea name="productIntro" id="bookIntro_textarea">${data.productIntro}</textarea>
                    				<span class="ck_warn bookIntro_warn">상품 소개를 입력해주세요.</span>
                    			</div>
                    		</div>        		
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 목차</label>
                    			</div>
                    			<div class="form_section_content bct">
                    				<textarea name="productContents" id="bookContents_textarea">${data.productContents}</textarea>
                    				<span class="ck_warn bookContents_warn">상품 내용을 입력해주세요.</span>
                    			</div>
                    			<div class="form_section">
	                    			<div class="form_section_title">
	                    				<label>상품 이미지</label>
	                    			</div>
	                    			<div class="form_section_content">
										<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
										<div id="uploadResult"></div>									
                    				</div>
                    		</div>
                    		</div>
                    		<input type="hidden" name='productId' value="${data.productId}">
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">취 소</button>
	                    		<input type="submit" class="btn" value="수 정">
	                    	</div> 
                   		</form>
                    </div>  
                </div>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
            </div>
</body>
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
		return;
	}	
	let str = "";
	let obj = arr[0];	
	
	let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
	str += "<div id='result_card'";
	str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
	str += ">";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";
	str += "</div>";		
	
	uploadReslut.html(str);						
	
});

/* 이미지 업로드 */
$("input[type='file']").on("change", function(e){
	
	/* 이미지 존재시 삭제 */
	if($("#result_card").length > 0){
		deleteFile();
	}
			
	let formData = new FormData();
	let fileInput = $('input[name="uploadFile"]');
	let fileList = fileInput[0].files;
	let fileObj = fileList[0];
	
	if(!fileCheck(fileObj.name, fileObj.size)){
		return false;
	}
	
	formData.append("uploadFile", fileObj);
	
	$.ajax({
		url: '/admin/uploadAjaxAction',
    	processData : false,
    	contentType : false,
    	data : formData,
    	type : 'POST',
    	dataType : 'json',
    	success : function(result){
    		console.log(result);
    		showUploadImage(result);
    	},
    	error : function(result){
    		alert("이미지 파일이 아닙니다.");
    	}
	});		

	
});
	
/* var, method related with attachFile */
let regex = new RegExp("(.*?)\.(jpg|png)$");
let maxSize = 1048576; //1MB	

function fileCheck(fileName, fileSize){

	if(fileSize >= maxSize){
		alert("파일 사이즈 초과");
		return false;
	}
		  
	if(!regex.test(fileName)){
		alert("해당 종류의 파일은 업로드할 수 없습니다.");
		return false;
	}
	
	return true;		
	
}

/* 이미지 출력 */
function showUploadImage(uploadResultArr){
	
	/* 전달받은 데이터 검증 */
	if(!uploadResultArr || uploadResultArr.length == 0){return}
	
	let uploadResult = $("#uploadResult");
	
	let obj = uploadResultArr[0];
	
	let str = "";
	
	let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
	//replace 적용 하지 않아도 가능
	//let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
	
	str += "<div id='result_card'>";
	str += "<img src='/display?fileName=" + fileCallPath +"'>";
	str += "<div class='imgDeleteBtn' data-file='" + fileCallPath + "'>x</div>";
	str += "<input type='hidden' name='imageList[0].fileName' value='"+ obj.fileName +"'>";
	str += "<input type='hidden' name='imageList[0].uuid' value='"+ obj.uuid +"'>";
	str += "<input type='hidden' name='imageList[0].uploadPath' value='"+ obj.uploadPath +"'>";		
	str += "</div>";		
	
		uploadResult.append(str);     
    
}

/* 이미지 삭제 버튼 동작 */
$("#uploadResult").on("click", ".imgDeleteBtn", function(e){
	
	deleteFile();
	
});

/* 파일 삭제 메서드 */
function deleteFile(){
	
	$("#result_card").remove();
}
</script>
</html>
