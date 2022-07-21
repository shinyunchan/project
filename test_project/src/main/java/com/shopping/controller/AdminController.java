package com.shopping.controller;


import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.PageDTO;
import com.shopping.model.ProductVO;
import com.shopping.service.AdminService;

import net.coobird.thumbnailator.Thumbnails;

@Controller
@RequestMapping("/admin")
public class AdminController {
 
    private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
    
    @Autowired
	private AdminService adminService;
    
    /* 관리자 메인 페이지 이동 */
    @RequestMapping(value="main", method = RequestMethod.GET)
    public void adminMainGET() throws Exception{
        
        logger.info("관리자 페이지 이동");
        
    }
    
    
    /* 관리자 상품 상세 페이지 */
    @RequestMapping(value = "goodsDetail", method = RequestMethod.GET)
    public String goodsDetail(@RequestParam(value = "productId", required = false, defaultValue = "1") int productId, Model model) {
    	adminService.goodsDetail(productId, model);
    	return "admin/goodsDetail";
    }
    /* 관리자 상품 수정 페이지 */
    @RequestMapping(value = "goodsModify", method = RequestMethod.GET)
    public String goodsModify(@RequestParam(value = "productId", required = false, defaultValue = "1") int productId, Model model){
    	adminService.goodsDetail(productId, model);
    	return "admin/goodsModify";
    }
    
    @PostMapping("/goodsModify")
	public String goodsModifyPOST(ProductVO vo, RedirectAttributes rttr) {
		
		logger.info("goodsModifyPOST.........." + vo);
		
		int result = adminService.goodsModify(vo);
		
		rttr.addFlashAttribute("modify_result", result);
		
		return "redirect:/admin/authorManage";		
		
	}
    
    @PostMapping("/goodsDelete")
	public String goodsDeletePOST(int productId, RedirectAttributes rttr) {
		
		logger.info("goodsDeletePOST..........");
		
		int result = adminService.goodsDelete(productId);
		
		rttr.addFlashAttribute("delete_result", result);
		
		return "redirect:/admin/authorManage";
		
	}
    
    /* 상품 등록 페이지 접속 */
    @RequestMapping(value = "goodsManage", method = RequestMethod.GET)
    public void goodsManageGET() throws Exception{
        logger.info("상품 등록 페이지 접속");
    }
    
    /* 상품 등록 페이지 접속 */
    @RequestMapping(value = "goodsEnroll", method = RequestMethod.GET)
    public void goodsEnrollGET() throws Exception{
        logger.info("상품 등록 페이지 접속");
        
        
    }
    
    @RequestMapping(value = "/productIdChk", method = RequestMethod.POST)
	@ResponseBody
	public String productIdChkPOST(int productId) throws Exception{
		
		// logger.info("memberIdChk() 진입");
		
		logger.info("memberIdChk() 진입");
		
		int result = adminService.idCheck(productId);
		
		logger.info("결과값 = " + result);
		
		if(result != 0) {
			
			return "fail";	// 중복 아이디가 존재
			
		} else {
			
			return "success";	// 중복 아이디 x
			
		}	
	} // memberIdChkPOST() 종료	
    
    /* 작가 등록 페이지 접속 */
    @RequestMapping(value = "authorEnroll", method = RequestMethod.GET)
    public void authorEnrollGET() throws Exception{
        logger.info("작가 등록 페이지 접속");
    }
    
    /* 작가 관리 페이지 접속 */
    @RequestMapping(value = "authorManage", method = RequestMethod.GET)
    public void authorManageGET(Criteria cri, Model model) throws Exception{
        logger.info("작가 관리 페이지 접속");
        
        List<ProductVO> list = adminService.goodsGetList(cri);
        
        model.addAttribute("list", list);
        
		/* 페이지 이동 인터페이스 데이터 */
        model.addAttribute("pageMaker", new PageDTO(cri, adminService.goodsGetTotal(cri)));
    }
    /* 첨부 파일 업로드 */
    @PostMapping("/uploadAjaxAction")
	public ResponseEntity<List<AttachImageVO>> uploadAjaxActionPOST(MultipartFile[] uploadFile) {
		
		logger.info("uploadAjaxActionPOST..........");
		
		
		/* 이미지 파일 체크 */
		for(MultipartFile multipartFile: uploadFile) {
			
			File checkfile = new File(multipartFile.getOriginalFilename());
			String type = null;
			
			try {
				type = Files.probeContentType(checkfile.toPath());
				logger.info("MIME TYPE : " + type);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			if(!type.startsWith("image")) {
				List<AttachImageVO> list = null;
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}


			
		}
		
		
		String uploadFolder = "D:\\upload";
		
		// 날짜 폴더 경로
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Date date = new Date();
		
		String str = sdf.format(date);
		
		String datePath = str.replace("-", File.separator);
		
		/* 폴더 생성 */
		File uploadPath = new File(uploadFolder, datePath);
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		
		List<AttachImageVO> list = new ArrayList();
		
		
	      // 향상된 for
	      for(MultipartFile multipartFile : uploadFile) {
	         
	    	  AttachImageVO vo = new AttachImageVO();
	    	  
	    	  /* 파일 이름 */
	    	  String uploadFileName = multipartFile.getOriginalFilename();         
	         
	         
	         vo.setFileName(uploadFileName);
	     	 vo.setUploadPath(datePath);
	         
	     	/* uuid 적용 파일 이름 */
				String uuid = UUID.randomUUID().toString();
				vo.setUuid(uuid);
				
				uploadFileName = uuid + "_" + uploadFileName;
				
				
	         /* 파일 위치, 파일 이름을 합친 File 객체 */
	         File saveFile = new File(uploadPath, uploadFileName);
	         
	         /* 파일 저장 */
	         try {
	            multipartFile.transferTo(saveFile);
	            
	            /*
	            File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);
				BufferedImage bo_image = ImageIO.read(saveFile);
				
				
				double ratio = 3;
				
				int width = (int) (bo_image.getWidth() / ratio);
				int height = (int) (bo_image.getHeight() / ratio);	
				
				
				BufferedImage bt_image = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
				
				Graphics2D graphic = bt_image.createGraphics();
				
				graphic.drawImage(bo_image, 0, 0,width,height, null);
				
				ImageIO.write(bt_image, "jpg", thumbnailFile);
				*/
	        	/* 방법 2 */
				
	            File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);	
				
				BufferedImage bo_image = ImageIO.read(saveFile);

					//비율 
					double ratio = 3;
					//넓이 높이
					int width = (int) (bo_image.getWidth() / ratio);
					int height = (int) (bo_image.getHeight() / ratio);					
				
				
				Thumbnails.of(saveFile)
		        .size(width, height)
		        .toFile(thumbnailFile);
				
	         } catch (Exception e) {
	            e.printStackTrace();
	         }
	         
	         list.add(vo);
	         
	      }
	      
	      ResponseEntity<List<AttachImageVO>> result = new ResponseEntity<List<AttachImageVO>>(list, HttpStatus.OK);
	      
	      return result;
	   }
    
	@PostMapping("/goodsEnroll")
	public String goodsEnrollPOST(ProductVO product, RedirectAttributes rttr) {
		
		logger.info("goodsEnrollPOST......" + product);
		
		adminService.productEnroll(product);
		
		rttr.addFlashAttribute("enroll_result", product.getProductName());
		
		return "redirect:/admin/authorManage";
	}	
	
	/* 이미지 파일 삭제 */
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(String fileName){
		
		logger.info("deleteFile........" + fileName);
		
		File file = null;
		
		try {
			/* 썸네일 파일 삭제 */
			file = new File("D:\\upload\\" + URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			/* 원본 파일 삭제 */
			String originFileName = file.getAbsolutePath().replace("s_", "");
			
			logger.info("originFileName : " + originFileName);
			
			file = new File(originFileName);
			
			file.delete();
			
			
		} catch(Exception e) {
			
			e.printStackTrace();
			
			return new ResponseEntity<String>("fail", HttpStatus.NOT_IMPLEMENTED);
			
		}
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}	
	
}

