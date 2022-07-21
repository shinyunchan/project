package com.shopping.mapper;

import java.util.List;

import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;
import com.shopping.model.SelectDTO;

public interface ProductMapper {
	
	
	
	/* 상품 검색 */
	public List<ProductVO> getGoodsList(Criteria cri);
	
	
	/* 상품 총 갯수 */
	public int goodsGetTotal(Criteria cri);
	
	/* 상품 이름 요청 */
	public String[] getProductNameList(String keyword);
	
	/* 상품 정보 */
	public ProductVO getGoodsInfo(int productId);
	
	/* 메인 상품 정보 */
	public List<SelectDTO> likeSelect();
	
}
