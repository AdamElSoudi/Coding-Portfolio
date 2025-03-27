//
//  The_ProcessApp.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-18.
//

import SwiftUI

@main
struct The_ProcessApp: App {
    @StateObject private var exerciseData = ExerciseData()
    let customFont = Font.custom("AvenirNext-Medium", size: 16)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .accentColor(Color.green)
                .environmentObject(LogEntries())
                .environmentObject(exerciseData)
                // Set the custom font as the default for the app
                .environment(\.font, customFont)
        }
    }
}
