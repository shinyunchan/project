<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Welcome BookMall</title>
<link rel="stylesheet" href="resources/css/search.css">
<script src="https://code.jquery.com/jquery-3.4.1.js"
   integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
   crossorigin="anonymous"></script>
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
            <a href="/main"><img src="/resources/img/logo.png"></a>
         </div>
         <div class="search_area">
                   <div class="search_wrap">
                      <form id="searchForm" action="/search" method="get">
                         <div class="search_input">
                            <select name="type">
                               <option value="T">상품명</option>
                            </select>
                            <input type="text" name="keyword" value="<c:out value="${pageMaker.cri.keyword}"/>">
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
            <!-- 게시물 o -->
            <c:if test="${listcheck != 'empty'}">
               <div class="list_search_result">
                  <table class="type_list">
                     <colgroup>
                        <col width="110">
                        <col width="*">
                        <col width="120">
                        <col width="120">
                        <col width="120">
                     </colgroup>
                     <tbody id="searchList>">
                        <c:forEach items="${list}" var="list">
                           <tr>
                              <td class="image">
                                 <div class="image_wrap"
                                    data-productid="${list.imageList[0].productId}"
                                    data-path="${list.imageList[0].uploadPath}"
                                    data-uuid="${list.imageList[0].uuid}"
                                    data-filename="${list.imageList[0].fileName}">
                                    <img>
                                 </div>
                              </td>
                              <td class="detail">
                                 <div class="title">
                                    <a href="/goodsDetail/${list.productId}">
                                       ${list.productName} </a>
                                 </div>

                              </td>


                              <td class="price">
                                 <div class="sell_price">
                                    <strong> <fmt:formatNumber
                                          value="${list.productPrice}" pattern="#,### 원" />
                                    </strong>
                                 </div>
                              </td>
                              <td class="option"></td>
                           </tr>
                        </c:forEach>
                     </tbody>

                  </table>
               </div>

               <!-- 페이지 이동 인터페이스 -->
               <div class="pageMaker_wrap">
                  <ul class="pageMaker">

                     <!-- 이전 버튼 -->
                     <c:if test="${pageMaker.prev }">
                        <li class="pageMaker_btn prev"><a
                           href="${pageMaker.pageStart -1}">이전</a></li>
                     </c:if>

                     <!-- 페이지 번호 -->
                     <c:forEach begin="${pageMaker.pageStart }"
                        end="${pageMaker.pageEnd }" var="num">
                        <li
                           class="pageMaker_btn ${pageMaker.cri.pageNum == num ? 'active':''}">
                           <a href="${num}">${num}</a>
                        </li>
                     </c:forEach>

                     <!-- 다음 버튼 -->
                     <c:if test="${pageMaker.next}">
                        <li class="pageMaker_btn next"><a
                           href="${pageMaker.pageEnd + 1 }">다음</a></li>
                     </c:if>
                  </ul>
               </div>

               <form id="moveForm" action="/search" method="get">
                  <input type="hidden" name="pageNum"
                     value="${pageMaker.cri.pageNum}"> <input type="hidden"
                     name="amount" value="${pageMaker.cri.amount}"> <input
                     type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
                  <input type="hidden" name="type" value="${pageMaker.cri.type}">
               </form>

            </c:if>
            <!-- 게시물 x -->
            <c:if test="${listcheck == 'empty'}">
               <div class="table_empty">검색결과가 없습니다.</div>
            </c:if>
         </div>
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
                    <img src="resources/img/logo.png">
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
   </div>      
      
   </div>   <!-- class="wrap" -->
</div>   <!-- class="wrapper" -->


   <script>

   /* gnb_area 로그아웃 버튼 작동 */
   $("#gnb_logout_button").click(function(){
      //alert("버튼 작동");
      $.ajax({
         type:"POST",
         url:"/member/logout.do",
         success:function(data){
            alert("로그아웃 성공");
            document.location.reload();    
         } 
      }); // ajax 
   });

   
   /* 페이지 이동 버튼 */
    const moveForm = $('#moveForm');
    
   $(".pageMaker_btn a").on("click", function(e){
      
      e.preventDefault();
      
      moveForm.find("input[name='pageNum']").val($(this).attr("href"));
      
      moveForm.submit();
      
   });
   
   $(document).ready(function(){
      // 검색 타입 selected
      document.getElementsByName("type")[0].focus();
   });
   
   
   /* 이미지 삽입 */
   $(".image_wrap").each(function(i, obj){
      
      const bobj = $(obj);
      
      if(bobj.data("productid")){
         
      const uploadPath = bobj.data("path");
      const uuid = bobj.data("uuid");
      const fileName = bobj.data("filename");
      
      const fileCallPath = encodeURIComponent(uploadPath + "/s_" + uuid + "_" + fileName);
      
      $(this).find("img").attr('src', '/display?fileName=' + fileCallPath);
      
      }else {
         $(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
      }
      
   });
</script>

</body>
</html>