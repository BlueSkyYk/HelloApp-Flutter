package com.cuityk.flutter_im_plugin.db.dao;

import android.content.Context;

import com.cuityk.flutter_im_plugin.db.DbHelper;
import com.cuityk.flutter_im_plugin.db.entity.IMMessage;
import com.j256.ormlite.dao.Dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class IMMessageDao {
    private Dao<IMMessage, Integer> imMessageDao;
    private DbHelper dbHelper;

    public IMMessageDao(Context context) {
        try {
            dbHelper = DbHelper.getInstance(context);
            imMessageDao = dbHelper.getDao(IMMessage.class);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 添加一条消息
     *
     * @param imMessage
     */
    public void addIMMessage(IMMessage imMessage) {
        try {
            imMessageDao.create(imMessage);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * @param imMessage
     */
    public void updateIMMessage(IMMessage imMessage) {
        try {
            imMessageDao.update(imMessage);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取聊天消息列表
     */
    public List<IMMessage> getChatWithFriendMessageList(int userId, int friendId, int startId, int count) {
        try {
            return imMessageDao.queryBuilder()
                    .where()
                    .eq("type", IMMessage.TYPE_CHAT)
                    .eq("to_user_id", userId)
                    .eq("from_user_id", friendId)
                    .ge("id", startId)
                    .lt("id", startId + count)
                    .query();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }
}
