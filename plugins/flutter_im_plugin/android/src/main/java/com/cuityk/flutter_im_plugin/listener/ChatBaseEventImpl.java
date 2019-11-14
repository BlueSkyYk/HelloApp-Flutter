package com.cuityk.flutter_im_plugin.listener;

import android.util.Log;

import com.cuityk.flutter_im_plugin.NativeCallFlutter;

import net.openmob.mobileimsdk.android.event.ChatBaseEvent;

import java.util.Observer;

/**
 * 框架基本事件回调
 */
public class ChatBaseEventImpl implements ChatBaseEvent {
    String TAG = "ChatBaseEventImpl";

    //登录或掉线重新连接结果
    @Override
    public void onLoginMessage(int i) {
        NativeCallFlutter.callLoginResult(i == 0);
    }

    // 掉线事件通知
    @Override
    public void onLinkCloseMessage(int i) {
        Log.e(TAG, "onLinkCloseMessage: " + i);
    }
}
