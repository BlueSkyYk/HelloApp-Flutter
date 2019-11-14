package com.cuityk.flutter_im_plugin.db;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;

import com.cuityk.flutter_im_plugin.db.entity.IMMessage;
import com.j256.ormlite.android.apptools.OrmLiteSqliteOpenHelper;
import com.j256.ormlite.dao.Dao;
import com.j256.ormlite.support.ConnectionSource;
import com.j256.ormlite.table.TableUtils;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DbHelper extends OrmLiteSqliteOpenHelper {

    private static final String DB_TABLE_NAME = "hello.db";
    private static final int DB_VERSION = 1;

    private Map<String, Dao> daoMap = new HashMap<>();

    private DbHelper(Context context) {
        super(context, DB_TABLE_NAME, null, DB_VERSION);
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase, ConnectionSource connectionSource) {
        try {
            TableUtils.createTableIfNotExists(connectionSource, IMMessage.class);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, ConnectionSource connectionSource, int i, int i1) {

    }

    private static DbHelper instance;

    public static DbHelper getInstance(Context context) {
        context = context.getApplicationContext();
        if (instance == null) {
            synchronized (DbHelper.class) {
                if (instance == null) {
                    instance = new DbHelper(context);
                }
            }
        }
        return instance;
    }

    public synchronized Dao getDao(Class clazz) throws SQLException {
        Dao dao = null;
        String className = clazz.getSimpleName();

        if (daoMap.containsKey(className)) {
            dao = daoMap.get(className);
        }
        if (dao == null) {
            dao = super.getDao(clazz);
            daoMap.put(className, dao);
        }
        return dao;
    }


    @Override
    public void close() {
        super.close();
        for (Map.Entry<String, Dao> daoEntry : daoMap.entrySet()) {
            daoEntry = null;
        }
    }
}
