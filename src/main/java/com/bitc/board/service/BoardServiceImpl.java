package com.bitc.board.service;

import org.springframework.stereotype.Service;

import com.bitc.board.dao.BoardDAO;
import com.bitc.comment.vo.FreeBoardCommentVO;
import com.bitc.freeboard.vo.FreeBoardVO;
import com.bitc.partyBoard.vo.PartyBoardVO;
import com.bitc.partyBoard.vo.PartyCommentVO;

import lombok.RequiredArgsConstructor;

@Service("bs")
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {
	private final BoardDAO dao;

	@Override
	public FreeBoardVO freeBoard(int bno) throws Exception {
		return dao.freeBoard(bno);
	}

	@Override
	public FreeBoardCommentVO freeBoardComment(int cno) throws Exception {
		return dao.freeBoardComment(cno);
	}

	@Override
	public FreeBoardVO originalBoard(int cno) throws Exception {
		return dao.originalBoard(cno);
	}

	@Override
	public PartyCommentVO partyComment(int cno) throws Exception {
		return dao.partyComment(cno);
	}

	@Override
	public PartyBoardVO partyBoard(int bno) throws Exception {
		return dao.partyBoard(bno);
	}

	@Override
	public PartyBoardVO originalPartyBoard(int cno) throws Exception {
		return dao.originalPartyBoard(cno);
	}

	@Override
	public void blindBoard(int bno) throws Exception {
		dao.blindBoard(bno);
	}
	
	@Override
	public void blindComment(int cno) throws Exception {
		dao.blindComment(cno);
		
	}

	@Override
	public void blindPartyBoard(int bno) throws Exception {
		dao.blindPartyBoard(bno);
	}

	@Override
	public void blindPartyComment(int cno) throws Exception {
		dao.blindPartyComment(cno);
	}
	
	
}
