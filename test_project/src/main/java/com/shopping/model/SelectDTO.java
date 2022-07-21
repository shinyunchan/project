package com.shopping.model;

import java.util.List;

public class SelectDTO {

	/* 상품 id */
	private int productId;
	
	/* 상품 이름 */
	private String productName;
	
	/* 상품 이미지 */
	private List<AttachImageVO> imageList;

	
	
	public int getProductId() {
		return productId;
	}

	public void setProductId(int productId) {
		this.productId = productId;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public List<AttachImageVO> getImageList() {
		return imageList;
	}

	public void setImageList(List<AttachImageVO> imageList) {
		this.imageList = imageList;
	}

	@Override
	public String toString() {
		return "SelectDTO [productId=" + productId + ", productName=" + productName + ", imageList=" + imageList + "]";
	}
	
}
