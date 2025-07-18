package egovframework.example.auth.service.impl;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.example.auth.service.MemberService;
import egovframework.example.auth.service.MemberVO;

@Service
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService {
	@Autowired
	MemberMapper memberMapper;

	@Override
    public MemberVO authenticateMember(MemberVO loginVO) throws Exception {
		// TODO Auto-generated method stub
		MemberVO memberVO = memberMapper.authenticate(loginVO);

		
		if(memberVO==null) throw processException("errors.login");
		if(memberVO!=null) {
			boolean isMatchedPassword = BCrypt.checkpw(loginVO.getPassword(),memberVO.getPassword());
			if(isMatchedPassword==false) throw processException("errors.login");
		}
		return memberVO;
	}


	@Override
	public void register(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		MemberVO cmemberVO=memberMapper.authenticate(memberVO);    // 중복가입 확인
		if(cmemberVO != null) throw processException("errors.register"); //     중복 존재 -> 예외처리
		String hashedPassword = BCrypt.hashpw(memberVO.getPassword(),  // 암호 해싱처리 
				BCrypt.gensalt());     
        memberVO.setPassword(hashedPassword);   //암호저장
        memberMapper.register(memberVO);    //db저장
	}

	@Override
	public boolean isUserIdExists(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		int count = memberMapper.isUserIdExists(memberVO);
		return count > 0;
	}


	@Override
	public boolean isNicknameExists(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		int count = memberMapper.isNicknameExists(memberVO);
		return count > 0;
	}


	@Override
	public String findId(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		return memberMapper.findId(memberVO);
	}

	@Override
	public MemberVO findPassword(MemberVO memberVO)throws Exception {

		return memberMapper.findPassword(memberVO);
	}
	@Override
	public void updatePassword(MemberVO memberVO) throws Exception {
		// TODO Auto-generated method stub
		
		
		
		String rawPassword = memberVO.getPassword(); // 새 비밀번호
        String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());
        memberVO.setPassword(hashedPassword);
        
        // DB 업데이트
        memberMapper.updatePassword(memberVO);

	}

	
}
