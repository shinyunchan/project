package com.shopping.service;

import java.util.List;

import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;
import com.shopping.model.SelectDTO;

public interface ProductService {

	/* 상품 검색 */
	public List<ProductVO> getGoodsList(Criteria cri);
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	public ProductVO getGoodsInfo(int productId);
	
	/* 상품 정보 */
	public List<SelectDTO> likeSelect();

}
