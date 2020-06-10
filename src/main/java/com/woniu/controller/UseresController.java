package com.woniu.controller;


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
import com.woniu.pojo.UseresExample.Criteria;
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
	public String list() {
		return "WEB-INF/user/user";
	}
	
	@RequestMapping("listDo")
	@ResponseBody
	public Map<String,Object> listDo(String example,@RequestParam(name="pageNum" , defaultValue = "1")Integer pageNum , @RequestParam(name="pageSize" , defaultValue = "3")Integer pageSize){
		PageHelper.startPage(pageNum, pageSize);
		Map<String,Object> map = new HashMap<>();
		
		try {
			UseresExample userExample = new UseresExample();
			userExample.setOrderByClause("uid desc");
			if(example == null || example.trim().equals("")) {
				
			}else {
				
				Criteria criteria1 = userExample.or();
				criteria1.andUaccountLike("%"+example+"%");
				
				Criteria criteria2 = userExample.or();
				criteria2.andUnameLike("%"+example+"%");
				
				Criteria criteria3 = userExample.or();
				criteria3.andUeamailLike("%"+example+"%");
				
				
				
			}
			List<Useres> useres = useresService.findByPage(userExample);
			
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
	public String save() {
		return "WEB-INF/user/add";
	}
	
	@RequestMapping("saveDo")
	@ResponseBody
	public Map<String,Object> saveDo(Useres user){
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
	@RequestMapping("delChoiceDo")
	@ResponseBody
	public Map<String,Object> delChoiceDo(Integer[] uids){
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
	
	@RequestMapping("deleteDo")
	@ResponseBody
	public Map<String,Object> deleteDo(Integer[] uid){
		Map<String,Object> map = new HashMap<>();
		
		try {
			useresService.delChoice(uid);
			map.put("msg","OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	
	@RequestMapping("edit")
	public String edit(){
		return "WEB-INF/user/edit";
	}
	
	@RequestMapping("initEditDo")
	@ResponseBody
	public Map<String,Object> initEditDo(Integer uid){
		Map<String,Object> map = new HashMap<>();
		try {
			UseresExample userExample = new UseresExample();
			Criteria criteria = userExample.createCriteria();
			criteria.andUidEqualTo(uid);
			List<Useres> list = useresService.findByPage(userExample);
			map.put("msg", "OK");
			map.put("user", list.get(0));
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	
	@RequestMapping("editDo")
	@ResponseBody
	public Map<String,Object> editDo(Useres user){
		Map<String,Object> map = new HashMap<>();
		try {
			UseresExample userExample = new UseresExample();
			Criteria criteria = userExample.createCriteria();
			useresService.update(user);
			map.put("msg", "OK");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
	}
	
	/**
	 * 跳转至角色分配页面
	 * @param user
	 * @return
	 */
	@RequestMapping("assignRole")
	public String assignRole(Useres user){
		return "WEB-INF/role/assignRole";
	}
	

}
