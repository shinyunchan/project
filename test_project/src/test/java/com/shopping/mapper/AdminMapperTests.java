package com.shopping.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.shopping.model.AttachImageVO;
import com.shopping.model.ProductVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")

public class AdminMapperTests {

	@Autowired
	private AdminMapper mapper;
	
	/* 상품 등록 */
	@Test
	public void productEnrollTest() throws Exception{
		
		ProductVO product = new ProductVO();
		

		mapper.productEnroll(product);
	}
	@Test
	public void getAttachInfoTest() {
		
		int bookId = 15;
		
		List<AttachImageVO> list = mapper.getAttachInfo(bookId);
		
		System.out.println("list : " + list);
		
	}
}
