package com.shopping.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mapper.AdminMapper;
import com.shopping.mapper.AttachMapper;
import com.shopping.mapper.ProductMapper;
import com.shopping.model.AttachImageVO;
import com.shopping.model.Criteria;
import com.shopping.model.ProductVO;
import com.shopping.model.SelectDTO;

@Service
public class ProductServiceImpl implements ProductService{

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public List<ProductVO> getGoodsList(Criteria cri) {
		
		String type = cri.getType();
		String[] typeArr = type.split("");
		String[] productArr = productMapper.getProductNameList(cri.getKeyword());
		
		
		if(type.equals("A")) {
			if(productArr.length==0) {
				return new ArrayList();
			}
		}
		
		for(String t : typeArr) {
			if(t.equals("A")) {
				cri.setProductArr(productArr);
			}
		}
		List<ProductVO> list = productMapper.getGoodsList(cri);
		
		list.forEach(product -> {
			
			int productId = product.getProductId();
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(productId);
			
			product.setImageList(imageList);
			
		});
		
		
		return list;
	}

	@Override
	public int goodsGetTotal(Criteria cri) {
		// TODO Auto-generated method stub
		return productMapper.goodsGetTotal(cri);
	}

	@Override
	public ProductVO getGoodsInfo(int productId) {
		// TODO Auto-generated method stub
		ProductVO goodsInfo = productMapper.getGoodsInfo(productId);
		goodsInfo.setImageList(adminMapper.getAttachInfo(productId));
		
		return goodsInfo;
	}

	@Override
	public List<SelectDTO> likeSelect() {
		List<SelectDTO> ls = productMapper.likeSelect();
		
			for(SelectDTO dto : ls) {
				/* 이미지 정보 얻기 */
				int bookId = dto.getProductId();
				
				List<AttachImageVO> imageList = attachMapper.getAttachList(bookId);
				
				dto.setImageList(imageList);
			}
	
		return ls;
	}


	
	
}
