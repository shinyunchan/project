package com.shopping.model;

import java.util.Arrays;

public class Criteria {
	
	private int pageNum;
	private int amount;
	private int skip;
	private String type;
	private String keyword;
	private String []productArr;
	
	public String[] getProductArr() {
		return productArr;
	}

	public void setProductArr(String[] productArr) {
		this.productArr = productArr;
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
		this.skip = (pageNum -1) * amount;
	}
	
	public Criteria() {
		this(1,10);
	}
	
	/* 검색 타입 데이터 배열 변환 */
	public String[] getTypeArr() {
        return type == null? new String[] {}:type.split("");
    }
	
	
	public int getSkip() {
		return skip;
	}

	public void setSkip(int skip) {
		this.skip = skip;
	}

	public int getPageNum() {
		return pageNum;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "Criteria [pageNum=" + pageNum + ", amount=" + amount + ", skip=" + skip + ", type=" + type
				+ ", keyword=" + keyword + ", productArr=" + Arrays.toString(productArr) + "]";
	}


	
	
	
	
}
