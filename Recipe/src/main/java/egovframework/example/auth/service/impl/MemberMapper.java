package egovframework.example.auth.service.impl;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import egovframework.example.auth.service.MemberVO;

@Mapper
public interface MemberMapper {
	public MemberVO authenticateMember(MemberVO memberVO);
	public void register(MemberVO memberVO);
	public String findId(MemberVO memberVO);
	public MemberVO findPassword(MemberVO memberVO);
	public void updatePassword(MemberVO memberVO);

}
