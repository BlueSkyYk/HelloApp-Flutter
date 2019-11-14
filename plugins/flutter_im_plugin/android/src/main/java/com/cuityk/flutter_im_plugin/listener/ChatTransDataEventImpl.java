package com.cuityk.flutter_im_plugin.listener;

import android.util.Log;

import com.cuityk.flutter_im_plugin.FlutterImPlugin;
import com.cuityk.flutter_im_plugin.NativeCallFlutter;
import com.cuityk.flutter_im_plugin.Util;
import com.cuityk.flutter_im_plugin.db.DbHelper;
import com.cuityk.flutter_im_plugin.db.dao.IMMessageDao;
import com.cuityk.flutter_im_plugin.db.entity.IMMessage;

import net.openmob.mobileimsdk.android.event.ChatTransDataEvent;

import java.util.Observer;

import io.flutter.app.FlutterApplication;

/**
 * 即时消息事件回调
 */
public class ChatTransDataEventImpl implements ChatTransDataEvent {

    String TAG = "ChatTransDataEventImpl";

    private IMMessageDao imMessageDao;

    public ChatTransDataEventImpl() {
        imMessageDao = new IMMessageDao(FlutterImPlugin.context);
    }

    /**
     * 收到即时通讯消息通知
     *
     * @param fingerPrintOfProtocal 当该消息需要QoS支持时本回调参数为该消息的特征指纹码，否则为null
     * @param userId                MobileIMSDK框架中规定发送者id="0"即表示是由服务端主动发过的，否则 表示的是其它客户端发过来的消息
     * @param dataContent           消息内容的文本表示形式
     * @param typeu
     */
    @Override
    public void onTransBuffer(String fingerPrintOfProtocal, String userId, String dataContent, int typeu) {
        Log.e(TAG, "接受消息成功: " + fingerPrintOfProtocal + "   " + userId + "   " + dataContent + "   " + typeu);
        try {
            IMMessage imMessage = Util.toObject(dataContent, IMMessage.class);
            imMessageDao.addIMMessage(imMessage);
        } catch (Exception e) {
            e.printStackTrace();
        }
        NativeCallFlutter.callMessage(dataContent);
    }

    // 收到服务端反馈的错误信息通知
    @Override
    public void onErrorResponse(int errCode, String errMsg) {
        Log.e(TAG, "接受消息出错: " + errCode + "    " + errMsg);
    }

}
