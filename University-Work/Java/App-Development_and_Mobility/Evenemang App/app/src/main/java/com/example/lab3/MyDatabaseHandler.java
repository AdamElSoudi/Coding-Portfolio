package com.example.lab3;


import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.util.Log;
import java.util.ArrayList;
import java.util.List;

/**
 *The MyDatabaseHandler class is responsible for creating and managing the application's database.
 *The class extends the SQLiteOpenHelper class and provides methods to add, retrieve and delete posts from the database.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/03/23
 */

public class MyDatabaseHandler extends SQLiteOpenHelper {

    private static final int DATABASE_VERSION = 1;
    private static final String DATABASE_NAME = "application_dev_db";
    private static final String TABLE_POSTS = "posts";
    private static final String KEY_ID = "id";
    private static final String KEY_TITLE = "title";
    private static final String KEY_ADDRESS = "address";
    private static final String KEY_TIME = "time";
    private static final String KEY_PRICE = "price";
    private static final String KEY_DESC = "description";
    private static final String KEY_ASSOCIATION = "association";
    private static final String KEY_IMAGE = "image";
    private static final String KEY_DATE = "date";

    public MyDatabaseHandler(Context context) {
        super(context, DATABASE_NAME, null, DATABASE_VERSION);

       // Delete the database file
        //context.deleteDatabase(DATABASE_NAME);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        String CREATE_POSTS_TABLE = "CREATE TABLE " + TABLE_POSTS + "("
                + KEY_ID + " INTEGER PRIMARY KEY AUTOINCREMENT,"
                + KEY_TITLE + " TEXT,"
                + KEY_ADDRESS + " TEXT,"
                + KEY_TIME + " TEXT,"
                + KEY_PRICE + " TEXT,"
                + KEY_DESC + " TEXT,"
                + KEY_ASSOCIATION + " TEXT,"
                + KEY_IMAGE + " BLOB,"
                + KEY_DATE + " TEXT" + ")";
        db.execSQL(CREATE_POSTS_TABLE);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS " + TABLE_POSTS);
        onCreate(db);
    }

    public void addPost(com.example.lab3.Post post) {
        SQLiteDatabase db = this.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put(KEY_TITLE, post.getTitle());
        values.put(KEY_ADDRESS, post.getAddress());
        values.put(KEY_TIME, post.getTime());
        values.put(KEY_PRICE, post.getPrice());
        values.put(KEY_DESC, post.getDescription());
        values.put(KEY_ASSOCIATION, post.getAssociation());
        values.put(KEY_IMAGE, post.getImage());
        values.put(KEY_DATE, post.getDate());

        db.insert(TABLE_POSTS, null, values);
        db.close();
    }

    public List<Post> getAllPosts() {
        List<Post> postList = new ArrayList<>();

        String selectQuery = "SELECT * FROM " + TABLE_POSTS + " ORDER BY " + KEY_ID + " DESC";

        SQLiteDatabase db = this.getReadableDatabase();
        Cursor cursor = db.rawQuery(selectQuery, null);

        // looping through all rows and adding to list
        if (cursor.moveToFirst()) {
            do {
                Post post = new Post(cursor.getString(1), cursor.getString(2), cursor.getString(3),
                        cursor.getString(4), cursor.getString(5), cursor.getString(6),
                        cursor.getBlob(7), cursor.getString(8));

                post.setId(cursor.getInt(0));
                post.setTitle(cursor.getString(1));
                post.setAddress(cursor.getString(2));
                post.setTime(cursor.getString(3));
                post.setPrice(cursor.getString(4));
                post.setDescription(cursor.getString(5));
                post.setAssociation(cursor.getString(6));
                post.setImage(cursor.getBlob(7));
                post.setDate(cursor.getString(8));
                postList.add(post);
            } while (cursor.moveToNext());
        }

        // closing connection
        cursor.close();
        db.close();

        // returning post list
        return postList;
    }

    // Get a post by its ID
    public Post getPost(long id) {
        SQLiteDatabase db = this.getReadableDatabase();
        String selectQuery = "SELECT * FROM " + TABLE_POSTS + " WHERE " + KEY_ID + " = " + id + " ORDER BY " + KEY_ID;

        Cursor cursor = db.rawQuery(selectQuery, null);

        if (cursor != null && cursor.moveToFirst()) {
            cursor.moveToFirst();

            Post post = new Post(cursor.getString(1), cursor.getString(2), cursor.getString(3),
                    cursor.getString(4), cursor.getString(5), cursor.getString(6),
                    cursor.getBlob(7), cursor.getString(8));

            post.setId(cursor.getInt(0));
            post.setTitle(cursor.getString(1));
            post.setAddress(cursor.getString(2));
            post.setTime(cursor.getString(3));
            post.setPrice(cursor.getString(4));
            post.setDescription(cursor.getString(5));
            post.setAssociation(cursor.getString(6));
            post.setImage(cursor.getBlob(7));
            post.setDate(cursor.getString(8));

            cursor.close();
            db.close();
            return post;
        }
        db.close();
        return null;
    }

    public static String getTablePosts() {
        return TABLE_POSTS;
    }


    public void deletePost(int id) {
        SQLiteDatabase db = this.getWritableDatabase();
        db.delete(TABLE_POSTS, "id =?", new String[]{String.valueOf(id)});
        db.close();
    }
}
