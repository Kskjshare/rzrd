package com.cloudrich.ereader.meeting.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.cloudrich.ereader.common.dao.PageHelper.Page;
import com.cloudrich.ereader.meeting.entity.MeetFileMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetGroupMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetProcessLogEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenMainEntity;
import com.cloudrich.ereader.meeting.entity.MeetRichenYitiEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenFileEntity;
import com.cloudrich.ereader.meeting.entity.MeetYichenMainEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubFileEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubGroupEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubPubtimeEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubRichenEntity;
import com.cloudrich.ereader.meetpub.entity.MeetPubYichenEntity;

public interface MeetingViewService {
    
	/**
	 * //根据会议类型获取当前会议信息
	 * @param mtype
	 * @return
	 */
	public MeetMainEntity selectCurMeeting(String mtype) ;
    
    /**
     * ///获取历史会议信息
     * @param mtype
     * @return
     */
    public List<MeetMainEntity> selectHisMeeting(String mtype) ;
    
    /**
     * 获取基本信息
     * @param meetid
     * @return
     */
    public MeetMainEntity selectMeetBasicByMeetId(int meetid);
    
    /**
     * 删除历史会议信息
     * @param meetid
     * @return
     */
    public int deletemeetLS(int meetid);
    
    
    /**
     * 获取基本信息
     * @param meetid
     * @return
     */
    public List<MeetMainEntity> selectAllMeetBasicByMtype(String mtype);
    
    /**
     * 议程和文件
     * @param meetid
     * @return
     */
    public List<MeetYichenMainEntity> selectAllYichenByMeetid(int meetid);
    
    /**
     * 获取议程信息
     * @param meetid
     * @return
     */
    public MeetYichenMainEntity selectYichenByYichenId(int yichenid);
    	
    
    
    public List<MeetFileMainEntity> selectAllFileByYichenid(int yichenid);
    
    /**
     * 获取日程信息
     * @param briefid
     * @return
     */
    public  List<MeetRichenMainEntity>  selectAllRichenByMeetid(int meetid);
    
    public List<MeetRichenYitiEntity>  selectAllYitiByRichenid(int richenid);
    
  /**
   * 获取文件管理中的文件列表
   * @param meetid
   * @return
   */
    public List<MeetFileMainEntity> selectALLMeetFileByMeetid(int meetid,String fileown,String filetype);
    
    /**
     * 获取会议文件并分页
     * @param map1
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page selectALLMeetFileByMeetid(final HashMap<String,Object> map1,int pageNo, int pageSize);
    
        
        /**
         * 获取分组
         * @param meetid
         * @param grpno
         * @return
         */
        public MeetGroupMainEntity selectGroupByMeetidAndGrpno(int meetid,String grpno);
        
        
        /**
         * 获取发布分组
         * @param meetid
         * @param grpno
         * @return
         */
        public List<MeetPubGroupEntity> selectPubGroupByMeetidAndGrpno(int meetid);
        
        
    /**
     * 根据id获取会议基本信息
     * @param briefid
     * @return
     */
    public MeetMainEntity selectEntityById(int briefid);
    public List<MeetMainEntity> selectAll();
    
    
   /**
    * 返回议程树
    * @param meetid
    * @return
    */
    public List<Map<String,Object>>  getMeetTreeYichen(int meetid);
    
    /**
     * 返回议程树
     * @param meetid
     * @param version
     * @return
     */  
    public List<Map<String,Object>>  getMeetTreeYichenClientByVersion(int meetid,int version);
    
    /**
     * 返回子议程树
     * @param yichenid
     * @return
     */
    public List<Map<String,Object>>  getMeetSubTreeYichen(int yichenid);
    
    /**
     * 返回日程树
     * @param meetid
     * @return
     */
    public List<Map<String,Object>>  getMeetTreeRichen(int meetid);
    
    
    /**
     * 根据code获取会议类型
     * @param code
     * @return
     */
    public String getMeetTypeByCode(String code);
		
		
    /**
     * 历史会议分页
     * @param type
     * @param pageNo
     * @param pageSize
     * @return
     */

	public Page selectHisMeeting(String type, int pageNo, int pageSize);
//	public Page deleteHisMeeting(String type, int pageNo, int pageSize);
  
	/**
	 * 客户端访问的议程树形
	 * @param meetid
	 * @return
	 */
	 public List<Map<String,Object>>  getMeetTreeYichenClient(int meetid);
	 
	 public List<Map<String,Object>>  getMeetTreeYichenClient(int meetid,int userid);
	 
	 
	 public List<Map<String,Object>>  getMeetSubTreeYichenClient(int yichenid,int meetid);
	 
	 public List<Map<String,Object>>  getMeetTreeRichenClient(int meetid); 
	 
	 public List<Map<String,Object>>  getMeetTreeRichenClient(int meetid,int userid);
	 
	 public List<Map<String,Object>>  getMeetTreeRichenClientByVersion(int meetid,int version);
	 
	 public List<MeetYichenMainEntity> selectAllParentYichenByMeetid(int meetid);
	 
	 public List<Map<String,Object>>  getMeetTreeYichenNoFile(int meetid);
	 
	 public MeetRichenYitiEntity getMeetRichenYitiByYitiid(int yitiid);
	 
	 public MeetRichenMainEntity getMeetRichenByRichenid(int richenid);
	 
	 List<MeetMainEntity> selectJnumByMtype(String mtype);
	 
	 //搜索
	 List<MeetFileMainEntity> searchFilesByKeywordAndFiletype(String keyword,String filetype,int userid);
	 
	 List<MeetProcessLogEntity> selectProcessLogByMeetid(int meetid);
	 
	Page selectProcessLogByMeetid(final int meetid,int pageNo, int pageSize);
	
	List<MeetFileMainEntity> selectALLPubMeetFileByMeetid(int meetid,String fileown,String filetype);
	
	Page selectAllFileByMeetidAndFileOwnAndVersion(Map<String,Object> map,int pageNo,int pageSize);
	
	//根据 推送范围获取
	List<MeetFileMainEntity> selectALLMeetFileByMeetidAndUserid(int meetid,String fileown,String filetype,int userid);
	//根据会议id获取议程文件
	List<MeetFileMainEntity> selectMeetFileByMeetid(int meetid);
	
	List<MeetFileMainEntity> selectALLPubMeetFileByMeetidAndVersionAndUserid(int meetid,String fileown,String filetype,int userid);

	
	String getCurrentMeetProcess(int meetid);

	
	//获取会议次数
	//public int selectMaxCnumByMtypeAndJnum(Map<String,Object> map);
	
	//获取议程发布时间
	public MeetPubYichenEntity  selectPubtimeByMeetid(Map<String,Object> map);
	
	//获取议程发布时间
	public MeetPubRichenEntity  selectRichenPubtimeByMeetid(Map<String,Object> map);
	
	//获取议程发布时间
	public MeetPubFileEntity  selectFilePubtimeByMeetid(Map<String,Object> map);
	
	//保存会议模块发布时间
    public int insertMeetPubPubtime(MeetPubPubtimeEntity entity);
    
	//获取会议模块最后发布时间
    public MeetPubPubtimeEntity selectMeetPubPubtime(Map<String,Object> map);
    
    //更新会议模块最后发布时间
    public int updateMeetPubPubtime(MeetPubPubtimeEntity entity);
    
    //获取日程关联的闭幕会文件
    public List<MeetRichenFileEntity> selectAllFileByRichenid(int richenid);
    
    //删除分组信息
    public int deleteGroupByGroupid(int groupid);
    
    //删除发布分组信息
    public int deletePubGroupByGroupid(int groupid);
    
     //根据会议id获取会议日程树 服务端使用
	public List<Map<String,Object>>  getMeetTreeRichenNoFileJson(int meetid);

	 //根据文件id获取绑定的议程
	public List<MeetYichenMainEntity> selectBindYichenByFileid(Integer fileid);
	
	//根据文件id获取绑定的日程
	public List<MeetRichenMainEntity> selectBindRichenByFileid(Integer fileid);
	
	 //根据文件id获取绑定的议程
	public List<MeetYichenFileEntity> selectYichenFileByFileidAndYichenid(Map<String,Object> map);
	
	//根据文件id获取绑定的日程
	public List<MeetRichenFileEntity> selectRichenFileByFileid(Integer fileid);
	
	//获取发布的闭幕会文件
	public Page selectALLPubMeetFileByMeetid(final HashMap<String,Object> map1,int pageNo, int pageSize);
	
	//获取是否会中
	public boolean isMeetingMiddle(int meetid);

	public List<MeetFileMainEntity> selectALLMeetFileByMeetid1(int meetid, String fileown, String fileType);

	public Page selectALLMeetFileByMeetid1(HashMap<String, Object> map, int pageNo, int pageSize);
	//PAD端获取日程文件
	public List<MeetFileMainEntity> selectRcFileByMeetid(int meetid);
}
