package com.cloudrich.framework.common.dao;


import java.util.List;
import java.util.Map;

	/**
	 * 基本的DAO接口可以继承该接口,一些基本的dao接口操作
	 * @param <T>
	 */
public interface AbstractInitDao<T> {

	/**
	 * 保存数据
	 * @param entity 需要保存的实体
	 * @return 返回保存后的实体
	 */
	public Object saveEntity(T entity) throws Exception;

	/**
	 * 更新的实体	 * @param entity 需要更新的实体
	 * @return 
	 */
	public void updateEntity(T entity) throws Exception;

	
	/**
	 * 删除记录
	 * @param ids 删除记录的ID
	 * @return 删除成功返回true 删除失败返回false
	 */
	public void deleteEntity(String... ids) throws Exception;
	
	/**
	 * 查询所有记录数
	 * @param ap 查询所有记录的条件
	 * @return 符合结果的记录数
	 */
	public List<T> findAllEntity(Map<String,Object> queryMap) throws Exception;
	
	
	/**
	 * 查询记录数	 * @param queryMap 查询条件
	 * @return 总记录数
	 */
	public long countPage(Map<String,Object> queryMap) throws Exception;
	
	
	/**
	 * 根据ID查询对象
	 * @param id 主键ID
	 * @return 查询出的对象
	 */
	public T findById(String id) throws Exception;
	
	/**
	 * 根据ID查询对象
	 * @param id 主键ID
	 * @return 查询出的对象
	 */
	public T findById(long id) throws Exception;
	
}
