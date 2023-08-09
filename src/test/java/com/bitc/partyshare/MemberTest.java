package com.bitc.partyshare;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bitc.partyshare.dao.MemberDAO;
import com.bitc.partyshare.vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {"classpath:/spring/root-context.xml"}
)
public class MemberTest {

	@Autowired
	SqlSessionFactory sqlSessionFactory;
	
	@Test
	public void test1SqlSessionFactory() {
		SqlSession session = sqlSessionFactory.openSession();
		System.out.println(session.getConnection());
	}
	
	//@Test
	public void makeMember() {
		MemberVO vo = new MemberVO("myid","mypw");
		System.out.println(vo);
	}
	
	@Autowired
	MemberDAO dao;
	
	@Test
	public void login() {
		MemberVO vo = new MemberVO("admin","admin");
		MemberVO loginMember = null;
		try {
			loginMember = dao.login(vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println(loginMember);
	}
}
