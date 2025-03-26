package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

/**
 *The MenuActivity class is an activity that displays a menu for the user.
 *The menu allows the user to navigate to the EventsActivity, create a new post with CreatePostActivity, or logout and return to the MainActivity.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 03/14/23
 */
public class MenuActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);


        ImageView imageView5 = findViewById(R.id.imageView5);
        imageView5.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MenuActivity.this, EventsActivity.class);
                startActivity(intent);
            }
        });

        ViewGroup logout = findViewById(R.id.logoutLin);
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent logout = new Intent(MenuActivity.this, MainActivity.class);
                startActivity(logout);
            }
        });

        Button createPost = findViewById(R.id.post_button);
        createPost.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MenuActivity.this, CreatePostActivity.class);
                startActivity(intent);
            }
        });

        // "Clear All Posts" button functionality here
        Button clearAllButton = findViewById(R.id.clear_all_button);  // Ensure the button is in the layout
        clearAllButton.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                // Clearing all posts from the database
                MyDatabaseHandler dbHandler = new MyDatabaseHandler(MenuActivity.this);
                SQLiteDatabase db = dbHandler.getWritableDatabase();
                db.execSQL("DELETE FROM " + MyDatabaseHandler.getTablePosts());  // Use the getter method here
                db.close();

                // Optionally show a Toast message confirming the action
                Toast.makeText(MenuActivity.this, "All posts cleared!", Toast.LENGTH_SHORT).show();
            }
        });

    }
}