package com.woniu.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.woniu.pojo.Roles;
import com.woniu.pojo.RolesExample;
import com.woniu.pojo.RolesExample.Criteria;
import com.woniu.service.RoleService;

@SuppressWarnings("finally")
@Controller
@RequestMapping("role")
public class RoleController {
	@Autowired
	RoleService roleService;

	@RequestMapping("list")
	public String list() {

		return "WEB-INF/role/role";
	}

	@RequestMapping("listDo")
	@ResponseBody
	public Map<String,Object> listDo(@RequestParam(name="pageNum",defaultValue = "1")Integer pageNum , @RequestParam(name = "pageSize" , defaultValue = "3")Integer pageSize ,String example) {
		PageHelper.startPage(pageNum, pageSize);
		
		Map<String,Object> map = new HashMap<>();
		try {
			
			RolesExample roleExample = new RolesExample();
			
			
			if(example == null || example.trim().equals("")) {
				
			}else {
				Criteria criteria = roleExample.createCriteria();
				criteria.andRnameLike(example);
			}
			
			List<Roles> roleList = roleService.findByPage(roleExample);
			PageInfo<Roles> pageInfo = new PageInfo<Roles>(roleList);
			map.put("msg", "OK");
			map.put("pageInfo", pageInfo);
			map.put("roleList", roleList);
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			
			return map;
		}
	}
	
	@RequestMapping("assignRoleShow")
	@ResponseBody
	public Map<String,Object> assignRoleShow(Integer uid){
		Map<String,Object> map = new HashMap<>();
		
		try {
			List<Roles> assignRoleList = roleService.findAssignRole(uid);
			
			List<Roles> unAssignRoleList = roleService.findUnAssignRole(uid);
			map.put("msg", "OK");
			map.put("assignRoleList", assignRoleList);
			map.put("unAssignRoleList", unAssignRoleList);
		}catch(Exception e) {
			e.printStackTrace();
			map.put("msg", "NO");
		}finally {
			return map;
		}
		
		
		
	}
	
	

}
