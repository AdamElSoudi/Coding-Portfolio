//
// LogView.swift
// The Process
//
// Created by Adam El Soudi on 2023-04-19.
//

import SwiftUI

struct LogView: View {
    var exercises: [String]
    var defaultSets: String
    var defaultReps: String
    
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var logEntries: LogEntries
    @FocusState private var focusedField: Field?
    @State private var showSessionCompletedAlert: Bool = false
    
    enum Field {
        case customExerciseName
        case weight
        case sets
        case reps
        case notes
    }
    
    @State private var viewRefreshTrigger: Bool = false
    let borderColor = Color.black

    @State private var selectedExercise: String = "" {
        didSet {
            viewRefreshTrigger.toggle() // Force refresh
        }
    }
    @State private var customExerciseName: String = ""
    @State private var weight: String = ""
    @State private var sets: String = ""
    @State private var reps: String = ""
    @State private var notes: String = ""

    var setsPlaceholder: String {
        if let exercise = getExerciseByName(name: selectedExercise) {
            return "\(exercise.Sets)"
        } else {
            return defaultSets
        }
    }

    var repsPlaceholder: String {
        if let exercise = getExerciseByName(name: selectedExercise) {
            return "\(exercise.Reps)"
        } else {
            return defaultReps
        }
    }

    var allExercises: [String] {
        return exercises + ["Other"]
    }

    var body: some View {
        VStack {
            Text("Daily Log")
                .font(.title)
                .padding(.bottom, 20)

            Picker(selection: $selectedExercise, label: Text("Exercise").foregroundColor(.green)) {
                ForEach(allExercises, id: \.self) { exercise in
                    Text(exercise).foregroundColor(.green)
                        .accentColor(.green)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.bottom, 20)

            if selectedExercise == "Other" {
                TextField("Exercise name", text: $customExerciseName)
                    .focused($focusedField, equals: .customExerciseName)
                    .padding(6)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .customExerciseName ? Color.green : Color((UIColor.systemGray4)), lineWidth: 1))
                    .padding(.bottom, 10)
            }

            TextField("Weight (kg)", text: $weight)
                .keyboardType(.decimalPad)
                .focused($focusedField, equals: .weight)
                .padding(6)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .weight ? Color.green : Color(UIColor.systemGray4), lineWidth: 1))
                .padding(.bottom, 10)

            TextField("Sets (\(setsPlaceholder))", text: $sets)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .sets)
                .padding(6)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .sets ? Color.green : Color(UIColor.systemGray4), lineWidth: 1))
                .padding(.bottom, 10)

            TextField("Reps (\(repsPlaceholder))", text: $reps)
                .keyboardType(.numberPad)
                .focused($focusedField, equals: .reps)
                .padding(6)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .reps ? Color.green : Color(UIColor.systemGray4), lineWidth: 1))
                .padding(.bottom, 10)

            Text("Notes")
                .font(.headline)
                .padding(.bottom, 5)

            TextEditor(text: $notes)
                .frame(minHeight: 100)
                .keyboardType(.alphabet)
                .focused($focusedField, equals: .notes)
                .overlay(RoundedRectangle(cornerRadius: 5).stroke(focusedField == .notes ? Color.green : Color(UIColor.systemGray4), lineWidth: 1))
                .padding(.bottom, 40)

            Button(action: {
                let currentDate = Date()
                let currentExerciseName = selectedExercise == "Other" ? customExerciseName : selectedExercise

                let finalSets = sets.isEmpty ? setsPlaceholder : sets
                let finalReps = reps.isEmpty ? repsPlaceholder : reps

                logEntries.addEntry(exercise: currentExerciseName, date: currentDate, weight: weight, sets: finalSets, reps: finalReps, notes: notes)

                weight = ""
                sets = ""
                reps = ""
                notes = ""
                customExerciseName = ""
                
                selectedExercise = logEntries.nextExerciseToLog(from: exercises) ?? (exercises.first ?? "")

            }, label: {
                Text("Save")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(!weight.isEmpty ? Color.green : Color.gray)
                    .cornerRadius(10)
            })
            .disabled(weight.isEmpty)
        }
        .padding()
        .onChange(of: weight) { newValue in
            if newValue.contains(",") {
                weight = newValue.replacingOccurrences(of: ",", with: ".")
            }
        }
        .padding()
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    focusedField = nil
                }
            }
        }
        .onAppear {
            let defaultExercise = logEntries.nextExerciseToLog(from: exercises) ?? "Other"
            self.selectedExercise = defaultExercise
        }
    }
}

func getExerciseByName(name: String) -> Exercise? {
    for week in gymSchedule {
        for session in week.gymWeek {
            if let exercises = session.exercises,
               let exercise = exercises.first(where: { $0.name == name }) {
                return exercise
            }
        }
    }
    return nil
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
        LogView(
            exercises: ["Bench Press", "Dips", "Scull-Crusher"],
            defaultSets: "3",
            defaultReps: "10"
        )
    }
}
