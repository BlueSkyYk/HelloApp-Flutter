package com.cuityk.flutter_im_plugin.listener;

import android.util.Log;

import net.openmob.mobileimsdk.android.event.MessageQoSEvent;
import net.openmob.mobileimsdk.server.protocal.Protocal;

import java.util.ArrayList;

/**
 * Qos相关事件回调
 */
public class MessageQoSEventImpl implements MessageQoSEvent {

    String TAG = "MessageQoSEventImpl";

    // 消息无法完成实时送达的通知
    @Override
    public void messagesLost(ArrayList<Protocal> arrayList) {
        Log.i(TAG, "收到系统的未实时送达事件通知，当前共有"
                + arrayList.size() + "个包QoS保证机制结束，判定为【无法实时送达】！");
    }

    // 对方已成功收到消息的通知
    @Override
    public void messagesBeReceived(String theFingerPrint) {
        if (theFingerPrint != null)
            Log.i(TAG, "收到对方已收到消息事件的通知，消息指纹码=" + theFingerPrint);
        else
            Log.e(TAG, "收到对方已收到消息事件的通知");
    }
}
