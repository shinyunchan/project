<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="resources/css/main.css">
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css"/>
<script src="https://code.jquery.com/jquery-3.4.1.js"
   integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
   crossorigin="anonymous">
 </script>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
 <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
 <style type="text/css">
   #result_card img{
      max-width: 50%;
       height: auto;
       display: block;
       padding: 5px;
       margin-top: 10px;
       margin: auto;   
   }
</style>
</head>
<body>
   <div class="wrapper">
      <div class="wrap">
         <c:import url="default/header.jsp" />
         <div class="top_area">
            <div class="logo_area">

					<a href="/main"><img src="resources/img/logo.png"></a>
				</div>
				<div class="clearfix"></div>
			</div>
			<div class="navi_bar_area"></div>
 		<div class="content_area">
         <div class="slide_div_wrap">
            <div class="slide_div">
               <div>
                  <a>
                     <img src="../resources/img/b1.jpg">
                  </a>
               </div>
               <div>
                  <a>
                     <img src="../resources/img/b2.jpg">
                  </a>
               </div>
               <div>
                  <a>
                     <img src="../resources/img/b3.jpg">
                  </a>
               </div>            
            </div>   
         </div>
      
         
         <div class="ls_wrap">
            <div class="ls_div_subject">
               
            </div>
            <div class="ls_div">
               <c:forEach items="${ls}" var="ls">
                  <a href="/goodsDetail/${ls.productId}">
                     <div class="ls_div_content_wrap">
                        <div class="ls_div_content">
                           <td>
                           <div class="image_wrap" data-productid="${ls.imageList[0].productId}" data-path="${ls.imageList[0].uploadPath}" data-uuid="${ls.imageList[0].uuid}" data-filename="${ls.imageList[0].fileName}">
                              <img>
                           </div>
                           </td>
                           <td>            
                           <div class="ls_productName">
                              ${ls.productName}
                           </div>
                           </td>                     
                        </div>
                     </div>
                  </a>               
               </c:forEach>               
            </div>
         </div>   
         
      </div>
         
         <c:import url="default/footer.jsp" />
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

$(document).ready(function(){
   $(".slide_div").slick(
         {
            dots: true,
            autoplay : true,
            autoplaySpeed: 5000
         }            
   );   
   
   $(".ls_div").slick({
      slidesToShow: 4,
      slidesToScroll: 4,
      prevArrow : "<button type='button' class='ls_div_content_prev'>이전</button>",      // 이전 화살표 모양 설정
      nextArrow : "<button type='button' class='ls_div_content_next'>다음</button>",      // 다음 화살표 모양 설정   
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
      } else {
         $(this).find("img").attr('src', '/resources/img/goodsNoImage.png');
      }
      
   });   
});
    
</script>
</body>
</html>