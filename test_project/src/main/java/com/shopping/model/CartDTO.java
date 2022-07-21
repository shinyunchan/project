package com.shopping.model;

import java.util.List;

public class CartDTO {

   private int cartId;
   private String memberId;
   private int productId;
   private String productName;
   private int productPrice;
   private int totalPrice;
   private int amount;
   private int point;
    private int totalPoint;
   
   private List<AttachImageVO> imageList;
   
   
   public int getCartId() {
      return cartId;
   }
   public void setCartId(int cartId) {
      this.cartId = cartId;
   }
   public String getMemberId() {
      return memberId;
   }
   public void setMemberId(String memberId) {
      this.memberId = memberId;
   }
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
   public int getAmount() {
      return amount;
   }
   public void setAmount(int amount) {
      this.amount = amount;
   }
   public void initTotal() {
      this.totalPrice = this.productPrice*this.amount;
      this.point = (int)(Math.floor(this.productPrice*0.05));
      this.totalPoint =this.point * this.amount;
   }
   
   public List<AttachImageVO> getImageList() {
      return imageList;
   }

   public void setImageList(List<AttachImageVO> imageList) {
      this.imageList = imageList;
   }
   
   public int getPoint() {
      return point;
   }
   public void setPoint(int point) {
      this.point = point;
   }
   public int getTotalPoint() {
      return totalPoint;
   }
   public void setTotalPoint(int totalPoint) {
      this.totalPoint = totalPoint;
   }
   @Override
   public String toString() {
      return "CartDTO [cartId=" + cartId + ", memberId=" + memberId + ", productId=" + productId + ", productName="
            + productName + ", productPrice=" + productPrice + ", totalPrice=" + totalPrice + ", amount=" + amount
            + ", point=" + point + ", totalPoint=" + totalPoint + ", imageList=" + imageList + "]";
   }
   
   
}