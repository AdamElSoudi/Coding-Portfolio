//
//  WeightLogEntries.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-10-18.
//

import Foundation

struct WeightLog: Identifiable, Codable {
    var id = UUID()
    let date: String
    let weight: Double
}

class WeightLogEntries: ObservableObject {
    @Published var logs: [String: Double] = [:]
    private static let weightLogsKey = "weightLogs"

    init() {
        self.logs = WeightLogEntries.loadWeightLogs()
    }

    func saveWeightLogs() {
        let logArray = logs.map { WeightLog(id: UUID(), date: $0.key, weight: $0.value) }
        if let encoded = try? JSONEncoder().encode(logArray) {
            UserDefaults.standard.set(encoded, forKey: Self.weightLogsKey)
        }
    }

    private static func loadWeightLogs() -> [String: Double] {
        if let data = UserDefaults.standard.data(forKey: weightLogsKey),
           let decoded = try? JSONDecoder().decode([WeightLog].self, from: data) {
            return Dictionary(uniqueKeysWithValues: decoded.map { ($0.date, $0.weight) })
        }
        return [:]
    }

    func addOrUpdateLog(date: String, weight: Double) {
        logs[date] = weight
        saveWeightLogs()
    }

    func deleteLog(date: String) {
        logs[date] = nil
        saveWeightLogs()
    }
}
