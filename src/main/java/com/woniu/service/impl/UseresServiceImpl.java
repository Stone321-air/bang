package com.woniu.service.impl;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.woniu.mapper.UseresMapper;
import com.woniu.pojo.Useres;
import com.woniu.pojo.UseresExample;
import com.woniu.pojo.UseresExample.Criteria;
import com.woniu.service.UseresService;
@Service
public class UseresServiceImpl implements UseresService {
	@Autowired
	UseresMapper useresMapper;
	@Override
	public Useres login(String uaccount , String password) {
		// TODO Auto-generated method stub
	
		Useres user = new Useres();
		boolean flag = false;
		List<Useres> useres = useresMapper.selectByExample(null);
		for(Useres u : useres) {
			if(uaccount.equals(u.getUaccount()) && password.equals(u.getUpwd())){
				user = u;
				flag = true;
				break;
			}
		}
		if(flag) {
			return user;
		}else {
			return null;
		}
	}
	@Override
	public List<Useres> findByPage(UseresExample example) {
		// TODO Auto-generated method stub
		return useresMapper.selectByExample(example);
	}
	@Override
	public void save(Useres user) {
		// TODO Auto-generated method stub
		useresMapper.insertSelective(user);
	}
	@Override
	public void delChoice(Integer[] uids) {
		// TODO Auto-generated method stub
		UseresExample example = new UseresExample();
		Criteria criteria = example.createCriteria();
		List<Integer> uidList = Arrays.asList(uids);
		criteria.andUidIn(uidList);
		useresMapper.deleteByExample(example);
	}

}
