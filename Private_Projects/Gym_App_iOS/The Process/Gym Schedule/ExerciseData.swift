//
//  ExerciseData.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-20.
//

import Foundation
import SwiftUI
import Combine

class ExerciseData: ObservableObject {
    @Published var exerciseSelectionStates: [UUID: Bool] = [:]
    @AppStorage("checkedExercises") private var checkedExercisesData: Data = Data()
    @AppStorage("savedDay") private var savedDay: Int = Calendar.current.component(.day, from: Date())

    init() {
        loadCheckedExercises()
    }

    func saveCheckedExercises() {
        if let data = try? JSONEncoder().encode(exerciseSelectionStates) {
            checkedExercisesData = data
            savedDay = Calendar.current.component(.day, from: Date())
        }
    }

    func loadCheckedExercises() {
        let currentDay = Calendar.current.component(.day, from: Date())

        if savedDay != currentDay {
            exerciseSelectionStates = [:]
            savedDay = currentDay
        } else {
            if let checkedExercises = try? JSONDecoder().decode([UUID: Bool].self, from: checkedExercisesData) {
                exerciseSelectionStates = checkedExercises
            }
        }
    }
}
