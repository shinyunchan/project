package com.shopping.mapper;

import java.util.List;

import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;

public interface AdminMapper {
	
	public void productEnroll(ProductVO product);
	
	public List<ProductVO> goodsGetList(Criteria cri);
	
	public int goodsGetTotal(Criteria cri);
	
	public ProductVO goodsDetail(int productId);
	
	public void imageEnroll(AttachImageVO vo);

	public List<AttachImageVO> getAttachInfo(int productId);

	public int goodsModify(ProductVO vo);

	public int goodsDelete(int productId);

	public void deleteImageAll(int productId);

	public int idCheck(int productId);

}
