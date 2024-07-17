package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.CertificateVO;

public interface CertificateMapper {

	public int certificateTotal(Map<String, Object> map);

	public List<CertificateVO> certificateVOList(Map<String, Object> map);

	public int cerCreateAjax(CertificateVO certificateVO);

	public int cerDeleteAjax(Map<String, Object> map);

	public int cerUpdateAjax(Map<String, Object> map);

	public int certificateCount(String stNo);

}
