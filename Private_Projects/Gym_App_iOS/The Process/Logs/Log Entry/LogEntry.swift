//
//  LogEntry.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-23.
//

import SwiftUI
import Foundation

struct LogEntry: Identifiable, Codable {
    var id = UUID()
    let exercise: String
    let weight: Float?
    let sets: Int?
    let reps: Int?
    let distance: Float?
    let time: Int?
    let date: Date
    let notes: String?
}

class LogEntries: ObservableObject {
    @Published var entries: [LogEntry]

    private static let logEntriesKey = "logEntries"
    private static let benchPressPBKey = "benchPressPB"
    private static let squatPBKey = "squatPB"
    private static let deadliftPBKey = "deadliftPB"
    
    @Published var userWeight: String = ""
    @Published var userHeight: String = ""
    
    // Add properties for personal bests
    @Published var benchPressPB: Double {
        didSet { UserDefaults.standard.set(benchPressPB, forKey: Self.benchPressPBKey) }
    }

    @Published var squatPB: Double {
        didSet { UserDefaults.standard.set(squatPB, forKey: Self.squatPBKey) }
    }

    @Published var deadliftPB: Double {
        didSet { UserDefaults.standard.set(deadliftPB, forKey: Self.deadliftPBKey) }
    }

    init() {
        entries = LogEntries.loadLogEntries()
        
        // Load personal bests from UserDefaults
        benchPressPB = UserDefaults.standard.double(forKey: Self.benchPressPBKey)
        squatPB = UserDefaults.standard.double(forKey: Self.squatPBKey)
        deadliftPB = UserDefaults.standard.double(forKey: Self.deadliftPBKey)
    }

    func saveLogEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: Self.logEntriesKey)
        }
    }

    private static func loadLogEntries() -> [LogEntry] {
        if let data = UserDefaults.standard.data(forKey: logEntriesKey),
           let decoded = try? JSONDecoder().decode([LogEntry].self, from: data) {
            return decoded
        }
        return []
    }

    func addEntry(exercise: String, date: Date, weight: String? = nil, sets: String? = nil, reps: String? = nil, distance: String? = nil, time: String? = nil, notes: String? = nil) {
        let weightValue = weight != nil ? Float(weight!) : nil
        let repsValue = reps != nil ? Int(reps!) : nil
        let setsValue = sets != nil ? Int(sets!) : nil
        let distanceValue = distance != nil ? Float(distance!) : nil
        let timeValue = time != nil ? Int(time!) : nil

        let newEntry = LogEntry(exercise: exercise, weight: weightValue, sets: setsValue, reps: repsValue, distance: distanceValue, time: timeValue, date: date, notes: notes)
        entries.append(newEntry)
        saveLogEntries()
    }

    func deleteEntry(_ entry: LogEntry) {
        if let index = entries.firstIndex(where: { $0.id == entry.id }) {
            entries.remove(at: index)
            saveLogEntries()
        }
    }
    
    func nextExerciseToLog(from exercises: [String]) -> String? {
        // 1. Filter out entries from the current day
        let todayEntries = entries.filter {
            let calendar = Calendar.current
            return calendar.isDate($0.date, inSameDayAs: Date())
        }
        
        // 2. Gather the logged exercises from today's entries
        let loggedExercises = Set(todayEntries.map { $0.exercise })
        
        // 3. Find the first exercise from the provided list that hasn't been logged today
        for exercise in exercises {
            if !loggedExercises.contains(exercise) {
                return exercise
            }
        }
        
        // If all exercises have been logged, return nil
        return nil
    }
}
