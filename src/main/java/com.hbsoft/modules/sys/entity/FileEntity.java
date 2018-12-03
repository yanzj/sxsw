package com.hbsoft.modules.sys.entity;

import java.sql.Timestamp;

public class FileEntity {
    private Integer id;//主键id
    private String type;//类型
    private String size;//大小
    private String path;//全路径
    private String titleOrig;//标题
    private String titleAlter;//文件名
    private Timestamp uploadTime;//上传时间

    @Override
    public String toString() {
        return "FileEntity{" +
                "id=" + id +
                ", type='" + type + '\'' +
                ", size='" + size + '\'' +
                ", path='" + path + '\'' +
                ", titleOrig='" + titleOrig + '\'' +
                ", titleAlter='" + titleAlter + '\'' +
                ", uploadTime=" + uploadTime +
                '}';
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

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getTitleOrig() {
        return titleOrig;
    }

    public void setTitleOrig(String titleOrig) {
        this.titleOrig = titleOrig;
    }

    public String getTitleAlter() {
        return titleAlter;
    }

    public void setTitleAlter(String titleAlter) {
        this.titleAlter = titleAlter;
    }

    public Timestamp getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Timestamp uploadTime) {
        this.uploadTime = uploadTime;
    }

    public FileEntity(Integer id, String type, String size, String path, String titleOrig, String titleAlter, Timestamp uploadTime) {

        this.id = id;
        this.type = type;
        this.size = size;
        this.path = path;
        this.titleOrig = titleOrig;
        this.titleAlter = titleAlter;
        this.uploadTime = uploadTime;
    }

    public FileEntity(String type, String size, String path, String titleOrig, String titleAlter, Timestamp uploadTime) {

        this.type = type;
        this.size = size;
        this.path = path;
        this.titleOrig = titleOrig;
        this.titleAlter = titleAlter;
        this.uploadTime = uploadTime;
    }

    public FileEntity() {

    }
}
