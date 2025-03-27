//  GymSchedule.Swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-17.
//
import Foundation

struct Exercise: Identifiable, Codable {
    var id = UUID()
    var name: String
    var Sets: Int
    var Reps: Int
}

struct GymSession: Identifiable {
    let id = UUID()
    let weekNumber: Int
    let dayOfWeek: String
    let title: String
    let totalSetsReps: String?
    let exercises: [Exercise]?
    
    init(weekNumber: Int, title: String, dayOfWeek: String, totalSetsReps: String? = nil, exercises: [Exercise]? = nil) {
        self.weekNumber = weekNumber
           self.dayOfWeek = dayOfWeek
           self.title = title
           self.totalSetsReps = totalSetsReps
           self.exercises = exercises
       }
}

struct WeekSchedule {
    var weekNumber: Int
    var gymWeek: [GymSession]
}

let gymSchedule: [WeekSchedule] = [
    WeekSchedule(weekNumber: 1, gymWeek: week1GymSessions),
]

// MARK: Upper/Lower Schedule
let week1GymSessions: [GymSession] = [
    GymSession(weekNumber: 1,
               title: "Upper B",
               dayOfWeek: "Monday",
               exercises: [
                Exercise(name: "Bench Press", Sets: 3, Reps: 6),
                Exercise(name: "Lat-Pulldowns", Sets: 4, Reps: 6),
                Exercise(name: "Dips", Sets: 5, Reps: 5),
                Exercise(name: "Rear-Delts Flyes", Sets: 3, Reps: 8),
                Exercise(name: "ISO Rows", Sets: 3, Reps: 8),
                Exercise(name: "Cable-Seated Rows", Sets: 3, Reps: 8)
               ]),
    
    GymSession(weekNumber: 1,
               title: "Arms 1",
               dayOfWeek: "Tuesday",
               exercises: [
                Exercise(name: "Seated Shoulder Press", Sets: 4, Reps: 8),
                Exercise(name: "Overhead Tricep-Extention", Sets: 3, Reps: 10),
                Exercise(name: "Lateral Raises", Sets: 4, Reps: 8),
                Exercise(name: "Tricep Extentions", Sets: 3, Reps: 10),
                Exercise(name: "Bayesian Cable Curl", Sets: 3, Reps: 10),
                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 10),
                Exercise(name: "Forearms", Sets: 3, Reps: 10)
               ]),
    
    GymSession(weekNumber: 1,
               title: "Legs 1",
               dayOfWeek: "Wednesday",
               exercises: [
                Exercise(name: "Squats", Sets: 4, Reps: 6),
                Exercise(name: "Romanian Deadlifts", Sets: 3, Reps: 8),
                Exercise(name: "Quad-Extensions", Sets: 3, Reps: 10),
                Exercise(name: "Hamstring-Curls", Sets: 2, Reps: 10),
                Exercise(name: "Calf-Raises", Sets: 3, Reps: 10),
                Exercise(name: "Abs", Sets: 3, Reps: 10)
               ]),
    
    GymSession(weekNumber: 1,
               title: "Upper C",
               dayOfWeek: "Thursday",
               exercises: [
                Exercise(name: "Incline-Bench Press", Sets: 4, Reps: 8),
                Exercise(name: "ISO Rows", Sets: 3, Reps: 8),
                Exercise(name: "Seated Shoulder Press", Sets: 3, Reps: 10),
                Exercise(name: "Lat-Pulldowns", Sets: 3, Reps: 8),
                Exercise(name: "Chest-Flyes", Sets: 2, Reps: 8),
                Exercise(name: "Shrugs", Sets: 2, Reps: 6)
               ]),
    
    GymSession(weekNumber: 1,
               title: "Arms 2",
               dayOfWeek: "Friday",
               exercises: [
                Exercise(name: "Seated Shoulder Press", Sets: 4, Reps: 8),
                Exercise(name: "Overhead Tricep-Extention", Sets: 3, Reps: 10),
                Exercise(name: "Lateral Raises", Sets: 4, Reps: 8),
                Exercise(name: "Tricep Extentions", Sets: 3, Reps: 10),
                Exercise(name: "Bayesian Cable Curl", Sets: 3, Reps: 10),
                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 10),
                Exercise(name: "Forearms", Sets: 3, Reps: 10)
               ]),
    
    GymSession(weekNumber: 1,
               title: "Legs 2",
               dayOfWeek: "Saturday",
               exercises: [
                Exercise(name: "Deadlifts", Sets: 3, Reps: 6),
                Exercise(name: "Quad-Extensions", Sets: 4, Reps: 8),
                Exercise(name: "Hamstring-Curls", Sets: 3, Reps: 8),
                Exercise(name: "Calf-Raises", Sets: 3, Reps: 10),
                Exercise(name: "Abs", Sets: 3, Reps: 10)
               ])
]


// MARK: Adam's Schedule
//let week1GymSessions: [GymSession] = [
//    GymSession(weekNumber: 1,
//               title: "Push",
//               dayOfWeek: "Monday",
//               exercises: [
//                Exercise(name: "Bench Press", Sets: 3, Reps: 3),
//                Exercise(name: "Dips", Sets: 5, Reps: 5),
//                Exercise(name: "Scull-Crusher", Sets: 2, Reps: 6),
//                Exercise(name: "Chest-Flyes", Sets: 2, Reps: 8),
//                Exercise(name: "Side Lateral Raises", Sets: 2, Reps: 6),
//                Exercise(name: "Tricep-Pulldowns", Sets: 2, Reps: 6),
//                Exercise(name: "Overhead-Tricep Extension", Sets: 2, Reps: 6)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Pull",
//               dayOfWeek: "Tuesday",
//               exercises: [
//                Exercise(name: "Lat-Pulldowns", Sets: 2, Reps: 6),
//                Exercise(name: "Lat-Row", Sets: 2, Reps: 6),
//                Exercise(name: "Rear-Delts Flyes", Sets: 2, Reps: 6),
//                Exercise(name: "Shrugs", Sets: 3, Reps: 10),
//                Exercise(name: "Bicep-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Incline Bicep-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Forearms", Sets: 3, Reps: 10)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Legs",
//               dayOfWeek: "Wednesday",
//               exercises: [
//                Exercise(name: "Squats", Sets: 3, Reps: 3),
//                Exercise(name: "Quad-Extensions", Sets: 2, Reps: 8),
//                Exercise(name: "Hamstring-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Leg Press", Sets: 2, Reps: 8),
//                Exercise(name: "Calf-Raises", Sets: 3, Reps: 10),
//                Exercise(name: "Abs", Sets: 3, Reps: 10)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Chest/Back",
//               dayOfWeek: "Thursday",
//               exercises: [
//                Exercise(name: "Incline-Bench Press", Sets: 2, Reps: 6),
//                Exercise(name: "Back-Row", Sets: 2, Reps: 6),
//                Exercise(name: "Chest Press", Sets: 2, Reps: 6),
//                Exercise(name: "Lat-Pulldowns", Sets: 2, Reps: 6),
//                Exercise(name: "Chest-Flyes", Sets: 2, Reps: 8),
//                Exercise(name: "Lower-Back Extensions", Sets: 3, Reps: 10),
//                Exercise(name: "Shrugs", Sets: 2, Reps: 6)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Arms",
//               dayOfWeek: "Friday",
//               exercises: [
//                Exercise(name: "Shoulder Press", Sets: 2, Reps: 6),
//                Exercise(name: "Scull-Crushers", Sets: 2, Reps: 6),
//                Exercise(name: "Bicep-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Incline Bicep-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Side-Lateral Raises", Sets: 2, Reps: 6),
//                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Tricep-Pulldowns", Sets: 2, Reps: 6),
//                Exercise(name: "Overhead-Tricep Extension", Sets: 2, Reps: 6),
//                Exercise(name: "Forearms", Sets: 3, Reps: 10)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Legs",
//               dayOfWeek: "Saturday",
//               exercises: [
//                Exercise(name: "Deadlifts", Sets: 3, Reps: 3),
//                Exercise(name: "Quad-Extensions", Sets: 2, Reps: 8),
//                Exercise(name: "Hamstring-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Leg Press", Sets: 2, Reps: 8),
//                Exercise(name: "Calf-Raises", Sets: 3, Reps: 10),
//                Exercise(name: "Abs", Sets: 3, Reps: 10)
//               ])
//]


//MARK: Rami's Schedule:
//let week1GymSessions: [GymSession] = [
//    GymSession(weekNumber: 1,
//               title: "Push",
//               dayOfWeek: "Monday",
//               exercises: [
//                Exercise(name: "Bench Press", Sets: 3, Reps: 6),
//                Exercise(name: "Incline Dumbell-Press", Sets: 2, Reps: 8),
//                Exercise(name: "Dumbbell Shoulder-Press", Sets: 2, Reps: 8),
//                Exercise(name: "Smithmashine Shoulderpress \n(Behind head)", Sets: 2, Reps: 8),
//                Exercise(name: "Smithmashine Scull-Crushers", Sets: 2, Reps: 8),
//                Exercise(name: "Pec-Dec", Sets: 2, Reps: 8),
//                Exercise(name: "Reversed Pec-Dec", Sets: 2, Reps: 8),
//                Exercise(name: "Tricep Pushdowns", Sets: 2, Reps: 8),
//                Exercise(name: "Lateral Raises", Sets: 2, Reps: 8)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Pull",
//               dayOfWeek: "Tuesday",
//               exercises: [
//                Exercise(name: "Deadlifts", Sets: 3, Reps: 5),
//                Exercise(name: "Lat-Pulldowns", Sets: 2, Reps: 8),
//                Exercise(name: "Seated Rows", Sets: 2, Reps: 8),
//                Exercise(name: "1-Arm Rows", Sets: 2, Reps: 8),
//                Exercise(name: "Dumbbell-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Rear-Delts Flyes", Sets: 2, Reps: 6),
//                Exercise(name: "Forearms (Superset)", Sets: 2, Reps: 8)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Legs",
//               dayOfWeek: "Wednesday",
//               exercises: [
//                Exercise(name: "Squats", Sets: 3, Reps: 5),
//                Exercise(name: "Hamstring-Legpress", Sets: 2, Reps: 8),
//                Exercise(name: "Quad-Extensions", Sets: 2, Reps: 8),
//                Exercise(name: "Hamstring-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Abs", Sets: 3, Reps: 10)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Push",
//               dayOfWeek: "Thursday",
//               exercises: [
//                Exercise(name: "Bench Press", Sets: 3, Reps: 6),
//                Exercise(name: "Incline Dumbell-Press", Sets: 2, Reps: 8),
//                Exercise(name: "Dumbbell Shoulder-Press", Sets: 2, Reps: 8),
//                Exercise(name: "Smithmashine Shoulder-Press \n(Behind head)", Sets: 2, Reps: 8),
//                Exercise(name: "Smithmashine Scull-Crushers", Sets: 2, Reps: 8),
//                Exercise(name: "Pec-Dec", Sets: 2, Reps: 8),
//                Exercise(name: "Reversed Pec-Dec", Sets: 2, Reps: 8),
//                Exercise(name: "Tricep Pushdowns", Sets: 2, Reps: 8),
//                Exercise(name: "Lateral Raises", Sets: 2, Reps: 8)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Pull",
//               dayOfWeek: "Friday",
//               exercises: [
//                Exercise(name: "Deadlifts", Sets: 3, Reps: 5),
//                Exercise(name: "Lat-Pulldowns", Sets: 2, Reps: 8),
//                Exercise(name: "Seated Rows", Sets: 2, Reps: 8),
//                Exercise(name: "1-Arm Rows", Sets: 2, Reps: 8),
//                Exercise(name: "Dumbbell-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Hammer-Curls", Sets: 2, Reps: 6),
//                Exercise(name: "Rear-Delts Flyes", Sets: 2, Reps: 6),
//                Exercise(name: "Forearms (Superset)", Sets: 2, Reps: 8)
//               ]),
//    
//    GymSession(weekNumber: 1,
//               title: "Legs",
//               dayOfWeek: "Saturday",
//               exercises: [
//                Exercise(name: "Squats", Sets: 3, Reps: 5),
//                Exercise(name: "Hamstring-Legpress", Sets: 2, Reps: 8),
//                Exercise(name: "Quad-Extensions", Sets: 2, Reps: 8),
//                Exercise(name: "Hamstring-Curls", Sets: 2, Reps: 8),
//                Exercise(name: "Abs", Sets: 3, Reps: 10)
//               ])
//    ]
