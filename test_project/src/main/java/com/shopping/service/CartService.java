package com.shopping.service;

import java.util.List;

import com.shopping.model.CartDTO;

public interface CartService {
   
   /* 장바구니 추가 */
   public int addCart(CartDTO cart);
   
   
   public List<CartDTO> getCartList(String memberId);
   
   
	public int modifyCount(CartDTO cart);
	
	/* 카트 삭제 */
	public int deleteCart(int cartId);



}
