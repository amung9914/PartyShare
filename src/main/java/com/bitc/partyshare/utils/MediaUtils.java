package com.bitc.partyshare.utils;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.MediaType;

/**
 * 확장자를 이용하여 
 * Image File type을 MediaType으로 구분할 객체
 */
public class MediaUtils {
	private static Map<String, MediaType> mediaMap;
	
	//메소드 등록될 때 바로 실행
	static {
		mediaMap = new HashMap<>();
		mediaMap.put("JPG", MediaType.IMAGE_JPEG);		// image/jpeg
		mediaMap.put("JPEG", MediaType.IMAGE_JPEG);		// image/jpeg
		mediaMap.put("GIF", MediaType.IMAGE_GIF);		// image/gif
		mediaMap.put("PNG", MediaType.IMAGE_PNG);		// image/png
	}
	
	/**
	 * @param - 업로드된 파일 확장자 명
	 * @return - key 값이 확장자랑 일치하는 MediaTpe 반환
	 */
	public static MediaType getMediaType(String ext) {
		return mediaMap.get(ext.toUpperCase()); //확장자 전달해서 null이 아니면 img (key값으로 map에서 찾음)
	}
}
