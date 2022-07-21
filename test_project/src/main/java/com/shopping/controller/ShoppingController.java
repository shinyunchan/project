

package com.shopping.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.shopping.mapper.AttachMapper;
import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.PageDTO;
import com.shopping.model.ProductVO;
import com.shopping.service.ProductService;

@Controller
public class ShoppingController {

	private static final Logger logger = LoggerFactory.getLogger(ShoppingController.class);
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private ProductService productService;
	
	//메인 페이지 이동
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public void mainPageGET(Model model) {
		
		logger.info("메인 페이지 진입");
		model.addAttribute("ls", productService.likeSelect());
	}
	
	@GetMapping("/display")
	public ResponseEntity<byte[]> getImage(String fileName){
		
		File file = new File("D:\\upload\\" + fileName);
		
		
		ResponseEntity<byte[]> result = null;
		
		try {
			
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
			
		}catch (IOException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/* 이미지 정보 반환 */
	@GetMapping(value="/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<AttachImageVO>> getAttachList(int productId){
		
		logger.info("getAttachList.........." + productId);
		
		return new ResponseEntity<List<AttachImageVO>>(attachMapper.getAttachList(productId), HttpStatus.OK);
		
	}
	
	/* 상품 검색 */
	@GetMapping("search")
	public String searchGoodsGET(Criteria cri, Model model) {
		
		logger.info("cri : " + cri);
		
		List<ProductVO> list = productService.getGoodsList(cri);
		logger.info("pre list : " + list);
		if(!list.isEmpty()) {
			model.addAttribute("list", list);
			logger.info("list : " + list);
		} else {
			model.addAttribute("listcheck", "empty");
			
			return "search";
		}
		
		model.addAttribute("pageMaker", new PageDTO(cri, productService.goodsGetTotal(cri)));
		
		
		return "search";
		
	}
	
	/* 상품 상세 */
	@GetMapping("/goodsDetail/{productId}")
	public String goodsDetailGET(@PathVariable("productId")int productId, Model model) {
		
		model.addAttribute("goodsInfo", productService.getGoodsInfo(productId));
		
		return "/goodsDetail";
	}
	
}
