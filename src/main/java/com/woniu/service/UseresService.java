package com.woniu.service;




import java.util.List;

import com.woniu.pojo.Useres;
import com.woniu.pojo.UseresExample;

public interface UseresService {
	
	
	Useres login(String uaccount , String password);
	
	List<Useres> findByPage(UseresExample example);
	
	void save(Useres user);
	
	void delChoice(Integer[] uids);

}
