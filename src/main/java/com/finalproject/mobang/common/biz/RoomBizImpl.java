package com.finalproject.mobang.common.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.finalproject.mobang.agent.dto.Criteria;
import com.finalproject.mobang.common.dao.RoomDao;
import com.finalproject.mobang.common.dto.RoomDto;

@Service
public class RoomBizImpl implements RoomBiz {
	
	@Autowired
	private RoomDao dao;

	@Override
	public List<RoomDto> selectAgentList(Criteria cri) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int listCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public RoomDto selectOne(int no_rm) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insert(RoomDto dto) {
		return dao.insert(dto);
	}

	@Override
	public int update(RoomDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int no_rm) {
		return dao.delete(no_rm);
	}

}
