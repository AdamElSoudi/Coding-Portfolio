//
// CalendarView.swift
// The Process
//
// Created by Adam El Soudi on 2023-04-22.
//

import SwiftUI

struct CalendarView: View {
    let gymSessions: [GymSession]

    var body: some View {
        List {
            ForEach(gymSessions, id: \.id) { session in
                NavigationLink(destination: GymSessionDetailsView(session: session)) {
                    VStack(alignment: .leading) {
                        Text(session.dayOfWeek)
                            .font(.headline)
                            .foregroundColor(.green)
                        Text(session.title)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                }
                //.listRowBackground(Color.white)  
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("Weekly Schedule", displayMode: .inline)
    }
}

struct GymSessionDetailsView: View {
    let session: GymSession

    var body: some View {
        List {
            Section(header: Text("Exercises").font(.headline)) {
                ForEach(session.exercises ?? [], id: \.id) { exercise in
                    VStack(alignment: .leading) {
                        Text(exercise.name)
                            .font(.headline)
                            //.foregroundColor(.green)
                        Text("Sets: \(exercise.Sets)\nReps: \(exercise.Reps)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(session.dayOfWeek, displayMode: .inline)
    }
}
