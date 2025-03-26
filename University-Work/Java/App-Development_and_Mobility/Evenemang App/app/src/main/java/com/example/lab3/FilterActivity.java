package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.ImageView;

import java.util.List;

/**
 *The FilterActivity app implements a filter screen for events.
 *The user can select associations to filter events by.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/03/23
 */
public class FilterActivity extends AppCompatActivity {


    private CheckBox checkBoxAllAssociations;
    private CheckBox checkBoxSvit;
    private CheckBox checkBoxEnvis;
    private CheckBox checkBoxGotark;
    private CheckBox checkBoxLego;

    private boolean svitChecked;
    private boolean allAssociationsChecked;
    private boolean envisChecked;
    private boolean gotarkChecked;
    private boolean legoChecked;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_filter);

        // initialize the CheckBox variables
        checkBoxSvit = findViewById(R.id.checkBoxSvit);
        checkBoxAllAssociations = findViewById(R.id.checkBoxAllAssociations);
        checkBoxEnvis = findViewById(R.id.checkBoxEnvis);
        checkBoxGotark = findViewById(R.id.checkBoxGotark);
        checkBoxLego = findViewById(R.id.checkBoxLego);

        Button saveButton = findViewById(R.id.buttonSaveChoices);

        saveButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // Code to save the user's choices
                svitChecked = checkBoxSvit.isChecked();
                allAssociationsChecked = checkBoxAllAssociations.isChecked();
                envisChecked = checkBoxEnvis.isChecked();
                gotarkChecked = checkBoxGotark.isChecked();
                legoChecked = checkBoxLego.isChecked();

                // Code to return the user's choices
                Intent returnIntent = new Intent();
                returnIntent.putExtra("svitChecked", svitChecked);
                returnIntent.putExtra("allAssociationsChecked", allAssociationsChecked);
                returnIntent.putExtra("envisChecked", envisChecked);
                returnIntent.putExtra("gotarkChecked", gotarkChecked);
                returnIntent.putExtra("legoChecked", legoChecked);
                setResult(RESULT_OK, returnIntent);
                finish();
            }
        });

        checkBoxAllAssociations.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    checkBoxSvit.setChecked(false);
                    checkBoxEnvis.setChecked(false);
                    checkBoxGotark.setChecked(false);
                    checkBoxLego.setChecked(false);
                }
            }
        });

        checkBoxSvit.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                // If the checkbox is checked, uncheck the "All Associations" checkbox
                if (isChecked) {
                    checkBoxAllAssociations.setChecked(false);
                }
            }
        });

        checkBoxEnvis.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    checkBoxAllAssociations.setChecked(false);
                }
            }
        });

        checkBoxGotark.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    checkBoxAllAssociations.setChecked(false);
                }
            }
        });

        checkBoxLego.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    checkBoxAllAssociations.setChecked(false);
                }
            }
        });

        ImageView imageView2 = findViewById(R.id.imageView2);
        imageView2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });
    }

    @Override
    public void onBackPressed() {
        // Get the latest checkbox values and return them
        svitChecked = checkBoxSvit.isChecked();
        allAssociationsChecked = checkBoxAllAssociations.isChecked();
        envisChecked = checkBoxEnvis.isChecked();
        gotarkChecked = checkBoxGotark.isChecked();
        legoChecked = checkBoxLego.isChecked();

        Intent intent = new Intent();
        intent.putExtra("svitChecked", svitChecked);
        intent.putExtra("allAssociationsChecked", allAssociationsChecked);
        intent.putExtra("envisChecked", envisChecked);
        intent.putExtra("gotarkChecked", gotarkChecked);
        intent.putExtra("legoChecked", legoChecked);
        setResult(RESULT_OK, intent);

        super.onBackPressed();
    }
}
