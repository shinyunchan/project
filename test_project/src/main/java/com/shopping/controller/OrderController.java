package com.shopping.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.shopping.model.OrderDTO;
import com.shopping.model.OrderPageDTO;
import com.shopping.service.MemberService;
import com.shopping.service.OrderService;


@Controller
public class OrderController {
	
		@Autowired
		private OrderService orderService;
		
		@Autowired
		private MemberService memberService;
		
		@GetMapping("/order/{memberId}")
		public String orderPgaeGET(@PathVariable("memberId") String memberId, OrderPageDTO opd, Model model) {
			
			model.addAttribute("orderList", orderService.getGoodsInfo(opd.getOrders()));
			model.addAttribute("memberInfo", memberService.getMemberInfo(memberId));
			
			return "/order";
		}
		@PostMapping("/order")
		public String orderPagePost(OrderDTO od, HttpServletRequest request) {
			
			System.out.println(od);	
			
			orderService.order(od);
			
			return "redirect:/main";
		}
}
