package com.woniu.service;

import java.util.List;

import com.woniu.pojo.Roles;
import com.woniu.pojo.RolesExample;

public interface RoleService {
	
	List<Roles> findByPage(RolesExample example);
	
	List<Roles> findAssignRole(Integer uid);
	
	List<Roles> findUnAssignRole(Integer uid);

}
