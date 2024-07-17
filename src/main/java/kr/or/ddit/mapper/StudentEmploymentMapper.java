package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.RecruitmentVO;
import kr.or.ddit.vo.VolunteerVO;

public interface StudentEmploymentMapper {

	public List<VolunteerVO>volunteerList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);
	
	public int volTotalTime(String stNo);

	public int insertVolunteer(VolunteerVO volunteerVO);

	public String mainNumber();

	public VolunteerVO volDetail(Map<String, Object> map);
	/**
	 * volunteer update , multiple 없는 경우
	 * @param volunteerVO
	 * @return
	 */
	public int volUpdateAjax(VolunteerVO volunteerVO);
	
	/**
	 * 첨부파일 삭제 메소드
	 * @param volunteerVO
	 * @return
	 */
	public int volAttachFileDelAjax(VolunteerVO volunteerVO);

	public int volAttachDetDelAjax(VolunteerVO volunteerVO);


	
	

}
