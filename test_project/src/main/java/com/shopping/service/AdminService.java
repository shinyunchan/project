package com.shopping.service;

import java.util.List;


import org.springframework.ui.Model;

import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;

public interface AdminService {

	
	public void productEnroll(ProductVO product);
	
	/* 상품 리스트 */
	public List<ProductVO> goodsGetList(Criteria cri);
	
	/* 상품 총 개수 */
	public int goodsGetTotal(Criteria cri) throws Exception;
	
	public void goodsDetail(int productId, Model model);
	
	/* 지정 상품 이미지 정보 얻기 */
	public List<AttachImageVO> getAttachInfo(int productId);

	public int goodsModify(ProductVO vo);

	public int goodsDelete(int productId);

	public int idCheck(int productId);

	
}
