package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;

/**
 *The ItemPostActivity displays the layout of a single post item to the user.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/03/23
 */
public class ItemPostActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.item_post);
    }
}