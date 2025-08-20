package com.example.spaceshooter

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.TextView

class HighScoresAdapter(private val context: Context, private val scores: List<Int>) : BaseAdapter() {

    override fun getCount(): Int {
        return scores.size
    }

    override fun getItem(position: Int): Any {
        return scores[position]
    }

    override fun getItemId(position: Int): Long {
        return position.toLong()
    }

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val view: TextView = convertView as? TextView
            ?: LayoutInflater.from(context).inflate(android.R.layout.simple_list_item_1, parent, false) as TextView

        val formattedScore = context.getString(R.string.position, position + 1, scores[position])
        view.text = formattedScore

        return view
    }
}