package com.shopping.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.shopping.mapper.AttachMapper;
import com.shopping.mapper.CartMapper;
import com.shopping.mapper.MemberMapper;
import com.shopping.mapper.OrderMapper;
import com.shopping.mapper.ProductMapper;
import com.shopping.model.AttachImageVO;
import com.shopping.model.CartDTO;
import com.shopping.model.MemberVO;
import com.shopping.model.OrderDTO;
import com.shopping.model.OrderItemDTO;
import com.shopping.model.OrderPageItemDTO;
import com.shopping.model.ProductVO;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderMapper orderMapper;
	
	@Autowired
	private AttachMapper attachMapper;
	
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private ProductMapper productMapper;
	
	
	@Override
	public List<OrderPageItemDTO> getGoodsInfo(List<OrderPageItemDTO> orders) {
		
		List<OrderPageItemDTO> result = new ArrayList<OrderPageItemDTO>();		
		
		for(OrderPageItemDTO ord : orders) {
			
			OrderPageItemDTO goodsInfo = orderMapper.getGoodsInfo(ord.getProductId());			

			goodsInfo.setAmount(ord.getAmount());	
			
			goodsInfo.initTotal();	
			
			List<AttachImageVO> imageList = attachMapper.getAttachList(goodsInfo.getProductId());
			
			goodsInfo.setImageList(imageList);
			
			result.add(goodsInfo);			
		}		
		
		return result;
	}
	
	@Override
	@Transactional
	public void order(OrderDTO ord) {
		/* 사용할 데이터가져오기 */
		/* 회원 정보 */
		MemberVO member = memberMapper.getMemberInfo(ord.getMemberId());
		/* 주문 정보 */
		List<OrderItemDTO> ords = new ArrayList<>();
		for(OrderItemDTO oit : ord.getOrders()) {
			OrderItemDTO orderItem = orderMapper.getOrderInfo(oit.getProductId());
			// 수량 셋팅
			orderItem.setAmount(oit.getAmount());
			// 기본정보 셋팅
			orderItem.initTotal();
			//List객체 추가
			ords.add(orderItem);
		}
		/* OrderDTO 셋팅 */
		ord.setOrders(ords);
		ord.getOrderPriceInfo();
		
	/*DB 주문,주문상품(,배송정보) 넣기*/
		
		/* orderId만들기 및 OrderDTO객체 orderId에 저장 */
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat("_yyyyMMddmm");
		String orderId = member.getMemberId() + format.format(date);
		ord.setOrderId(orderId);
		
		/* db넣기 */
		orderMapper.enrollOrder(ord);		//vam_order 등록
		for(OrderItemDTO oit : ord.getOrders()) {		//vam_orderItem 등록
			oit.setOrderId(orderId);
			orderMapper.enrollOrderItem(oit);			
		}

	/* 비용 포인트 변동 적용 */
		
		/* 비용 차감 & 변동 돈(money) Member객체 적용 */
		int calMoney = member.getMoney();
		calMoney -= ord.getOrderFinalPrice();
		member.setMoney(calMoney);
		
		/* 변동 돈, 포인트 DB 적용 */
		orderMapper.deductMoney(member);
		
	/* 재고 변동 적용 */
		for(OrderItemDTO oit : ord.getOrders()) {
			/* 변동 재고 값 구하기 */
			ProductVO product = productMapper.getGoodsInfo(oit.getProductId());
			product.setProductStock(product.getProductStock() - oit.getAmount());
			/* 변동 값 DB 적용 */
			orderMapper.deductStock(product);
		}			
		
	/* 장바구니 제거 */
		for(OrderItemDTO oit : ord.getOrders()) {
			CartDTO dto = new CartDTO();
			dto.setMemberId(ord.getMemberId());
			dto.setProductId(oit.getProductId());
			
			orderMapper.deleteOrderCart(dto);
		}
	}
	
}























