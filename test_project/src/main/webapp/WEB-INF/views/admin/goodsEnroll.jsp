<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#result_card img{
		max-width: 100%;
	    height: auto;
	    display: block;
	    padding: 5px;
	    margin-top: 10px;
	    margin: auto;	
	}
	#result_card {
		position: relative;
	}
	.imgDeleteBtn{
	    position: absolute;
	    top: 0;
	    right: 5%;
	    background-color: #ef7d7d;
	    color: wheat;
	    font-weight: 900;
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    line-height: 26px;
	    text-align: center;
	    border: none;
	    display: block;
	    cursor: pointer;	
	}
	
</style>
<link rel="stylesheet" href="../resources/css/admin/goodsEnroll.css">
 
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
                <c:import url="adminNav.jsp" />
                <div class="admin_content_wrap">
                    <div class="admin_content_subject"><span>상품 등록</span></div>
                      <div class="admin_content_main">
                    	<form action="/admin/goodsEnroll" method="post" id="enrollForm">
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
                    				<input class="id_input" name="productId">
                    				<span class="ck_warn productId_warn">상품 아이디를 입력해주세요</span>
                    				<span class="id_input_re_1">사용 가능한 아이디입니다.</span>
									<span class="id_input_re_2">아이디가 이미 존재합니다.</span>
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
                    		<div class="form_section">
                    			<div class="form_section_title">
                    				<label>상품 이미지</label>
                    			</div>
                    			<div class="form_section_content">
									<input type="file" id ="fileItem" name='uploadFile' style="height: 30px;">
									<div id="uploadResult">
									<!-- 
									<div id="result_card">
											<div class="imgDeleteBtn">x</div>
											<img src="/resources/img/logo.jpg">
										</div>
										-->
									</div>
                    			</div>
                    		</div>  
                   		</form>
                   			<div class="btn_section">
                   				<button id="cancelBtn" class="btn">취 소</button>
	                    		<button id="enrollBtn" class="btn enroll_btn">등 록</button>
	                    	</div> 
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
        

        
    </div>    <!-- class="wrap" -->
</div>    <!-- class="wrapper" -->
 
<script>

let enrollForm = $("#enrollForm")
	
/* 취소 버튼 */
$("#cancelBtn").click(function(){
	
	location.href="/admin/authorManage"
	
});

/* 상품 등록 버튼 */
$("#enrollBtn").on("click",function(e){
	
	e.preventDefault();
	
	/* 체크 변수 */
	let produtNameCk = false;
	let productIdCk = false;
	let productpriceCk = false;
	let productstockCk = false;
	let productintroCk = false;
	let productcontentsCk = false;
	
	/* 체크 대상 변수 */
	let prodcutName = $("input[name='productName']").val();
	let productId = $("input[name='productId']").val();
	let productPrice = $("input[name='productPrice']").val();
	let productStock = $("input[name='productStock']").val();
	let productIntro = $("input[name='productIntro']").val();
	let productContents = $("input[name='productContents']").val();
	
	if(prodcutName){
		$(".productName_warn").css('display','none');
		productNameCk = true;
	} else {
		$(".productName_warn").css('display','block');
		productNameCk = false;
	}
	
	if(productId){
		$(".productId_warn").css('display','none');
		productIdCk = true;
	} else {
		$(".productId_warn").css('display','block');
		productIdCk = false;
	}
	
	if(productPrice != 0){
		$(".productPrice_warn").css('display','none');
		productpriceCk = true;
	} else {
		$(".productPrice_warn").css('display','block');
		productpriceCk = false;
	}	
	
	if(productStock != 0){
		$(".productStock_warn").css('display','none');
		productstockCk = true;
	} else {
		$(".productStock_warn").css('display','block');
		productstockCk = false;
	}		
	
	if(productIntro){
		$(".productIntro_warn").css('display','none');
		productintroCk = true;
	} else {
		$(".productIntro_warn").css('display','block');
		productintroCk = false;
	}	
	
	if(productContents){
		$(".productContents_warn").css('display','none');
		productcontentsCk = true;
	} else {
		$(".productContents_warn").css('display','block');
		productcontentsCk = false;
	}
	
	if(productNameCk && productIdCk && productpriceCk && productstockCk && productintroCk && productcontentsCk ){
		//alert('통과');
		enrollForm.submit();
	} else {
		return false;
	}
});

/* 이미지 업로드 */
$("input[type='file']").on("change", function(e){
    
	/* 이미지 존재시 삭제 */
	if($(".imgDeleteBtn").length > 0){
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
   if(!uploadResultArr || uploadResultArr.length == 0){return;}
   
   let uploadResult = $("#uploadResult");
   
   let obj = uploadResultArr[0];
   
   let str = "";
   
   let fileCallPath = encodeURIComponent(obj.uploadPath.replace(/\\/g, '/') + "/s_" + obj.uuid + "_" + obj.fileName);
   
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
	
	let targetFile = $(".imgDeleteBtn").data("file");
	
	let targetDiv = $("#result_card");
	
	$.ajax({
		url: '/admin/deleteFile',
		data : {fileName : targetFile},
		dataType : 'text',
		type : 'POST',
		success : function(result){
			console.log(result);
			
			targetDiv.remove();
			$("input[type='file']").val("");
			
		},
		error : function(result){
			console.log(result);
			
			alert("파일을 삭제하지 못하였습니다.")
		}
	});
}

$('.id_input').on("propertychange change keyup paste input", function(){


	var productId = $('.id_input').val();			// .id_input에 입력되는 값
	var data = {productId : productId}				// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
	
	$.ajax({
		type : "post",
		url : "/admin/productIdChk",
		data : data,
		success : function(result){
			 // console.log("성공 여부" + result);
			if(result != 'fail'){
				$('.id_input_re_1').css("display","inline-block");
				$('.id_input_re_2').css("display", "none");
				idckCheck = true;
				 
			} else {
				$('.id_input_re_2').css("display","inline-block");
				$('.id_input_re_1').css("display", "none");				
				idckCheck = false;
			}
		}// success 종료
	}); // ajax 종료

});// function 종료
</script> 	
</body>
</html>
