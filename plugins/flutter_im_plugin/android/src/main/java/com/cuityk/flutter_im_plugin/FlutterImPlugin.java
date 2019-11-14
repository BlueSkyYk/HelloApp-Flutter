package com.cuityk.flutter_im_plugin;

import android.content.Context;
import android.util.Log;

import com.cuityk.flutter_im_plugin.db.dao.IMMessageDao;

import org.json.JSONObject;

import java.util.HashMap;
import java.util.Observable;
import java.util.Observer;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FlutterImPlugin
 */
public class FlutterImPlugin implements MethodCallHandler {
    private static final String TAG = "FlutterImPlugin";

    public static Context context;

    private IMMessageDao imMessageDao;

    public FlutterImPlugin(Context context) {
        FlutterImPlugin.context = context.getApplicationContext();
        imMessageDao = new IMMessageDao(FlutterImPlugin.context);
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_im_plugin");
        channel.setMethodCallHandler(new FlutterImPlugin(registrar.context()));
        //注册Native回调Flutter
        NativeCallFlutter.register(registrar);
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "initIM": //初始化IM
                IMHelper.initIM(context);
                result.success("IM初始化完成");
                break;
            case "loginIM": //IM登录
                loginIM(context, call, result);
                break;
            case "logoutIM": //IM退出登录
                IMHelper.logoutIM(context);
                break;
            case "sendMessageToUser": //发送消息到用户
                sendMessageToUser(call);
                break;
            case "getChatMessageList":
                getChatMessageList(call, result);
                break;
            default:
                result.notImplemented();
                break;
        }
    }


    //登录到IM
    private void loginIM(Context context, MethodCall methodCall, final MethodChannel.Result result) {
        String account = methodCall.argument("account");
        String password = methodCall.argument("password");
        String imServerIp = methodCall.argument("imServerIp");
        int imServerPort = methodCall.argument("imServerPort");

        //设置im服务器ip和端口
        IMHelper.setImServerAddr(imServerIp, imServerPort);
        Log.e(TAG, "onMethodCall: loginIm:    account = " + account + "   password = " + password + "  ip = " + imServerIp + "  port = " + imServerPort);

        //调用IMSDK进行登录
        IMHelper.loginToIM(context, account, password, new IMHelper.IMLoginCallback() {
            @Override
            public void onSuccess() {
            }

            @Override
            public void onFail() {
                result.success(false);
            }
        });
    }

    //发送消息到用户
    private void sendMessageToUser(MethodCall call) {
        if (call.arguments == null) {
            return;
        }
        HashMap<String, Object> map = new HashMap<>();
        map.put("type", call.argument("type"));
        map.put("fromUserId", call.argument("fromUserId"));
        map.put("fromNickname", call.argument("fromNickname"));
        map.put("content", call.argument("content"));
        //向用户发送数据
        IMHelper.sendMessage(context, Util.toJson(map), call.argument("toUsername").toString());
    }

    //获取聊天记录列表
    private void getChatMessageList(MethodCall call, Result result) {
        int userId = call.argument("userId");
        int friendId = call.argument("friendId");
        int startId = call.argument("startId");
        int count = call.argument("count");
        result.success(Util.toJson(imMessageDao.getChatWithFriendMessageList(userId, friendId, startId, count)));
    }
}
