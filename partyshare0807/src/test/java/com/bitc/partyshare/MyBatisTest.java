package com.bitc.partyshare;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.partyshare.dao.MapDAO;
import com.bitc.partyshare.vo.MapVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"classpath:/spring/root-context.xml"}
)
public class MyBatisTest {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void test1SqlSessionFactory() {
		SqlSession session = sqlSessionFactory.openSession();
		System.out.println(session.getConnection());
	}

	@Autowired
	MapDAO dao;
	
	//@Test
	public void InsertMap()throws Exception{
		MapVO vo = new MapVO();
		vo.setLat("35.1724530764883");
		vo.setLng("129.183227515649");
		vo.setPnum(1);
		int result = dao.insert(vo);
		System.out.println("result : "+result);
	}
	
	//@Test
	public void mapList() throws Exception{
		List<MapVO> list = dao.mapList();
		System.out.println(list);
	}
	
	@Test
	public void nameTag() throws Exception{
		Map<String,String> list = dao.nameTagList(1);
		System.out.println(list);

	
	}
}
