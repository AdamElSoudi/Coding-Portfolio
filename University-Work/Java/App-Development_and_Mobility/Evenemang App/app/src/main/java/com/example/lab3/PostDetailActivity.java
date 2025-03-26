package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewTreeObserver;
import android.widget.ImageView;
import android.widget.ScrollView;
import android.widget.TextView;

/**
 *The PostDetailActivity class displays the details of a post, including its title,
 * address, date, time, price, description, association, and image. It also allows the user to navigate back to the EventsActivity.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/03/23
 */

public class PostDetailActivity extends AppCompatActivity {

    private TextView titleTextView;
    private TextView addressTextView;
    private TextView dateTextView;
    private TextView timeTextView;
    private TextView priceTextView;
    private TextView spinner_associationTextView;
    private TextView descTextView;
    private ImageView imageView;
    private int scrollPosition;
    private ScrollView scrollView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_post_detail);

        ImageView goBack = findViewById(R.id.goBack);
        goBack.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View v) {
                Intent intent = new Intent(PostDetailActivity.this, EventsActivity.class);
                startActivity(intent);

                // Set the scroll position back to where it was before clicking the button
                scrollView.post(new Runnable() {
                    @Override
                    public void run() {
                        scrollView.scrollTo(0, scrollPosition);
                    }
                });
            }
        });

        scrollView = findViewById(R.id.detailsScroll);
        scrollView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                // Set the scroll position to the current position of the ScrollView
                scrollPosition = scrollView.getScrollY();
                // Remove the layout listener to prevent multiple calls
                scrollView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
            }
        });

        scrollView = findViewById(R.id.detailsScroll);
        scrollView.getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                // Set the scroll position to the current position of the ScrollView
                scrollPosition = scrollView.getScrollY();
                // Remove the layout listener to prevent multiple calls
                scrollView.getViewTreeObserver().removeOnGlobalLayoutListener(this);
            }
        });


        Post post = (Post) getIntent().getSerializableExtra("postId");
        long postId = post.getId();
        MyDatabaseHandler dbHandler = new MyDatabaseHandler(this);
        post = dbHandler.getPost(postId);

        titleTextView = findViewById(R.id.titleTextView);
        addressTextView = findViewById(R.id.addressTextView);
        dateTextView = findViewById(R.id.dateTextView);
        timeTextView = findViewById(R.id.timeTextView);
        priceTextView = findViewById(R.id.priceTextView);
        spinner_associationTextView = findViewById(R.id.spinner_associationTextView);
        descTextView = findViewById(R.id.descTextView);
        imageView = findViewById(R.id.imageView);



        // Set post data to UI elements
        titleTextView.setText(post.getTitle());
        addressTextView.setText(post.getAddress());
        dateTextView.setText(post.getDate());
        timeTextView.setText(post.getTime());
        priceTextView.setText(post.getPrice());
        spinner_associationTextView.setText(post.getAssociation());
        descTextView.setText(post.getDescription());

        byte[] imageData = post.getImage();
        if (imageData != null && imageData.length > 0) {
            Bitmap bitmap = BitmapFactory.decodeByteArray(imageData, 0, imageData.length);
            imageView.setImageBitmap(bitmap);
        }
    }
}