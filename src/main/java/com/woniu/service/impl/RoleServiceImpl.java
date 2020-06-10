package com.woniu.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woniu.mapper.RolesMapper;
import com.woniu.mapper.UserroleMapper;
import com.woniu.pojo.Roles;
import com.woniu.pojo.RolesExample;
import com.woniu.pojo.RolesExample.Criteria;
import com.woniu.pojo.Userrole;
import com.woniu.pojo.UserroleExample;
import com.woniu.service.RoleService;
@Service
public class RoleServiceImpl implements RoleService {
	@Autowired
	RolesMapper roleMapper;
	@Autowired
	UserroleMapper userroleMapper;
	@Override
	public List<Roles> findByPage(RolesExample example) {
		// TODO Auto-generated method stub
		return roleMapper.selectByExample(example);
	}

	@Override
	public List<Roles> findAssignRole(Integer uid) {
		// TODO Auto-generated method stub
		//根据uid查询,该用户的所有角色
		UserroleExample example1 = new UserroleExample();
		com.woniu.pojo.UserroleExample.Criteria criteria1 = example1.createCriteria();
		criteria1.andUidEqualTo(uid);
		//用户角色关联集合
		List<Userrole> userroleList = userroleMapper.selectByExample(example1);
		//声明角色id集合
		List<Integer> rids = new ArrayList<Integer>();
		//声明角色集合
		List<Roles> roleList = new ArrayList<Roles>();
		
		//将用户角色关联集合中的rid加入到角色id集合rids中
		for(Userrole userrole : userroleList) {
			rids.add(userrole.getRid());
		}
		
		//声明查询条件
		RolesExample example2 = new RolesExample();
		Criteria criteria2 = example2.createCriteria();
		
		//若rids不为空即size为0，加入条件，否则不做处理
		
		if(rids.size()>0) {
			criteria2.andRidIn(rids);
			roleList = roleMapper.selectByExample(example2);
		}
		
		return roleList;
	}

	@Override
	public List<Roles> findUnAssignRole(Integer uid) {
		// TODO Auto-generated method stub
		//根据uid查询,该用户的所有角色
		UserroleExample example1 = new UserroleExample();
		com.woniu.pojo.UserroleExample.Criteria criteria1 = example1.createCriteria();
		criteria1.andUidEqualTo(uid);
		List<Userrole> userroleList = userroleMapper.selectByExample(example1);
		List<Integer> rids = new ArrayList<Integer>();
		List<Roles> roleList = new ArrayList<Roles>();
		for(Userrole userrole : userroleList) {
			rids.add(userrole.getRid());
		}
		
		
		RolesExample example2 = new RolesExample();
		Criteria criteria = example2.createCriteria();
		//若rids不为空即size为0，加入条件，否则不做处理，条件为rid不在rids中
		if(rids.size()>0) {
			criteria.andRidNotIn(rids);
			roleList = roleMapper.selectByExample(example2);
		}else {
			roleList = roleMapper.selectByExample(example2);
		}
		
		return roleList;
		
	}
	
}
