package com.example.lab3;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import java.util.List;

/**
 *The PostAdapter class implements a RecyclerView adapter that displays a list of Post objects.
 *This adapter is used to display the list of posts in the EventsActivity.
 *
 *@author Adam El Soudi
 *@version 1.0
 *@since 14/03/23
 */

public class PostAdapter extends RecyclerView.Adapter<PostAdapter.PostViewHolder> {

    private List<Post> postList;

    public PostAdapter(List<Post> postList) {
        this.postList = postList;
    }

    @NonNull
    @Override
    public PostViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        LayoutInflater inflater = LayoutInflater.from(parent.getContext());
        View view = inflater.inflate(R.layout.item_post, parent, false);
        return new PostViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull PostViewHolder holder, int position) {
        Post post = postList.get(position);
        holder.titleTextView.setText(post.getTitle());
        holder.priceTextView.setText(post.getPrice());
        holder.dateTextView.setText(post.getDate());

        holder.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // Start PostDetailActivity and pass post ID as extra
                Intent intent = new Intent(view.getContext(), PostDetailActivity.class);
                intent.putExtra("postId", post);
                view.getContext().startActivity(intent);

            }
        });

        // Retrieve the image data from the Post object as a byte array
        byte[] imageData = post.getImage();

        if (imageData != null) {
            // Convert the byte array to a bitmap
            Bitmap bitmap = BitmapFactory.decodeByteArray(imageData, 0, imageData.length);

            // Set the bitmap in the ImageView
            holder.imageView.setImageBitmap(bitmap);
        }
    }

    @Override
    public int getItemCount() {
        return postList.size();
    }
    public void setData(List<Post> posts) {
        postList.clear(); // Clear the existing list
        postList.addAll(posts); // Add the new list
        notifyDataSetChanged();
    }

    public static class PostViewHolder extends RecyclerView.ViewHolder {

        public TextView dateTextView;
        private TextView titleTextView;
        private TextView addressTextView;
        private TextView timeTextView;
        private TextView priceTextView;
        private ImageView imageView;

        public PostViewHolder(@NonNull View itemView) {
            super(itemView);
            titleTextView = itemView.findViewById(R.id.titleTextView);
            addressTextView = itemView.findViewById(R.id.addressTextView);
            timeTextView = itemView.findViewById(R.id.timeTextView);
            priceTextView = itemView.findViewById(R.id.priceTextView);
            imageView = itemView.findViewById(R.id.postImageView);
            dateTextView = itemView.findViewById(R.id.dateTextView);
        }
    }
}