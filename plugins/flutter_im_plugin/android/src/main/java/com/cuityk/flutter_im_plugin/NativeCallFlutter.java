package com.cuityk.flutter_im_plugin;

import android.util.Log;

import com.google.gson.reflect.TypeToken;

import org.json.JSONObject;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.StringCodec;

public class NativeCallFlutter {
    private static final String TAG = "NativeCallFlutter";

    //    private static EventChannel.EventSink sEventSink;
    private static BasicMessageChannel<String> sBasicMessageChannel;

    public static void register(PluginRegistry.Registrar registrar) {
//        new EventChannel(registrar.messenger(), "native_call_flutter_im_plugin")
//                .setStreamHandler(new EventChannel.StreamHandler() {
//                    @Override
//                    public void onListen(Object o, EventChannel.EventSink eventSink) {
//                        Log.e(TAG, "onListen: 开始启动。。。。。。。EventSink = " + eventSink + "   Obj = " + o);
//                        if (eventSink != null) {
//                            sEventSink = eventSink;
//                        }
//                    }
//
//                    @Override
//                    public void onCancel(Object o) {
//                        sEventSink = null;
//                        Log.e(TAG, "onListen: 连接关闭。。。。。。  Obj = " + o);
//                    }
//                });

        sBasicMessageChannel = new BasicMessageChannel(registrar.messenger(), "native_call_flutter_im_plugin", StringCodec.INSTANCE);
        sBasicMessageChannel.setMessageHandler(sMessageHandler);
    }

    //消息接收监听
    private static BasicMessageChannel.MessageHandler<String> sMessageHandler = new BasicMessageChannel.MessageHandler<String>() {
        @Override
        public void onMessage(String s, BasicMessageChannel.Reply<String> reply) {
            //收到消息
            reply.reply("哈哈哈哈哈。。。。。。。。。。。。。。。。。。。。。。123456");
        }
    };

    /**
     * 回调登录结果
     *
     * @param success
     */
    public static void callLoginResult(boolean success) {
//        if (sEventSink != null) {
//            Log.e(TAG, "Native发送消息到Flutter");
//            sEventSink.success(new NativeEvent.Builder(NativeEvent.EVENT_LOGIN_RESULT).put("success", success).build());
//        }

        if (sBasicMessageChannel != null) {
            sBasicMessageChannel.send(new NativeEvent.Builder(NativeEvent.EVENT_LOGIN_RESULT).put("success", success).build());
        }
    }

    /**
     * 消息回调
     */
    public static void callMessage(String msg) {
//        if (sEventSink != null) {
//            Log.e(TAG, "Native发送登录结果。。。");
//            HashMap<String, Object> param = Util.toObject(msg, new TypeToken<HashMap<String, Object>>() {
//            }.getType());
//            String message = new NativeEvent
//                    .Builder(NativeEvent.EVENT_MESSAGE)
//                    .putAll(param)
//                    .build();
//            sEventSink.success(message);
//        }
        if (sBasicMessageChannel != null) {
            Log.e(TAG, "Native发送消息。。。");
            HashMap<String, Object> param = Util.toObject(msg, new TypeToken<HashMap<String, Object>>() {
            }.getType());
            String message = new NativeEvent
                    .Builder(NativeEvent.EVENT_MESSAGE)
                    .putAll(param)
                    .build();
            sBasicMessageChannel.send(message);
        }
    }

    //事件类
    static class NativeEvent implements Serializable {
        //登录结果回调
        static int EVENT_LOGIN_RESULT = 100;
        //消息回调
        static int EVENT_MESSAGE = 110;

        int event;
        HashMap<String, Object> data;

        public static class Builder {
            private NativeEvent nativeEvent;

            public Builder(int event) {
                nativeEvent = new NativeEvent();
                nativeEvent.event = event;
                nativeEvent.data = new HashMap<>();
            }

            public Builder put(String key, Object value) {
                nativeEvent.data.put(key, value);
                return this;
            }

            public Builder putAll(HashMap<String, Object> data) {
                nativeEvent.data.putAll(data);
                return this;
            }

            public String build() {
                return Util.toJson(nativeEvent);
            }
        }
    }
}

