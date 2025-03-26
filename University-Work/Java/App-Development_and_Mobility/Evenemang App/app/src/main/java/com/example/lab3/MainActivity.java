package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

/**
 * The MainActivity class is the entry point of the application that
 * displays the login button to the user and redirects to the EventsActivity.
 *
 * @author Adam El Soudi
 * @version 1.0
 * @since 14/03/23
 */

public class MainActivity extends AppCompatActivity {

    MyDatabaseHandler db = new MyDatabaseHandler(this);
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button myButton = findViewById(R.id.login_button);
        myButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, EventsActivity.class);
                startActivity(intent);

                //db.deletePost(7);

            }
        });
    }
}