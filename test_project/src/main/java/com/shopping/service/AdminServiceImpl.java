package com.shopping.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.shopping.mapper.AdminMapper;
import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;

@Service
public class AdminServiceImpl implements AdminService {
	
	@Autowired
	private AdminMapper mapper;	
	
	@Autowired
	private AttachService as;
	
	/* 상품 등록 */
	@Transactional
	@Override
	public void productEnroll(ProductVO product) {
		
		mapper.productEnroll(product);
		
		if(product.getImageList() == null || product.getImageList().size() <= 0) {
			return;
		}
		
		product.getImageList().forEach(attach ->{
			
			attach.setProductId(product.getProductId());
			mapper.imageEnroll(attach);
			
		});
	}
	
	
	@Override
	public List<AttachImageVO> getAttachInfo(int productId) {
		// TODO Auto-generated method stub
		return mapper.getAttachInfo(productId);
	}



	@Override
	public List<ProductVO> goodsGetList(Criteria cri) {
			
		return mapper.goodsGetList(cri);
	}

	@Override
	public int goodsGetTotal(Criteria cri) {
	
		return mapper.goodsGetTotal(cri);
	}
	
	@Override
	public void goodsDetail(int productId, Model model) {
		model.addAttribute("data", mapper.goodsDetail(productId));
	}

	@Transactional
	@Override
	public int goodsModify(ProductVO vo) {
		int result = mapper.goodsModify(vo);
		
		if(result == 1 && vo.getImageList() != null && vo.getImageList().size() > 0) {
			
			mapper.deleteImageAll(vo.getProductId());
			
			vo.getImageList().forEach(attach -> {
				
				attach.setProductId(vo.getProductId());
				mapper.imageEnroll(attach);
				
			});
			
		}
		
		return result;
	}


	@Override
	public int goodsDelete(int productId) {
		return mapper.goodsDelete(productId);
	}


	@Override
	public int idCheck(int productId) {
		return mapper.idCheck(productId);
	}		

	
	
}
