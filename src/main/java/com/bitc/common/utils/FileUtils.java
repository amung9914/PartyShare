package com.bitc.common.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.nio.charset.Charset;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.springframework.http.ContentDisposition;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;

/**
 * 파일 요청에 대한 처리를 할 class
 *	upload, download, delete
 */
public class FileUtils {
	// 업로드 위치와 파일 정보 문자열로 반환
		public static String uploadThumbnailImage(String realPath, MultipartFile file) throws Exception{
			
			String uploadFileName = ""; 
			
			// 동일 디렉토리에 동일한 이름의 파일 중복을 최소화
			UUID uid = UUID.randomUUID();
			String originalName = file.getOriginalFilename();
			String savedName = uid.toString().replace("-", "");
			
			savedName += "_"+(originalName.replace("_", " "));
			System.out.println(savedName);
			
			// URL encoding으로 변환된 파일 이름일 경우 공백을 + 로 치환하여 전달되기 때문에 
			// + 기호를 공백으로 치환
			savedName = savedName.replace("+", " ");
			
			// 해당되는 파일이 업로드 되는 날짜를 기준으로 디렉토리 생성하여 저장
			String datePath = calcPath(realPath);
			File f = new File(realPath+datePath, savedName);
			file.transferTo(f);
			
			// 원본파일 업로드 완료
			
			// 원본 파일이 이미지인지 일반파일인지 확인
			// 업로드 된 파일의 확장자
			// JPG, JPEG, PNG, GIF - 제외한 나머지 이미지들은 용량이 너무 큼 업로드 안시켜줌
			String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
				uploadFileName = makeThumbnail(realPath, datePath, savedName, formatName);
			return uploadFileName;
		}
		
		public static String uploadOriginalImage(String realPath, MultipartFile file) throws Exception{
			String uploadFileName = null;
			
			UUID uid = UUID.randomUUID();
			String originalName = file.getOriginalFilename();
			String savedName = uid.toString().replace("-", "");
			
			savedName += "_"+(originalName.replace("_", " "));
			System.out.println(savedName);
			
			savedName = savedName.replace("+", " ");
			
			String datePath = calcPath(realPath);
			File f = new File(realPath+datePath, savedName);
			file.transferTo(f);
			
			String formatName = originalName.substring(originalName.lastIndexOf(".")+1);
			System.out.println(formatName);
			
			uploadFileName = makePathName(datePath, savedName);
			
			return uploadFileName;
		}

	// 해당되는 위치에 현재날짜 년원일 디렉토리 생성 메소드
	public static String calcPath(String realPath) {
		// 배포된 서버 환경이 윈도우면 \yyyy\mm\dd
		// 리눅스는 /yyyy/mm/dd
		String pattern = File.separator+"yyyy"+File.separator+"MM"+File.separator+"dd";
		LocalDate date = LocalDate.now();
		// 문자열로 반환
		String datePath = date.format(
				DateTimeFormatter.ofPattern(pattern)
		);
		File file = new File(realPath,datePath);
		if(!file.exists()) {
			file.mkdirs();
		}
		System.out.println(datePath);
		return datePath;
	}
	
	// URL 경로로 변경하여 문자열 path 반환
	private static String makePathName(String datePath,String savedName) {
		// /yyyy/MM/dd/savedName
		String fileName = datePath+File.separator+savedName;
		fileName = fileName.replace(File.separatorChar, '/'); // 운영체제 구분자를 url요청경로 구분자'/'로 변경
		return fileName;
	}
	
	// 썸네일 생성하고 썸네일 정보 전달
	private static String makeThumbnail(
			String realPath, String datePath, String savedName, String ext) throws IOException {
		String name = "";
		//원본 이미지 정보
		File file = new File(realPath+datePath,savedName);
		// ImageScalr 는 BufferedImage 타입으로 이미지를 제어
		// ImageIO javax package에 ImageIO class는
		// Image 타입의 파일을 쉽게 읽고 쓸 수 있도록 read, write method를 제공하는 class
		BufferedImage image = ImageIO.read(file);
		
		// scalr 객체를 이용해서 원본이미지를 복제한 Thumbnail 이미지 생성 
		BufferedImage sourceImage = Scalr.resize(
										image,						//원본이미지
										Scalr.Method.AUTOMATIC,		// 고정크기에 따른 상대크기
										Scalr.Mode.FIT_TO_HEIGHT, 	// 고정위치 (높이에 맞게 너비 조절)
										100 						// 크기
									);
		String thumbnailImage = realPath+datePath+File.separator+"s_"+savedName;
		// ImageIO.write(출력할 이미지 데이터, 확장자, 출력위치)
		ImageIO.write(sourceImage, ext, new File(thumbnailImage));
		//readPath길이만큼 이동한 다음 그 뒤부터 자름, 그리고 구분자 URL 형식으로 바꿈
		name = thumbnailImage.substring(realPath.length()).replace(File.separatorChar,'/'); 
		System.out.println(name);
		return name;
	}
	
	// 지정된 경로의 파일 이름을 가지고 전달할 파일 정보를 byte[]로 반환
	public static byte[] getBytes(
			String realPath,
			String fileName
			) throws Exception{
		File file = new File(realPath,fileName); // file정보를 FIle객체에 넣음
		InputStream is = new FileInputStream(file);
		/*
		long length = file.length(); // 아래 방법도 사용 가능
		length = is.available(); // available : 아직 읽지않은 파일의 크기 알려줌
		byte[] bytes = new byte[(int)length];
		for(int i=0; i < bytes.length; i++) {
			bytes[i] = (byte)is.read(); // 기본타입 int라서 타입 변환필요
		}
		is.close();
		return bytes;
		*/
		
		byte[] bytes = IOUtils.toByteArray(is); //한줄로 끝
		try {
			if(is != null) {
				is.close();
			}
		} catch (IOException e) {}
		return bytes; 
	}
	
	// 전달된 파일 정보로 브라우저가 파일 종류에 상관없이
	// 다운로드를 받아야될 파일이라고 인식할 수 있도록 headers 정보 추가
	public static HttpHeaders getOctetHeaders(String fileName) throws UnsupportedEncodingException {
		HttpHeaders headers = new HttpHeaders();
		// application/octet-stream
		// octet 8비트 / 1byte 단위의 이진 데이터가 전송됨을 의미함.
		// 해석할 수 없는 파일로 브라우저가 해석하여 다운로드 하게 됨.
		// 3가지 방법이 있다.
		// headers.setContentType(new MediaType("application","octet-stream"));
		// headers.add("Content-type", "application/octet-stream");
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);

		fileName = fileName.substring(fileName.lastIndexOf("_")+1);
		
		// Http 응답에서 Content-Disposition(배치 조치) 응답 헤더는
		// 컨텐츠가 브라우저에서 인라인으로 표시되어야 되는지 
		// 웹페이지의 일부인지 또는 첨부파일인지 여부를 타나태는 헤더
		// attachment : 첨부물 / fileName : 어떤 이름으로 다운받아야될지 지정(쌍따옴표로 감싸주기)
		/*
		fileName = new String(fileName.getBytes("UTF-8"),"ISO-8859-1");
		headers.add("content-disposition", "attachment;fileName=\""+fileName+"\"");
		*/
		
		// 아래와 같이 편하게 사용 가능
		ContentDisposition cd = ContentDisposition.attachment()
				.filename(fileName,Charset.forName("UTF-8"))
				.build();
		headers.setContentDisposition(cd);
		return headers;
	}
	
	public static HttpHeaders getHeaders(String fileName) throws UnsupportedEncodingException {
		HttpHeaders headers = new HttpHeaders();
		
		String ext = fileName.substring(fileName.lastIndexOf(".")+1); 
		MediaType m = MediaUtils.getMediaType(ext);
		
		if(m != null) {
			headers.setContentType(m);
		}else {
			headers = getOctetHeaders(fileName);
		}
		return headers;

	}
	
	public static boolean deleteFile(
			String realPath,
			String fileName
			) throws Exception{
		boolean isDeleted = false;
		// /2023/08/10/s_dcd48a64bd03473c93283c9159a620a7_dog.jpeg
		String ext = fileName.substring(fileName.lastIndexOf(".")+1);
		// url경로에서 운영체제 경로로 변경
		fileName = fileName.replace('/', File.separatorChar);
		
		File file = new File(realPath,fileName);
		isDeleted = file.delete(); // 해당되는 위치에 있는 파일 삭제
		
		// 썸네일 정상삭제 및 이미지 파일이라면
		if(isDeleted && MediaUtils.getMediaType(ext) != null) {
			// s_
			fileName = fileName.replace("s_", "");
			isDeleted = new File(realPath,fileName).delete();
		}
		
		return isDeleted;
	}

}
