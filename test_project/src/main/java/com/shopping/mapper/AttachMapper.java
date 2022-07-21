package com.shopping.mapper;

import java.util.List;

import com.shopping.model.AttachImageVO;

public interface AttachMapper {

	
	public List<AttachImageVO> getAttachList(int productId);
	
	
}
