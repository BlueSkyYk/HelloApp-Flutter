package com.cuityk.flutter_im_plugin.db.entity;

import com.j256.ormlite.field.DatabaseField;
import com.j256.ormlite.table.DatabaseTable;

@DatabaseTable(tableName = "tb_im_message")
public class IMMessage {

    public static final int TYPE_SYSTEM = 0; //系统消息
    public static final int TYPE_ADD_FRIEND_REQ = 1; //添加好友请求
    public static final int TYPE_ADD_FRIEND_RES = 2; //添加好友结果
    public static final int TYPE_CHAT = 3; //聊天消息

    @DatabaseField(useGetSet = true, generatedId = true, columnName = "id")
    private int id;
    @DatabaseField(useGetSet = true, columnName = "msg_id")
    private int msgId;
    @DatabaseField(useGetSet = true, columnName = "type")
    private int type;
    @DatabaseField(useGetSet = true, columnName = "from_user_id")
    private int fromUserId;
    @DatabaseField(useGetSet = true, columnName = "to_user_id")
    private int toUserId;
    @DatabaseField(useGetSet = true, columnName = "content")
    private String content;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMsgId() {
        return msgId;
    }

    public void setMsgId(int msgId) {
        this.msgId = msgId;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public int getFromUserId() {
        return fromUserId;
    }

    public void setFromUserId(int fromUserId) {
        this.fromUserId = fromUserId;
    }

    public int getToUserId() {
        return toUserId;
    }

    public void setToUserId(int toUserId) {
        this.toUserId = toUserId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    public String toString() {
        return "IMMessage{" +
                "id=" + id +
                ", msgId=" + msgId +
                ", type=" + type +
                ", fromUserId=" + fromUserId +
                ", toUserId=" + toUserId +
                ", content='" + content + '\'' +
                '}';
    }

}
