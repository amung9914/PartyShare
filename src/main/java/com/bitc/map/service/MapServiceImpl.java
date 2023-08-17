package com.bitc.map.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.bitc.map.dao.MapDAO;
import com.bitc.map.vo.MapVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MapServiceImpl implements MapService {

	private final MapDAO dao;
	
	// 내부적으로 사용할 수 있도록 메소드추가
	private String getResult(int result) {
		return result == 1?"SUCCESS":"FAILED";
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
	public MapVO readLocation(int pnum) throws Exception {
		return dao.read(pnum);
	}

	

	@Override
	public String updateLocation(MapVO vo) throws Exception {
		System.out.println(vo);
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
