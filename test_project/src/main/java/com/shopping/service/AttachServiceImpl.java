package com.shopping.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.shopping.mapper.AdminMapper;
import com.shopping.mapper.AttachMapper;
import com.shopping.model.AttachImageVO;

@Service
public class AttachServiceImpl implements AttachService{
	
	
	@Autowired
	private AttachMapper attachMapper;
	
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public List<AttachImageVO> getAttachList(int productId) {
		// TODO Auto-generated method stub
		return attachMapper.getAttachList(productId);
	}

	@Override
	public String getMessage(HttpServletRequest request, String msg, String url) {
		String message = null;
		String path = request.getContextPath();
		message = "<script>alert('" + msg + "');";
		message += "location.href='" + path + url + "';</script>";
		return message;
	}
	
}
