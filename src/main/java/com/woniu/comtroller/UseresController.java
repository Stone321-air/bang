package com.woniu.comtroller;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.woniu.pojo.Useres;
import com.woniu.pojo.UseresExample;
import com.woniu.service.UseresService;
@SuppressWarnings("finally")
@Controller
@RequestMapping("user")
public class UseresController {
	@Autowired
	UseresService useresService;
	
	@RequestMapping("login")
	@ResponseBody
	public Map<String,Object> login(String uaccount , String password , HttpSession session){
		Map<String,Object> map = new HashMap<>();
		boolean flag = false;
		try {
			if(useresService.login(uaccount, password) != null) {
				flag = true;
				session.setAttribute("loginUser", useresService.login(uaccount, password));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(flag) {
			map.put("msg","OK");
		}else {
			map.put("msg","NO");
		}
		
		return map;
		
	}
	
	@RequestMapping("exit")
	@ResponseBody
	public Map<String,Object> exit(HttpSession session){
		Map<String,Object> map = new HashMap<>();
		boolean flag = false;
		try {
			session.invalidate();
			flag = true;
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(flag) {
			map.put("msg","OK");
		}else {
			map.put("msg","NO");
		}
		return map;
	}
	
	@RequestMapping("list")
	@ResponseBody
	public Map<String,Object> list(@RequestParam(name="pageNum" , defaultValue = "1")Integer pageNum , @RequestParam(name="pageSize" , defaultValue = "3")Integer pageSize){
		PageHelper.startPage(pageNum, pageSize);
		Map<String,Object> map = new HashMap<>();
		
		try {
			UseresExample example = new UseresExample();
			List<Useres> useres = useresService.findByPage(example);
			PageInfo<Useres> pageInfo = new PageInfo<>(useres);
			map.put("msg", "OK");
			map.put("useres", useres);
			map.put("pageInfo", pageInfo);
		}catch(Exception e) {
			map.put("msg", "NO");
			e.printStackTrace();
		}
		
		
		return map;
	}
	
	
	@RequestMapping("save")
	@ResponseBody
	public Map<String,Object> save(Useres user){
		Map<String,Object> map = new HashMap<>();
		
		try {
			useresService.save(user);
			
			map.put("msg","OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	@RequestMapping("delChoice")
	@ResponseBody
	public Map<String,Object> delChoice(Integer[] uids){
		Map<String,Object> map = new HashMap<>();
		
		try {
			useresService.delChoice(uids);
			map.put("msg","OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	
	

}
