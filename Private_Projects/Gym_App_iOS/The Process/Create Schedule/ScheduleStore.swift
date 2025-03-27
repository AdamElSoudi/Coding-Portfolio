////
////  ScheduleStore.swift
////  The Process
////
////  Created by Adam El Soudi on 2023-04-29.
////
//
//import SwiftUI
//import Combine
//
//class ScheduleStore: ObservableObject {
//    @Published var schedules: [String: CreateScheduleView.Schedule] {
//        didSet {
//            saveSchedules()
//        }
//    }
//    @Published var activeSchedule: CreateScheduleView.Schedule?
//
//    init() {
//        schedules = [:]
//        activeSchedule = nil
//
//        schedules = loadSchedules() ?? [:]
//
//        if let activeScheduleData = UserDefaults.standard.data(forKey: "activeSchedule"),
//           let decodedActiveSchedule = try? JSONDecoder().decode(CreateScheduleView.Schedule.self, from: activeScheduleData) {
//            activeSchedule = decodedActiveSchedule
//        }
//    }
//
//    private func saveSchedules() {
//        let encoder = JSONEncoder()
//        if let encodedData = try? encoder.encode(schedules) {
//            UserDefaults.standard.set(encodedData, forKey: "userSchedules")
//        }
//    }
//
//    private func loadSchedules() -> [String: CreateScheduleView.Schedule]? {
//        if let savedData = UserDefaults.standard.data(forKey: "userSchedules") {
//            let decoder = JSONDecoder()
//            if let decodedSchedules = try? decoder.decode([String: CreateScheduleView.Schedule].self, from: savedData) {
//                return decodedSchedules
//            }
//        }
//        return nil
//    }
//
//    func addSchedule(_ schedule: CreateScheduleView.Schedule, forKey key: String) {
//        schedules[key] = schedule
//    }
//
//    func removeSchedule(forKey key: String) {
//        schedules[key] = nil
//    }
//
//    func setActiveSchedule(_ schedule: CreateScheduleView.Schedule?) {
//        activeSchedule = schedule
//        if let schedule = schedule {
//            UserDefaults.standard.set(try? JSONEncoder().encode(schedule), forKey: "activeSchedule")
//        } else {
//            UserDefaults.standard.removeObject(forKey: "activeSchedule")
//        }
//    }
//}
