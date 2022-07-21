package com.shopping.model;

import java.util.List;

public class OrderPageItemDTO {
    private int productId;
    private int amount;
    private String productName;
    private int productPrice;
    private int totalPrice;
    private List<AttachImageVO> imageList;
    
    
    
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

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
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

	public void initTotal() {
		this.totalPrice = this.productPrice*this.amount;
	}

	
	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "OrderPageItemDTO [productId=" + productId + ", amount=" + amount + ", productName=" + productName
				+ ", productPrice=" + productPrice + ", totalPrice=" + totalPrice + ", imageList=" + imageList + "]";
	}


}
