package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.Manifest;
import android.content.pm.PackageManager;

import java.util.ArrayList;
import java.util.List;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;

/**
 *The EventsActivity class implements an activity that displays a list of events from different associations.
 *The user can filter the list by selecting one or more associations. The filtered list is displayed using a RecyclerView.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/02/23
 */
public class EventsActivity extends AppCompatActivity {

    private RecyclerView recyclerView;
    private PostAdapter postAdapter;
    private MyDatabaseHandler db;

    private boolean svitChecked;
    private boolean allAssociationsChecked;
    private boolean envisChecked;
    private boolean gotarkChecked;
    private boolean legoChecked;

    private CheckBox checkBoxAllAssociations;
    private CheckBox checkBoxSvit;
    private CheckBox checkBoxEnvis;
    private CheckBox checkBoxGotark;
    private CheckBox checkBoxLego;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_events);


        View filtersView = getLayoutInflater().inflate(R.layout.activity_filter, null);

        if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.READ_EXTERNAL_STORAGE}, 0);
        }

        db = new MyDatabaseHandler(this);

        recyclerView = findViewById(R.id.recycler_view);
        recyclerView.setLayoutManager(new LinearLayoutManager(this));

        postAdapter = new PostAdapter(new ArrayList<>());
        recyclerView.setAdapter(postAdapter);


        checkBoxAllAssociations = filtersView.findViewById(R.id.checkBoxAllAssociations);
        checkBoxSvit = filtersView.findViewById(R.id.checkBoxSvit);
        checkBoxEnvis = filtersView.findViewById(R.id.checkBoxEnvis);
        checkBoxGotark = filtersView.findViewById(R.id.checkBoxGotark);
        checkBoxLego = filtersView.findViewById(R.id.checkBoxLego);

        svitChecked = true;
        envisChecked = true;
        gotarkChecked = true;
        legoChecked = true;

        ImageView menu = findViewById(R.id.imageView9);
        menu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(EventsActivity.this, MenuActivity.class);
                startActivity(intent);
            }
        });

        ImageView filter = findViewById(R.id.imageView10);
        filter.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intentF = new Intent(EventsActivity.this, FilterActivity.class);
                intentF.putExtra("svitChecked", svitChecked);
                intentF.putExtra("allAssociationsChecked", allAssociationsChecked);
                intentF.putExtra("envisChecked", envisChecked);
                intentF.putExtra("gotarkChecked", gotarkChecked);
                intentF.putExtra("legoChecked", legoChecked);
                startActivityForResult(intentF, 1);
            }
        });

        checkBoxAllAssociations.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                allAssociationsChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();

                if (isChecked) {
                    svitChecked = true;
                    envisChecked = true;
                    gotarkChecked = true;
                    legoChecked = true;

                    checkBoxSvit.setChecked(true);
                    checkBoxEnvis.setChecked(true);
                    checkBoxGotark.setChecked(true);
                    checkBoxLego.setChecked(true);
                }
            }
        });

        checkBoxSvit.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                svitChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        });

        checkBoxEnvis.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                envisChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        });

        checkBoxGotark.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                gotarkChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        });

        checkBoxLego.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                legoChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        });

        new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                gotarkChecked = isChecked;
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        };
        getPostsFromDatabase();
    }

    private List<Post> getPostsFromDatabase() {
        List<Post> allPosts = db.getAllPosts();
        List<Post> filteredPosts = new ArrayList<>();


        // Filter posts based on selected checkboxes
        for (Post post : allPosts) {
            if (allAssociationsChecked) {
                // If "All Associations" is checked, add all posts to the filtered list
                filteredPosts.add(post);
            } else {
                // Else check the association of each post against the selected checkboxes
                if (svitChecked && post.getAssociation().equals("Svit")) {
                    filteredPosts.add(post);
                } else if (envisChecked && post.getAssociation().equals("EnVis")) {
                    filteredPosts.add(post);
                } else if (gotarkChecked && post.getAssociation().equals("GotArk")) {
                    filteredPosts.add(post);
                } else if (legoChecked && post.getAssociation().equals("Lego")) {
                    filteredPosts.add(post);
                }
            }
        }

        postAdapter.setData(filteredPosts);
        postAdapter.notifyDataSetChanged();
        return filteredPosts;
    }

    @Override
    protected void onResume() {
        super.onResume();
        List<Post> postList = getPostsFromDatabase();
        postAdapter.setData(postList);
        postAdapter.notifyDataSetChanged();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 1) {
            if (resultCode == RESULT_OK) {

                // Get selected checkboxes from the intent extras
                svitChecked = data.getBooleanExtra("svitChecked", false);
                allAssociationsChecked = data.getBooleanExtra("allAssociationsChecked", true);
                envisChecked = data.getBooleanExtra("envisChecked", false);
                gotarkChecked = data.getBooleanExtra("gotarkChecked", false);
                legoChecked = data.getBooleanExtra("legoChecked", false);

                // Refresh the post list based on the selected checkboxes
                List<Post> postList = getPostsFromDatabase();
                postAdapter.setData(postList);
                postAdapter.notifyDataSetChanged();
            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        db.close();
    }

}
