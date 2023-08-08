package com.bitc.partyshare.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bitc.partyshare.dao.MapDAO;
import com.bitc.partyshare.vo.MapVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MapServiceImpl implements MapService {

	private final MapDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SECCESS":"FAILED";
	}
	
	@Override
	public List<MapVO> mapList() throws Exception {
		return dao.mapList();
	}

	@Override
	public String addLocation(MapVO vo) throws Exception {
		return getResult(dao.insert(vo));
	}

	@Override
	public String updateLocation(MapVO vo) throws Exception {
		return getResult(dao.update(vo));
	}

	@Override
	public String deleteLocation(int pnum) throws Exception {
		return getResult(dao.delete(pnum));
	}

	@Override
	public Map<String, String> getNameTag(int pnum) {
		return dao.nameTagList(pnum);
	}


}
