<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="/resources/css/order.css">
<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>
  <!-- 다음 주소 -->
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>

<div class="wrapper">
   <div class="wrap">
      <div class="top_gnb_area">
         <ul class="list">
            <c:if test = "${member == null}">   <!-- 로그인 x -->   
               <li >
                  <a href="/member/login">로그인</a>
               </li>
               <li>
                  <a href="/member/join">회원가입</a>
               </li>
            </c:if>
            <c:if test="${member != null }">   <!-- 로그인 o -->      
               <c:if test="${member.adminCk == 1 }">   <!-- 관리자 계정 -->
                  <li><a href="/admin/main">관리자 페이지</a></li>
               </c:if>                     
               <li>
                  <a id="gnb_logout_button">로그아웃</a>
               </li>
               <li>
                  <a href="/cart/${member.memberId}">장바구니</a>
               </li>
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
                               <option value="T">상품 이름</option>

                            </select>
                            <input type="text" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
                             <button class='btn search_btn'>검 색</button>                            
                         </div>
                      </form>
                   </div>
         </div>
         <div class="login_area">
         
            <!-- 로그인 하지 않은 상태 -->
            <c:if test = "${member == null }">
               <div class="login_button"><a href="/member/login">로그인</a></div>
               <span><a href="/member/join">회원가입</a></span>            
            </c:if>            
            
            <!-- 로그인한 상태 -->
            <c:if test="${ member != null }">
               <div class="login_success_area">
                  <span>회원 : ${member.memberName}</span>
                  <span>충전금액 : <fmt:formatNumber value="${member.money }" pattern="\#,###.##"/></span>
                  <a href="/member/logout.do">로그아웃</a>
               </div>
            </c:if>

         </div>
         <div class="clearfix"></div>         
      </div>
      <div class="content_area">
       
       <div class="content_main">
            <!-- 회원 정보 -->
            <div class="member_info_div">
               <table class="table_text_align_center memberInfo_table">
                  <tbody>
                     <tr>
                        <th style="width: 25%;">주문자</th>
                        <td style="width: *">${memberInfo.memberName} | ${memberInfo.memberMail}</td>
                     </tr>
                  </tbody>
               </table>
            </div>
            <!-- 배송지 정보 -->
            <div class="addressInfo_div">
               <div class="addressInfo_button_div">
                  <button class="address_btn address_btn_1" onclick="showAdress('1')" style="background-color: #cca63d;">상용자 정보 주소록</button>
                  <button class="address_btn address_btn_2" onclick="showAdress('2')">직접 입력</button>
               </div>
               <div class="addressInfo_input_div_wrap">
                  <div class="addressInfo_input_div addressInfo_input_div_1" style="display: block">
                     <table>
                        <colgroup>
                           <col width="25%">
                           <col width="*">
                        </colgroup>
                        <tbody>
                           <tr>
                              <th>이름</th>
                              <td>
                                 ${memberInfo.memberName}
                              </td>
                           </tr>
                           <tr>
                              <th>주소</th>
                              <td>
                                 ${memberInfo.memberAddr1} ${memberInfo.memberAddr2}<br>${memberInfo.memberAddr3}
                                 <input class="selectAddress" value="T" type="hidden">
                                 <input class="addressee_input" value="${memberInfo.memberName}" type="hidden">
                                 <input class="address1_input" type="hidden" value="${memberInfo.memberAddr1}">
                                 <input class="address2_input" type="hidden" value="${memberInfo.memberAddr2}">
                                 <input class="address3_input" type="hidden" value="${memberInfo.memberAddr3}">                              
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
                  <div class="addressInfo_input_div addressInfo_input_div_2">
                     <table>
                        <colgroup>
                           <col width="25%">
                           <col width="*">
                        </colgroup>
                        <tbody>
                           <tr>
                              <th>이름</th>
                              <td>
                                 <input class="addressee_input">
                              </td>
                           </tr>
                           <tr>
                              <th>주소</th>
                              <td>
                                 <input class="selectAddress" value="F" type="hidden">
                                 <input class="address1_input" readonly="readonly"> <a class="address_search_btn" onclick="execution_daum_address()">주소 찾기</a><br>
                                 <input class="address2_input" readonly="readonly"><br>
                                 <input class="address3_input" readonly="readonly">
                              </td>
                           </tr>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
            <!-- 상품 정보 -->
            <div class="orderGoods_div">
            <!-- 상품 종류 -->
            <div class="goods_kind_div">
               주문상품
            </div>
            <!-- 상품 테이블 -->
            <table class="goods_subject_table">
               <colgroup>
                  <col width="15%">
                  <col width="45%">
                  <col width="40%">
               </colgroup>
               <tbody>
                  <tr>
                     <th>이미지</th>
                     <th>상품 정보</th>
                     <th>판매가</th>
                  </tr>
               </tbody>
            </table>
            <table class="goods_table">
               <colgroup>
                  <col width="15%">
                  <col width="45%">
                  <col width="40%">
               </colgroup>               
               <tbody>
                     <c:forEach items="${orderList}" var="ol">
                        <tr>
                           <td>
                              <!-- 이미지 <td>-->
                              <div class="image_wrap" data-productId="${ol.imageList[0].productId}" data-path="${ol.imageList[0].uploadPath}" data-uuid="${ol.imageList[0].uuid}" data-filename="${ol.imageList[0].fileName}">
                                 <img>
                              </div>
                           </td>
                           <td>${ol.productName}</td>
                           <td class="goods_table_price_td">
                              <fmt:formatNumber value="${ol.productPrice}" pattern="#,### 원" /> | 수량 ${ol.amount}개
                              <br><fmt:formatNumber value="${ol.totalPrice}" pattern="#,### 원" />
                              <input type="hidden" class="individual_productPrice_input" value="${ol.productPrice}">
                              <input type="hidden" class="individual_amount_input" value="${ol.amount}">
                              <input type="hidden" class="individual_totalPrice_input" value="${ol.productPrice * ol.amount}">
                              <input type="hidden" class="individual_productId_input" value="${ol.productId}">
                           </td>
                        </tr>                     
                     </c:forEach>
                  </tbody>
               </table>
            </div>
            <!-- 주문 종합 정보 -->
            <div class="total_info_div">
            <!-- 가격 종합 정보 -->
            <div class="total_info_price_div">
               <ul>
                  <li>
                     <span class="price_span_label">상품 금액</span>
                     <span class="totalPrice_span">100000</span>원
                  </li>
                  <li>
                     <span class="price_span_label">배송비</span>
                     <span class="delivery_price_span">100000</span>원
                  </li>
                  <li class="price_total_li">
                     <strong class="price_span_label total_price_label">최종 결제 금액</strong>
                     <strong class="strong_red">
                        <span class="total_price_red finalTotalPrice_span">
                           1500000
                        </span>원
                     </strong>
                  </li>
               </ul>
            </div>
            <!-- 버튼 영역 -->
            <div class="total_info_btn_div">
               <button class="order_btn" onclick="requestPay()">결제하기</button>
            </div>
         </div>
      </div>
      </div>
            <!-- 주문 요청 form -->
      <form class="order_form" action="/order" method="post">
         <!-- 주문자 회원번호 -->
         <input name="memberId" value="${memberInfo.memberId}" type="hidden">
         <!-- 주소록 & 받는이-->
         <input name="addressee" type="hidden">
         <input name="memberAddr1" type="hidden">
         <input name="memberAddr2" type="hidden">
         <input name="memberAddr3" type="hidden">

         <!-- 상품 정보 -->
      </form>
      
      <!-- Footer 영역 -->
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
      
   </div>   <!-- class="wrap" -->
</div>   <!-- class="wrapper" -->

<script>
function requestPay() {
  IMP.init('imp14074904'); //iamport 대신 자신의 "가맹점 식별코드"를 사용
  IMP.request_pay({
    pg: "kakaopay",
    pay_method: "card",
    merchant_uid : 'merchant_'+new Date().getTime(),
    name : '결제테스트',
    amount : 14000,
    buyer_email : 'iamport@siot.do',
    buyer_name : '구매자',
    buyer_tel : '010-1234-5678',
    buyer_addr : '서울특별시 강남구 삼성동',
    buyer_postcode : '123-456'
  }, function (rsp) { // callback
      if (rsp.success) {
         var msg = '결제가 완료되었습니다.';
          alert(msg);
          location.href = "http://localhost:8080/main"
      } else {
          var msg = '결제에 실패하였습니다.';
          msg += '에러내용 : ' + rsp.error_msg;
          alert(msg);
      }
  });
}
</script>


<script>
$(document).ready(function(){
   
   /* 주문 조합정보란 최신화 */
   setTotalInfo();
   
   /* 이미지 삽입 */
   $(".image_wrap").each(function(i, obj){
      
      const bobj = $(obj);
      
      if(bobj.data("productid")){
         const uploadPath = bobj.data("path");
         const uuid = bobj.data("uuid");
         const fileName = bobj.data("filename");
         
         const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
         
         $(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
      } else {
         $(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
      }
      
   });
});


/* 주소입력란 버튼 동작(숨김, 등장) */
function showAdress(className){
   /* 컨텐츠 동작 */
      /* 모두 숨기기 */
      $(".addressInfo_input_div").css('display', 'none');
      /* 컨텐츠 보이기 */
      $(".addressInfo_input_div_" + className).css('display', 'block');      
   
   /* 버튼 색상 변경 */
      /* 모든 색상 동일 */
         $(".address_btn").css('backgroundColor', '#eae1d8');
      /* 지정 색상 변경 */
         $(".address_btn_"+className).css('backgroundColor', '#cca63d');   
         /* selectAddress T/F */
         /* 모든 selectAddress F만들기 */
         $(".addressInfo_input_div").each(function(i, obj){
            $(obj).find(".selectAddress").val("F");
         });
         /* 선택한 selectAdress T만들기 */
         $(".addressInfo_input_div_" + className).find(".selectAddress").val("T");
}


/* 다음 주소 연동 */
function execution_daum_address(){
       console.log("동작");
      new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
               
              // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
 
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
 
                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 추가해야할 코드
                    // 주소변수 문자열과 참고항목 문자열 합치기
                      addr += extraAddr;
                
                } else {
                   addr += ' ';
                }
 
                // 제거해야할 코드
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $(".address1_input").val(data.zonecode);
                $(".address2_input").val(addr);            
                // 커서를 상세주소 필드로 이동한다.
                $(".address3_input").attr("readonly", false);
                $(".address3_input").focus();    
               
               
           }
       }).open();     
   
}
/* 총 주문 정보 세팅(배송비, 총 가격, 마일리지, 물품 수, 종류) */
function setTotalInfo(){

   let totalPrice = 0;            // 총 가격
   let totalCount = 0;            // 총 갯수
   let totalKind = 0;            // 총 종류
   let deliveryPrice = 0;         // 배송비
   let finalTotalPrice = 0;       // 최종 가격(총 가격 + 배송비)   
   
   $(".goods_table_price_td").each(function(index, element){
      // 총 가격
      totalPrice += parseInt($(element).find(".individual_totalPrice_input").val());
      // 총 갯수
      totalCount += parseInt($(element).find(".individual_bookCount_input").val());
      // 총 종류
      totalKind += 1;
   });   

   /* 배송비 결정 */
   if(totalPrice >= 30000){
      deliveryPrice = 0;
   } else if(totalPrice == 0){
      deliveryPrice = 0;
   } else {
      deliveryPrice = 3000;   
   }
   
   finalTotalPrice = totalPrice + deliveryPrice;   
   
   
   /* 값 삽입 */
   // 총 가격
   $(".totalPrice_span").text(totalPrice.toLocaleString());
   // 총 갯수
   $(".goods_kind_div_count").text(totalCount);
   // 총 종류
   $(".goods_kind_div_kind").text(totalKind);
   // 배송비
   $(".delivery_price_span").text(deliveryPrice.toLocaleString());   
   // 최종 가격(총 가격 + 배송비)
   $(".finalTotalPrice_span").text(finalTotalPrice.toLocaleString());      
   
}
/* 주문 요청 */
$(".order_btn").on("click", function(){

   /* 주소 정보 & 받는이*/
   $(".addressInfo_input_div").each(function(i, obj){
      if($(obj).find(".selectAddress").val() === 'T'){
         $("input[name='addressee']").val($(obj).find(".addressee_input").val());
         $("input[name='memberAddr1']").val($(obj).find(".address1_input").val());
         $("input[name='memberAddr2']").val($(obj).find(".address2_input").val());
         $("input[name='memberAddr3']").val($(obj).find(".address3_input").val());
      }
   });
   /* 상품정보 */
   let form_contents = ''; 
   $(".goods_table_price_td").each(function(index, element){
      let productId = $(element).find(".individual_productId_input").val();
      let amount = $(element).find(".individual_amount_input").val();
      let productId_input = "<input name='orders[" + index + "].productId' type='hidden' value='" + productId + "'>";
      form_contents += productId_input;
      let amount_input = "<input name='orders[" + index + "].amount' type='hidden' value='" + amount + "'>";
      form_contents += amount_input;
   });   
   $(".order_form").append(form_contents);   

});
</script>

</body>
</html>