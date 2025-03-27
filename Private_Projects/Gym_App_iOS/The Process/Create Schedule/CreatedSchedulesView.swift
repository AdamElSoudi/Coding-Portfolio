////
////  CreatedSchedulesView.swift
////  The Process
////
////  Created by Adam El Soudi on 2023-04-29.
////
//
//
//import SwiftUI
//
//struct Exercise: Identifiable, Codable {
//    let id = UUID()
//    var name: String
//    var Sets: Int
//    var Reps: Int
//    var RestTime: Int
//}
//
//struct CardioExercise {
//    var name: String
//    var distance: Int
//    var intensity: String
//    var time_minutes: Int
//}
//
//struct GymSession: Identifiable {
//    let id = UUID()
//    let weekNumber: Int
//    let dayOfWeek: String
//    let title: String
//    let totalSetsReps: String?
//    let totalRestTime: Int?
//    let exercises: [Exercise]?
//    let cardioExercises: [CardioExercise]?
//    
//    init(weekNumber: Int, title: String, dayOfWeek: String, totalSetsReps: String? = nil, totalRestTime: Int? = nil, exercises: [Exercise]? = nil, cardioExercises: [CardioExercise]? = nil) {
//        self.weekNumber = weekNumber
//           self.dayOfWeek = dayOfWeek
//           self.title = title
//           self.totalSetsReps = totalSetsReps
//           self.totalRestTime = totalRestTime
//           self.exercises = exercises
//           self.cardioExercises = cardioExercises
//       }
//}
//
//struct WeekSchedule {
//    var weekNumber: Int
//    var gymWeek: [GymSession]
//}
//
//struct CreatedScheduleView: View {
//    @ObservedObject var scheduleStore: ScheduleStore
//
//    var body: some View {
//        List {
//            ForEach(scheduleStore.schedules.keys.sorted(), id: \.self) { scheduleName in
//                if let schedule = scheduleStore.schedules[scheduleName] {
//                    HStack {
//                        NavigationLink(destination: ScheduleDetailView(schedule: schedule, scheduleStore: scheduleStore, scheduleName: scheduleName)) {
//                            Text(scheduleName)
//                                .font(.system(size: 18, weight: .bold, design: .rounded))
//                        }
//                        Spacer()
//                    }
//                }
//            }
//        }
//        .listStyle(InsetGroupedListStyle())
//        .navigationBarTitle("Your Schedules")
//    }
//}
//
//struct ScheduleDetailView: View {
//    let schedule: CreateScheduleView.Schedule
//    @ObservedObject var scheduleStore: ScheduleStore
//    let scheduleName: String
//    @State private var isActive: Bool
//
//    init(schedule: CreateScheduleView.Schedule, scheduleStore: ScheduleStore, scheduleName: String) {
//        self.schedule = schedule
//        self.scheduleStore = scheduleStore
//        self.scheduleName = scheduleName
//        self._isActive = State(initialValue: scheduleStore.activeSchedule?.id == schedule.id)
//    }
//
//    var body: some View {
//        VStack {
//            List {
//                ForEach(0..<schedule.numWeeks, id: \.self) { weekIndex in
//                    ForEach(0..<Int(schedule.daysPerWeek[weekIndex]), id: \.self) { dayIndex in
//                        let totalDayIndex = weekIndex * 7 + dayIndex
//                        if let dayTitle = schedule.dayTitles[totalDayIndex] {
//                            VStack(alignment: .leading, spacing: 5) {
//                                Text("Week \(weekIndex + 1), \(schedule.selectedWeekdays[weekIndex][dayIndex])")
//                                    .font(.headline)
//                                    .fontWeight(.bold)
//                                Text(dayTitle)
//                                ForEach(schedule.exercises[totalDayIndex, default: []], id: \.id) { exercise in
//                                    VStack(alignment: .leading, spacing: 5) {
//                                        Text(exercise.name)
//                                            .font(.headline)
//                                            .fontWeight(.bold)
//                                        Text("Sets: \(exercise.Sets)")
//                                        Text("Reps: \(exercise.Reps)")
//                                        Text("Rest Time: \(exercise.RestTime) Min")
//                                    }
//                                    .padding(.bottom, 5)
//                                }
//                            }
//                            .padding(.vertical)
//                        }
//                    }
//                }
//            }
//            .listStyle(InsetGroupedListStyle())
//            Button(action: {
//                isActive.toggle()
//                if isActive {
//                    scheduleStore.setActiveSchedule(schedule)
//                } else {
//                    scheduleStore.setActiveSchedule(nil)
//                }
//            }) {
//                Text(isActive ? "Active" : "Not Active")
//                    .foregroundColor(.white)
//                    .padding(.vertical, 10)
//                    .padding(.horizontal, 30)
//                    .background(isActive ? Color.blue : Color.red)
//                    .cornerRadius(40)
//            }
//            .padding(.bottom, 20)
//        }
//        .navigationBarTitle("Schedule Details")
//        .navigationBarItems(trailing: Button(action: {
//            scheduleStore.schedules.removeValue(forKey: scheduleName)
//        }) {
//            Image(systemName: "trash")
//                .foregroundColor(.red)
//        })
//    }
//}
//
//struct ActiveToggleStyle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        HStack {
//            configuration.label
//            
//            Spacer()
//            
//            Button(action: {
//                configuration.isOn.toggle()
//            }) {
//                RoundedRectangle(cornerRadius: 16)
//                    .fill(configuration.isOn ? Color.green : Color.red)
//                    .frame(width: 50, height: 30)
//                    .overlay(
//                        Circle()
//                            .fill(Color.white)
//                            .padding(3)
//                            .offset(x: configuration.isOn ? 10 : -10)
//                    )
//                    .animation(.easeInOut(duration: 0.2), value: configuration.isOn)
//            }
//        }
//    }
//}
//
//struct CreatedScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreatedScheduleView(scheduleStore: ScheduleStore())
//    }
//}
