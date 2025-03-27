//
//  ScheduleUtilities.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-18.
//

import Foundation

// This function takes a week number as an input and returns the corresponding WeekSchedule object if found.
func getScheduleForWeek(weekNumber: Int) -> WeekSchedule? {
    // Searches for the first WeekSchedule object in the gymSchedule array with a matching weekNumber.
    let foundSchedule = gymSchedule.first { $0.weekNumber == weekNumber }
    print("Week number:", weekNumber)
    return foundSchedule
}

func getTodayGymSession(weekSchedule: WeekSchedule, startingDate: Date) -> GymSession? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to English
    let daysBetween = Calendar.current.dateComponents([.day], from: startingDate, to: Date()).day!
    let currentWeekday = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: daysBetween, to: startingDate)!)
    let currentWeek = getCurrentWeekNumber(startingDate: startingDate)

    return weekSchedule.gymWeek.first { $0.weekNumber == currentWeek && $0.dayOfWeek == currentWeekday }
}

// This function always returns week number as 1.
func getCurrentWeekNumber(startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 17))!) -> Int {
    return 1
}

func getStartingDate(startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 17))!) -> Date {
    return startingDate
}


//// This function takes a week number as an input and returns the corresponding WeekSchedule object if found.
//func getScheduleForWeek(weekNumber: Int) -> WeekSchedule? {
//    // Searches for the first WeekSchedule object in the gymSchedule array with a matching weekNumber.
//    let foundSchedule = gymSchedule.first { $0.weekNumber == weekNumber }
//       print("Week number:", weekNumber)
//       return foundSchedule
//}
//
//func getTodayGymSession(weekSchedule: WeekSchedule, startingDate: Date) -> GymSession? {
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "EEEE"
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Set the locale to English
//    let daysBetween = Calendar.current.dateComponents([.day], from: startingDate, to: Date()).day!
//    let currentWeekday = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: daysBetween, to: startingDate)!)
//    let currentWeek = getCurrentWeekNumber(startingDate: startingDate)
//
//    return weekSchedule.gymWeek.first { $0.weekNumber == currentWeek && $0.dayOfWeek == currentWeekday }
//}
//
//// This function calculates and returns the current week number (1 or 2) based on the current date.
//func getCurrentWeekNumber(startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 17))!) -> Int {
//    let calendar = Calendar.current
//    let currentDate = Date()
//    
//    let components = calendar.dateComponents([.day], from: startingDate, to: currentDate)
//    guard let daysPassed = components.day else {
//        return 0
//    }
//    let weeksPassed = daysPassed / 7
//    return (weeksPassed % 2 == 0) ? 1 : 2 // Change between Streght & Growth week by switching the 1 and 2
//}
//
//func getStartingDate(startingDate: Date = Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 17))!) -> Date {
//    let calendar = Calendar.current
//    let currentDate = Date()
//    
//    let components = calendar.dateComponents([.weekOfYear], from: startingDate, to: currentDate)
//    return (startingDate)
//}
