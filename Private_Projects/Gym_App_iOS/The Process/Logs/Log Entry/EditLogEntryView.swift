//
//  EditLogEntryView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-26.
//

import SwiftUI

struct EditLogEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var logEntries: LogEntries
    @State var logEntry: LogEntry
    
    @State private var weight: String
    @State private var sets: String
    @State private var reps: String
    @State private var notes: String

    init(logEntries: LogEntries, logEntry: LogEntry) {
        self.logEntries = logEntries
        self._logEntry = State(initialValue: logEntry)
        self._weight = State(initialValue: String(logEntry.weight ?? 0))
        self._reps = State(initialValue: String(logEntry.reps ?? 0))
        self._sets = State(initialValue: String(logEntry.sets ?? 0))
        self._notes = State(initialValue: logEntry.notes ?? "")
    }
    
    var body: some View {
        Form {
            Section(header: Text("Exercise Details")) {
                Text(logEntry.exercise)
                    .font(.headline)
            }
            
            Section(header: Text("Weight & Sets & Reps")) {
                TextField("Weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.clear, lineWidth: 1))
                
                TextField("Sets", text: $sets)
                    .keyboardType(.numberPad)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.clear, lineWidth: 1))
                
                TextField("Reps", text: $reps)
                    .keyboardType(.numberPad)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.clear, lineWidth: 1))
            }
            
            Section(header: Text("Notes")) {
                TextEditor(text: $notes)
                    .frame(minHeight: 100)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.clear, lineWidth: 1))
                    .padding(.bottom, 10)
                    .padding(.top, 10)
            }

        }
        .navigationBarItems(trailing: Button("Save") {
            updateLogEntry()
            presentationMode.wrappedValue.dismiss()
        })
        .navigationTitle("Edit Log Entry")
    }
    
    private func updateLogEntry() {
        if let weightValue = Float(weight), let setsValue = Int(sets), let repsValue = Int(reps) {
            let updatedEntry = LogEntry(id: logEntry.id, exercise: logEntry.exercise, weight: weightValue, sets: setsValue, reps: repsValue, distance: logEntry.distance, time: logEntry.time, date: logEntry.date, notes: notes)

            if let index = logEntries.entries.firstIndex(where: { $0.id == logEntry.id }) {
                logEntries.entries[index] = updatedEntry
                logEntries.saveLogEntries()
            }
        }
    }
}

struct EditLogEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let logEntries = LogEntries()
        let sampleLogEntry = LogEntry(exercise: "Bench Press", weight: 60, sets: 3, reps: 8, distance: nil, time: nil, date: Date(), notes: "Hej")
        EditLogEntryView(logEntries: logEntries, logEntry: sampleLogEntry)
            .environmentObject(NavigationController())
            .environmentObject(logEntries)
    }
}

