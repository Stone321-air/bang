package com.woniu.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woniu.mapper.UserroleMapper;
import com.woniu.pojo.UserroleExample;
import com.woniu.pojo.UserroleExample.Criteria;
import com.woniu.service.UserroleService;
@Service
public class UserroleServiceImpl implements UserroleService {
	@Autowired
	UserroleMapper userroleMapper;
	@Override
	public void saveSome(Integer uid, Integer[] giveRids) {
		// TODO Auto-generated method stub
		Map<String,Object> paramterMap = new HashMap<>();
		paramterMap.put("uid", uid);
		paramterMap.put("giveRids", giveRids);
		userroleMapper.saveSome(paramterMap);
	}

	@Override
	public void deleteSome(Integer uid, Integer[] takeRids) {
		// TODO Auto-generated method stub
		UserroleExample example = new UserroleExample();
		Criteria criteria = example.createCriteria();
		criteria.andUidEqualTo(uid);
		List<Integer> list = Arrays.asList(takeRids);
		criteria.andRidIn(list);
		userroleMapper.deleteByExample(example);
	}

}
