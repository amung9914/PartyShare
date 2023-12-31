package com.bitc.notice.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.bitc.member.vo.MemberVO;
import com.bitc.notice.dao.NoticeDAO;
import com.bitc.notice.vo.NoticeVO;

import lombok.RequiredArgsConstructor;

@Service("ns")
@RequiredArgsConstructor
public class NoticeServiceImpl implements NoticeService {

	private final NoticeDAO dao;
	
	@Override
	public List<NoticeVO> noReadNotice() throws Exception{
		return dao.noReadList();
	}	//nsi

	@Override
	public void addNotice(NoticeVO vo) throws Exception {
		dao.addNotice(vo);
	}	//nsi

	@Override
	public List<NoticeVO> allNotice() throws Exception {
		return dao.allNotice();
	}	//nsi
	
	@Override
	public void readPost(int noticeNum, String mid) throws Exception {
		dao.readPost(noticeNum, mid);
	}	//nsi
	
	@Override
	public List<NoticeVO> viewNotice(MemberVO vo) throws Exception {
		return null;
	}	//nsi

	@Override
	public String deleteNotice() throws Exception{
		return null;
	}	//nsi

	

	@Override
	public List<NoticeVO> myNotice(String mid) throws Exception {
	
		return dao.myNotcie(mid);
	}	//nsi
	
	@Override
	public void sendPost(List<MemberVO> list, NoticeVO notice) throws Exception {
		dao.sendPost(list, notice);
	}	//nsi
	

	@Override
	public List<MemberVO> currentMember() throws Exception {
		return dao.currentMember();
	}	//nsi

	@Override
	public void blackPost(String mId, NoticeVO vo) throws Exception {
		dao.BlackPost(mId, vo);
		
	}

	@Override
	public List<NoticeVO> bonPostList(String mid) throws Exception {
		return dao.bonPostList(mid);
	}

	@Override
	public void deletePost(int no, String mid) throws Exception {
		dao.deletePost(no, mid);
	}	//nsi
	
}
