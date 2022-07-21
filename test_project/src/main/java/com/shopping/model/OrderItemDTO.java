package com.shopping.model;

public class OrderItemDTO {
	/* 주문 번호 */
	private String orderId;
	
	/* 상품 번호 */
    private int productId;
    
	/* 주문 수량 */
    private int amount;
    
	/* vam_orderItem 기본키 */
    private int orderItemId;
    
	/* 상품 한 개 가격 */
    private int productPrice;
    
	/* DB테이블 존재 하지 않는 데이터 */
    
	/* 총 가격(할인 적용된 가격 * 주문 수량) */
    private int totalPrice;

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public int getAmount() {
		return amount;
	}

	public void setAmount(int amount) {
		this.amount = amount;
	}

	public int getOrderItemId() {
		return orderItemId;
	}

	public void setOrderItemId(int orderItemId) {
		this.orderItemId = orderItemId;
	}

	public int getProductPrice() {
		return productPrice;
	}

	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	@Override
	public String toString() {
		return "OrderItemDTO [orderId=" + orderId + ", productId=" + productId + ", amount=" + amount + ", orderItemId="
				+ orderItemId + ", productPrice=" + productPrice + ", totalPrice=" + totalPrice + "]";
	}
	public void initTotal() {
		this.totalPrice = this.productPrice*this.amount;
	}
}
