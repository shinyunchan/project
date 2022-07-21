<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>S-MART MALL</title>
<link rel="stylesheet" href="/resources/css/goodsDetail.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
   integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
   crossorigin="anonymous"></script>
<style type="text/css">
#result_card img {
padding-top:100px;
padding-left:200px;

}
</style>
</head>
<body>

   <div class="wrapper">
      <div class="wrap">
         <div class="top_gnb_area">
            <ul class="list">
               <c:if test="${member == null}">
                  <!-- 로그인 x -->
                  <li><a href="/member/login">로그인</a></li>
                  <li><a href="/member/join">회원가입</a></li>
               </c:if>
               <c:if test="${member != null }">
                  <!-- 로그인 o -->
                  <c:if test="${member.adminCk == 1 }">
                     <!-- 관리자 계정 -->
                     <li><a href="/admin/main">관리자 페이지</a></li>
                  </c:if>
                  <li><a id="gnb_logout_button">로그아웃</a></li>
                  <li><a href="/cart/${member.memberId}">장바구니</a></li>
               </c:if>
            </ul>
         </div>
         <div class="top_area">
            <!-- 로고영역 -->
            <div class="logo_area">
               <a href="/main"><img src="/resources/img/logo.jpg"></a>
            </div>
            <div class="search_area">
               <div class="search_wrap">
                  <form id="searchForm" action="/search" method="get">
                     <div class="search_input">
                        <select name="type">
                           <option value="T">책 제목</option>
                        </select> <input type="text" name="keyword"
                           value="<c:out value="${pageMaker.cri.keyword}"/>">
                        <button class='btn search_btn'>검 색</button>
                     </div>
                  </form>
               </div>
            </div>
            <div class="login_area">

               <!-- 로그인 하지 않은 상태 -->
               <c:if test="${member == null }">
                  <div class="login_button">
                     <a href="/member/login">로그인</a>
                  </div>
                  <span><a href="/member/join">회원가입</a></span>
               </c:if>

               <!-- 로그인한 상태 -->
               <c:if test="${ member != null }">
                  <div class="login_success_area">
                     <span>회원 : ${member.memberName}</span> <span>충전금액 : <fmt:formatNumber
                           value="${member.money }" pattern="\#,###.##" /></span> <span>포인트
                        : <fmt:formatNumber value="${member.point }" pattern="#,###" />
                     </span> <a href="/member/logout.do">로그아웃</a>
                  </div>
               </c:if>

            </div>
            <div class="clearfix"></div>
         </div>
         <div class="content_area">
            <div class="line"></div>
            <div class="content_top">
               <div class="ct_left_area">
                  <div class="form_section">
                     <div class="form_section_title">
                     </div>
                     <div class="form_section_content">

                        <div id="uploadReslut"></div>
                     </div>
                  </div>
                  <%-- <div class="image_wrap"
                     data-productid="${goodsInfo.imageList[0].productId}"
                     data-path="${goodsInfo.imageList[0].uploadPath}"
                     data-uuid="${goodsInfo.imageList[0].uuid}"
                     data-filename="${goodsInfo.imageList[0].fileName}">
                     <img> --%>
               </div>
            </div>
            
               <div class="title">
                  <h1>${goodsInfo.productName}</h1>
               </div>
             	<hr>
             	<br>
             	<br>
             	  <div class="price">
                  <div class="discount_price">
                    금액 :
                     <fmt:formatNumber value="${goodsInfo.productPrice}"
                        pattern="#,### 원" />
                  </div>
                  <div class="line"></div>
                  <div class="button">
                     <div class="button_quantity">
                        주문 수량 
                        <input type="text" class="quantity_input" value="1"> 
                        <span>
                           <button class="plus_btn">+</button>
                           <button class="minus_btn">-</button>
                        </span>
                     </div>
                     <div class="button_set">
                        <a class="btn_cart">장바구니 담기</a> <a class="btn_buy">바로구매</a>
            			<br><br><br>
                     </div>
                     <div class="content_middle">
               <div class="product_intro">${goodsInfo.productIntro}</div>
                  </div>
               </div>
            </div>
            <div class="line"></div>
            <div class="content_bottom">
               <br><br>
               
               <div class="product_content">${goodsInfo.productContents }</div>
            </div>
            <!-- 주문 form -->
			<form action="/order/${member.memberId}" method="get" class="order_form">
				<input type="hidden" name="orders[0].productId" value="${goodsInfo.productId}">
				<input type="hidden" name="orders[0].amount" value="">
			</form>
            

         </div>

     <br><br><br>
   <div class="footer_nav">
            <div class="footer_nav_container">
                <ul>
                    <li>박인혁</li>
                    <span class="line">|</span>
                    <li>강충만</li>
                    <span class="line">|</span>
                    <li>이홍규</li>
                    <span class="line">|</span>
                    <li>신윤찬</li>
                    <span class="line">|</span>
                </ul>
            </div>
        </div> <!-- class="footer_nav" -->
        
        <div class="footer">
            <div class="footer_container">
                
                <div class="footer_left">
                    <img src="../resources/img/logo.png">
                </div>
                <div class="footer_right">
                    (주) S-MART MALL    대표이사 : 옷사조
                    <br>
                    사업자등록번호 : 123-45-6789
                    <br>
                    대표전화 : 1234-5678(발신자 부담전화)
                    <br>
                    <br>
                    COPYRIGHT(C) <strong>Test Project 3Team</strong>
                </div>
                <div class="clearfix"></div>
            </div>
        </div> <!-- class="footer" -->    
      </div>
      <!-- class="wrap" -->
   </div>
   <!-- class="wrapper" -->

   <script>
/* 이미지 정보 호출 */
let productId = '<c:out value="${goodsInfo.productId}"/>';
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

//수량 버튼 조작
let quantity = $(".quantity_input").val();
$(".plus_btn").on("click", function(){
   $(".quantity_input").val(++quantity);
});
$(".minus_btn").on("click", function(){
   if(quantity > 1){
      $(".quantity_input").val(--quantity);   
   }
});

//서버로 전송할 데이터
const form = {
      memberId : '${member.memberId}',
      productId : '${goodsInfo.productId}',
      amount : ''
}

//장바구니 추가 버튼
$(".btn_cart").on("click", function(e){
   form.amount = $(".quantity_input").val();
   $.ajax({
      url: '/cart/add',
      type: 'POST',
      data: form,
      success: function(result){
         cartAlert(result);
      }
   })
});

function cartAlert(result){
   if(result == '0'){
      alert("장바구니에 추가를 하지 못하였습니다.");
   } else if(result == '1'){
      alert("장바구니에 추가되었습니다.");
   } else if(result == '2'){
      alert("장바구니에 이미 추가되어져 있습니다.");
   } else if(result == '5'){
      alert("로그인이 필요합니다.");   
   }
}
/* 바로구매 버튼 */
$(".btn_buy").on("click", function(){
	let amount = $(".quantity_input").val();
	$(".order_form").find("input[name='orders[0].amount']").val(amount);
	$(".order_form").submit();
});
</script>
</body>
</html>