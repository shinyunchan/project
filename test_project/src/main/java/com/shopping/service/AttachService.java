package com.shopping.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.shopping.model.AttachImageVO;

public interface AttachService {
	
	
	public List<AttachImageVO> getAttachList(int productId);
	
	public String getMessage(HttpServletRequest request, String msg, String url);
	
}
