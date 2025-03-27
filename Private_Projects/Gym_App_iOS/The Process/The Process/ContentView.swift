// ContentView.swift
// The Process
//
// Created by Adam El Soudi on 2023-04-18.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationController: NavigationController
    @EnvironmentObject var exerciseData: ExerciseData
    @State private var todayGymSessions: [GymSession] = [] // This array will store today's gym sessions
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                GymScheduleView(gymSessions: todayGymSessions)
                Spacer()
            }
        }
        .padding(0)
        .onAppear {
            print("Week number:", getCurrentWeekNumber())
            if let weekSchedule = getScheduleForWeek(weekNumber: getCurrentWeekNumber()) {
                print("Week schedule found:", weekSchedule)
                if let todayGymSession = getTodayGymSession(weekSchedule: weekSchedule, startingDate: getStartingDate()) {
                    print("Gym session found:", todayGymSession)
                    todayGymSessions = [todayGymSession]
                }
            }
            }
        }
    }
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environmentObject(NavigationController())
                         .environmentObject(ExerciseData())
        }
    }
    
    func getTodayExercises(weekSchedule: WeekSchedule?, startingDate: Date) -> [Exercise] {
        if let weekSchedule = weekSchedule,
           let todayGymSession = getTodayGymSession(weekSchedule: weekSchedule, startingDate: startingDate),
           let exercises = todayGymSession.exercises {
            return exercises
        }
        return []
    }

