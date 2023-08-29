package com.bitc.map.controller;

import java.io.File;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitc.common.utils.FileUtils;
import com.bitc.map.service.MapService;
import com.bitc.map.vo.MapVO;

import lombok.RequiredArgsConstructor;

@Controller
@PropertySource("classpath:/prop/maria.properties")
@RequestMapping("/location/*")
@RequiredArgsConstructor
public class MapController {
	
	private final MapService ms;
	
	@Value("${kakao.key}")
	private String apiKey;
	
	// 이미지 파일 업로드
		private final String uploadPartyDir;
		private final ServletContext context;
		private String realPath;
		
		@PostConstruct
		public void initPath() {
			realPath = context.getRealPath(File.separator+uploadPartyDir);
			System.out.println(realPath);
			File file = new File(realPath);
			if(!file.exists()) {
				file.mkdirs();
			}
					
		}
	
	/**
	 * 사진출력
	 */
	@ResponseBody
	@GetMapping("printImg")
	   public ResponseEntity<byte[]> displayImg(String fileName) throws Exception{
	      return new ResponseEntity<>(
	            FileUtils.getBytes(realPath, fileName),
	            FileUtils.getHeaders(fileName),
	            HttpStatus.OK
	            );
	   }
	   
	// test용 지도 추가 
	@PostMapping("")
	@ResponseBody
	public String addLocation(MapVO map, Model model) {
		
		String result = null;
		try {
			result = ms.addLocation(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//주소등록페이지 연결
	@GetMapping("regist")
	public String registLoction(Model model) {
		return "map/registLocation";
	}
	
	//현재지도확인 페이지 연결
		@GetMapping("map")
		public String viewMap(Model model) {
			model.addAttribute("apiKey",apiKey);
			try {
				model.addAttribute("list", ms.mapList());
			} catch (Exception e) {
				System.out.println("list정보 불러오기 실패");
			}
			
			return "map/map";
		}

	
	// 마커클릭시 지도에 마커를 표시합니다.
	//location/{pnum}
	@ResponseBody
	@GetMapping("/{pnum}")
	public Map<String, String> nameTag(
			@PathVariable(name="pnum") int pnum ){
		Map<String, String> nameTag = ms.getNameTag(pnum);
		
		return nameTag; 
	}
}
