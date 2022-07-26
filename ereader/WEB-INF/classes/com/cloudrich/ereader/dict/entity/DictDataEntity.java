package com.cloudrich.ereader.dict.entity;
/**
 * 
 * @author 产品数据词典
 *
 */
public class DictDataEntity {
    private Integer id;

    private String type1;

    private String code;
    
    private String parentcode;

    private String name;

    private String isactive;

    private String des;
    
    private String isshow;
    
    private String typename;

    private String type;
    
	public String getParentcode() {
		return parentcode;
	}

	public void setParentcode(String parentcode) {
		this.parentcode = parentcode;
	}

	public String getIsshow() {
		return isshow;
	}

	public void setIsshow(String isshow) {
		this.isshow = isshow;
	}

	public String getTypename() {
		return typename;
	}

	public void setTypename(String typename) {
		this.typename = typename;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code ;
    }
    
    public String getParentCode() {
        return parentcode;
    }

    public void setParentCode(String parentcode) {
        this.parentcode=parentcode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getIsactive() {
        return isactive;
    }

    public void setIsactive(String isactive) {
        this.isactive = isactive == null ? null : isactive.trim();
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des == null ? null : des.trim();
    }
}