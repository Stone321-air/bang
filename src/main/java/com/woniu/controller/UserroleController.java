package com.woniu.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.woniu.service.UserroleService;

@SuppressWarnings("finally")
@Controller
@RequestMapping("userrole")
public class UserroleController {
	@Autowired
	UserroleService userroleService;
	
	
	@RequestMapping("assignDo")
	@ResponseBody
	public Map<String,Object> assignDo(Integer uid , Integer[] giveRids){
		Map<String,Object> map = new HashMap<>();
		
		for (Integer integer : giveRids) {
			System.out.println("integer："+integer);
		}
		try {
			
			userroleService.saveSome(uid,giveRids);
			map.put("msg", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	
	@RequestMapping("deleteDo")
	@ResponseBody
	public Map<String,Object> deleteDo(Integer uid , Integer[] takeRids){
		Map<String,Object> map = new HashMap<>();
		
		
		try {
			userroleService.deleteSome(uid, takeRids);
			map.put("msg", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}

}
