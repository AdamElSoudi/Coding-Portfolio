package com.example.lab3;

import androidx.appcompat.app.AppCompatActivity;

import android.annotation.SuppressLint;
import android.graphics.Bitmap;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CalendarView;
import android.widget.EditText;
import android.widget.ImageView;
import android.content.Intent;
import android.net.Uri;
import android.provider.MediaStore;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.Toast;
import androidx.annotation.Nullable;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

/**
 * The CreatePostActivity class implements an activity that allows users to create and post new events to the application.
 * The activity contains UI elements for inputting event details such as title, address, time, price, description, association, and date.
 * Users can also upload an image to accompany their post. Upon submission, the event is added to the application's database using MyDatabaseHandler.
 * The activity implements AdapterView.OnItemSelectedListener to handle user selection of associations and times from Spinners.
 *
 * @author Adam El Soudi
 * @version 1.0
 * @since 14/03/23
 */
public class CreatePostActivity extends AppCompatActivity implements AdapterView.OnItemSelectedListener {

    private static final int PICK_IMAGE_REQUEST = 1;

    private EditText editTextTitle;
    private EditText editTextAddress;
    private Spinner spinnerTime;
    private EditText editTextPrice;
    private EditText editTextDesc;
    private Spinner spinnerAssociation;
    private Button buttonPost;
    private ImageView image_uploadView;
    private Button image_UploadButton;
    private Uri imageUri;
    private CalendarView upload_calendarView;
    private String date;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_post);

        // Initialize views
        editTextTitle = findViewById(R.id.editTextTitle);
        editTextAddress = findViewById(R.id.editTextAddress);
        spinnerTime = findViewById(R.id.spinner_time);
        editTextPrice = findViewById(R.id.editTextPrice);
        editTextDesc = findViewById(R.id.editTextDesc);
        spinnerAssociation = findViewById(R.id.spinner_association);
        buttonPost = findViewById(R.id.buttonPost);
        image_uploadView = findViewById(R.id.image_uploadView);
        image_UploadButton = findViewById(R.id.upload_ImageButton);
        upload_calendarView = findViewById(R.id.calendarView);

        // Set up association spinner
        ArrayAdapter<CharSequence> association_adapter = ArrayAdapter.createFromResource(this,
                R.array.association_array, android.R.layout.simple_spinner_item);
        association_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerAssociation.setAdapter(association_adapter);
        spinnerAssociation.setOnItemSelectedListener(this);

        // Set up time spinner
        ArrayAdapter<CharSequence> time_adapter = ArrayAdapter.createFromResource(this,
                R.array.time_array, android.R.layout.simple_spinner_item);
        time_adapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        spinnerTime.setAdapter(time_adapter);
        spinnerTime.setOnItemSelectedListener(this);

        // Set up calendar view
        upload_calendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView view, int year, int month, int day) {
                String selectedDate = day + "/" + (month + 1) + "/" + year;
                Toast.makeText(CreatePostActivity.this, "Selected date is " + selectedDate, Toast.LENGTH_SHORT).show();
                date = selectedDate;
            }
        });

        buttonPost.setOnClickListener(new View.OnClickListener() {
            @SuppressLint("StaticFieldLeak")
            @Override
            public void onClick(View view) {
                // Get input values
                String title = editTextTitle.getText().toString().trim();
                String address = editTextAddress.getText().toString().trim();
                String time = spinnerTime.getSelectedItem().toString();
                String price = editTextPrice.getText().toString().trim();
                String desc = editTextDesc.getText().toString().trim();
                String association = spinnerAssociation.getSelectedItem().toString();

                // Check if a date has been selected
                if (date == null || date.isEmpty()) {
                    Toast.makeText(CreatePostActivity.this, "Please select a date", Toast.LENGTH_SHORT).show();
                    return;
                }

                // Check if the fields are empty
                if (title.isEmpty()) {
                    editTextTitle.setError("Title is required");
                    editTextTitle.requestFocus();
                    return;
                }

                if (address.isEmpty()) {
                    editTextAddress.setError("Address is required");
                    editTextAddress.requestFocus();
                    return;
                }

                if (time.equals("Select Time")) {
                    spinnerTime.requestFocus();
                    spinnerTime.performClick();
                    Toast.makeText(CreatePostActivity.this, "Please select a time", Toast.LENGTH_SHORT).show();
                    return;
                }

                if (price.isEmpty()) {
                    editTextPrice.setError("Price is required");
                    editTextPrice.requestFocus();
                    return;
                }

                if (desc.isEmpty()) {
                    editTextDesc.setError("Description is required");
                    editTextDesc.requestFocus();
                    return;
                }

                if (association.equals("Select Association")) {
                    spinnerAssociation.requestFocus();
                    spinnerAssociation.performClick();
                    Toast.makeText(CreatePostActivity.this, "Please select a category", Toast.LENGTH_SHORT).show();
                    return;
                }

                if (imageUri == null) {
                    Toast.makeText(CreatePostActivity.this, "Please upload an image", Toast.LENGTH_SHORT).show();
                    return;
                }

                // Compress and convert the image to a byte array in a separate thread
                new AsyncTask<Void, Void, byte[]>() {
                    @Override
                    protected byte[] doInBackground(Void... voids) {
                        Bitmap bitmap = null;
                        try {
                            bitmap = MediaStore.Images.Media.getBitmap(getContentResolver(), imageUri);
                        } catch (IOException e) {
                            Toast.makeText(CreatePostActivity.this, "Error loading image", Toast.LENGTH_SHORT).show();
                            throw new RuntimeException(e);
                        }

                        // Define maximum image size in bytes
                        int maxSize = 1000000; // 1MB

                        // Calculate current image dimensions
                        int width = bitmap.getWidth();
                        int height = bitmap.getHeight();

                        // Calculate the scale factor to apply to the image dimensions
                        float scaleFactor = Math.min(1.f, ((float) maxSize) / ((float) (width * height)));

                        // Create a new scaled bitmap
                        Bitmap compressedBitmap = Bitmap.createScaledBitmap(bitmap, (int) (width * scaleFactor), (int) (height * scaleFactor), true);

                        // Compress the scaled bitmap to a byte array
                        ByteArrayOutputStream stream = new ByteArrayOutputStream();
                        compressedBitmap.compress(Bitmap.CompressFormat.JPEG, 50, stream);
                        return stream.toByteArray();
                    }

                    @Override
                    protected void onPostExecute(byte[] imageBytes) {
                        // Create a new instance of MyDatabaseHandler
                        MyDatabaseHandler db = new MyDatabaseHandler(CreatePostActivity.this);

                        // Create a new Post object with the information obtained from the UI elements
                        Post post = new Post(title, address, time, price, desc, association, imageBytes, date);

                        // Call the addPost method of MyDatabaseHandler and pass the Post object as a parameter
                        db.addPost(post);

                        // Close the MyDatabaseHandler instance
                        db.close();

                        finish();

                        Intent intent = new Intent(CreatePostActivity.this, EventsActivity.class);
                        startActivity(intent);
                    }
                }.execute();
            }
        });

        // Set up image upload click listener
        image_UploadButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                openFileChooser();
            }
        });
    }

    // Open file chooser to select an image
    private void openFileChooser() {
        Intent intent = new Intent();
        intent.setType("image/*");
        intent.setAction(Intent.ACTION_GET_CONTENT);
        startActivityForResult(Intent.createChooser(intent, "Select Image"), PICK_IMAGE_REQUEST);
    }

    // Handle result from file chooser
    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == PICK_IMAGE_REQUEST && resultCode == RESULT_OK
                && data != null && data.getData() != null) {
            imageUri = data.getData();
            try {
                // Set selected image to ImageView
                image_uploadView.setImageBitmap(MediaStore.Images.Media.getBitmap(getContentResolver(), imageUri));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    // Handle association selection
    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
        String association = adapterView.getItemAtPosition(i).toString();
    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {
    }
}