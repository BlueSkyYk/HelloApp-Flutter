package com.cuityk.flutter_im_plugin;


import android.content.Context;
import android.util.Log;

import com.cuityk.flutter_im_plugin.listener.ChatBaseEventImpl;
import com.cuityk.flutter_im_plugin.listener.ChatTransDataEventImpl;
import com.cuityk.flutter_im_plugin.listener.MessageQoSEventImpl;

import net.openmob.mobileimsdk.android.ClientCoreSDK;
import net.openmob.mobileimsdk.android.conf.ConfigEntity;
import net.openmob.mobileimsdk.android.core.LocalUDPDataSender;

public class IMHelper {
    public static final String TAG = "IMHelper";

    private static boolean isInited = false;
    public static ChatBaseEventImpl chatBaseEvent;
    public static ChatTransDataEventImpl chatTransDataEvent;
    public static MessageQoSEventImpl messageQoSEvent;

    /**
     * 初始化IM
     */
    public static void initIM(Context context) {
        if (isInited) {
            return;
        }
        // 设置AppKey
        ConfigEntity.appKey = "JFASJIOIO3JDJSALJ342FAKLSJH3";

        // 设置服务器ip和服务器端口
//        ConfigEntity.serverIP = "192.168.0.149";
//        ConfigEntity.serverUDPPort = 9000;

        // MobileIMSDK核心IM框架的敏感度模式设置
        ConfigEntity.setSenseMode(ConfigEntity.SenseMode.MODE_3S);

        // 请确保首先进行核心库的初始化（这不同于iOS和Java端）
        ClientCoreSDK.getInstance().init(context);

        chatBaseEvent = new ChatBaseEventImpl();
        chatTransDataEvent = new ChatTransDataEventImpl();
        messageQoSEvent = new MessageQoSEventImpl();

        ClientCoreSDK.getInstance().setChatBaseEvent(chatBaseEvent);
        ClientCoreSDK.getInstance().setChatTransDataEvent(chatTransDataEvent);
        ClientCoreSDK.getInstance().setMessageQoSEvent(messageQoSEvent);
        isInited = true;
        Log.e(TAG, "初始化IM........");
    }

    /**
     * 设置IM服务器地址
     *
     * @param ip
     * @param port
     */
    public static void setImServerAddr(String ip, int port) {
        System.out.println("设置ip端口号： " + ip + "  " + port);
        ConfigEntity.serverIP = ip;
        ConfigEntity.serverUDPPort = port;
    }


    //登录到IM
    public static void loginToIM(Context context,
                                 String account,
                                 String password,
                                 final IMLoginCallback loginCallback) {
        new LocalUDPDataSender.SendLoginDataAsync(context, account, password) {
            @Override
            protected void fireAfterSendLogin(int code) {
                //如果返回不为0，则表示登录连接不通
                if (code != 0) {
                    loginCallback.onFail();
                }
            }
        }.execute();
    }

    //退出登录IM
    public static void logoutIM(Context context) {
        LocalUDPDataSender.getInstance(context).sendLoginout();
    }

    //发送消息
    public static void sendMessage(Context context, String content, String form) {
        new LocalUDPDataSender.SendCommonDataAsync(context, content, form) {
            @Override
            protected void onPostExecute(Integer code) {
                if (code == 0) {

                } else {

                }
            }
        }.execute();
    }


    //登录回调
    public interface IMLoginCallback {
        void onSuccess();

        void onFail();
    }
}
