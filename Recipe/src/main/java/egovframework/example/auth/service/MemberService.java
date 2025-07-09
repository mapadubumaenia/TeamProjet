package egovframework.example.auth.service;

public interface MemberService {
	MemberVO authenticateMember(MemberVO loginVO) throws Exception; //로그인
	void register(MemberVO memberVO) throws Exception;
	String findId(MemberVO memberVO) throws Exception;
	MemberVO findPassword(MemberVO memberVO) throws Exception;
	void updatePassword(MemberVO memberVO) throws Exception;


}
