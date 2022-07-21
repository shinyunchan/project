package com.shopping.mapper;

import com.shopping.model.CartDTO;
import com.shopping.model.MemberVO;
import com.shopping.model.OrderDTO;
import com.shopping.model.OrderItemDTO;
import com.shopping.model.OrderPageItemDTO;
import com.shopping.model.ProductVO;

public interface OrderMapper {
	/* 주문 상품 정보 */	
	public OrderPageItemDTO getGoodsInfo(int productId);
	/* 주문 상품 정보(주문 처리) */	
	public OrderItemDTO getOrderInfo(int productId);
	/* 주문 테이블 등록 */
	public int enrollOrder(OrderDTO ord);
	/* 주문 아이템 테이블 등록 */
	public int enrollOrderItem(OrderItemDTO orid);
	/* 주문 금액 차감 */
	public int deductMoney(MemberVO member);
	/* 주문 재고 차감 */
	public int deductStock(ProductVO product);
	/* 카트 제거(주문) */
	public int deleteOrderCart(CartDTO dto);
}
