//
//  GymScheduleView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-18.
//

import SwiftUI

struct GymScheduleView: View {
    let gymSessions: [GymSession]
    //@StateObject private var scheduleStore = ScheduleStore()
    @State private var selectedIndex: Int
    @State private var showingCalendarView = false
    @State private var showingLogView = false
    @State private var showingLogEntriesView = false
    @State private var showingOneRepMaxView = false
    @State private var navigateToLogView = false
    @State private var showingCreateScheduleView = false
    @State private var showingEditLogEntries = false
    @State private var showingCreatedScheduleView = false
    @State private var isGymScheduleViewActive = true
    @State private var isWeightLogViewActive = false
    
    @State private var isGymMemberViewActive = false


    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var exerciseData: ExerciseData

    private var selectedGymSessionExercises: [Exercise] {
        if gymSessions.indices.contains(selectedIndex) {
            return gymSessions[selectedIndex].exercises ?? []
        } else {
            return []
        }
    }

    let showCalendarButton: Bool
    let showCheckBoxes: Bool
    let showNavigationButtons: Bool

    init(gymSessions: [GymSession], selectedGymSession: GymSession? = nil, showCalendarButton: Bool = true, showCheckBoxes: Bool = true, showNavigationButtons: Bool = true) {
        self.gymSessions = gymSessions
        self.showCalendarButton = showCalendarButton
        self.showCheckBoxes = showCheckBoxes
        self.showNavigationButtons = showNavigationButtons

        if let selectedGymSession = selectedGymSession,
           let index = gymSessions.firstIndex(where: { $0.id == selectedGymSession.id }) {
            _selectedIndex = State(initialValue: index)
        } else {
            _selectedIndex = State(initialValue: 0) // Default selected index
        }
    }
    
    var body: some View {
        ZStack {
            TabView {
                // Home View
                NavigationView {
                    sessionContentView
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                HStack {
                                    NavigationLink(destination: GymMemberView(isGymMemberViewActive: $isGymMemberViewActive)) {
                                        Image(systemName: "person.crop.square")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 25, height: 25)
                                    }
                                    
                                    // Example: Add a settings icon
                                    NavigationLink(destination: CardHolder()) {
                                        Image(systemName: "creditcard")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                            
                            //                            ToolbarItem(placement: .principal) {
                            //                                VStack(alignment: .center, spacing: 10) {
                            //                                    Text("The Process")
                            //                                        .foregroundColor(.green)
                            //                                        .font(Font.custom("AvenirNext-Medium", size: 24))
                            //                                }
                            //                            }
                            //                            ToolbarItem(placement: .navigationBarTrailing) {
                            //                                NavigationLink(destination: GymMemberView(isGymMemberViewActive: $isGymMemberViewActive)) {
                            //                                    Image(systemName: "person.crop.square")
                            //                                        .resizable()
                            //                                        .scaledToFit()
                            //                                        .frame(width: 25, height: 25)
                            //                                }
                            //                            }
                        }
                }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(0)
                
                // CalendarView
                NavigationView {
                    CalendarView(gymSessions: week1GymSessions)
                }
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(1)
                
                // Calculator/OneRepMaxView
                NavigationView {
                    OneRepMaxView()
                }
                .tabItem {
                    Image(systemName: "dumbbell.fill")
                    Text("Calculator")
                }
                .tag(2)
                
            // MARK: Weight and logs views
                                NavigationView {
                                    WeightLogView(isWeightLogViewActive: $isWeightLogViewActive)
                                }
                                .tabItem {
                                    Image(systemName: "chart.bar.xaxis")
                                    Text("Weight")
                                }
                                .tag(3)
                                .onAppear {
                                    isWeightLogViewActive = true
                                }
                                .onDisappear {
                                    isWeightLogViewActive = false
                                }
                
                                // LogEntriesView
                                NavigationView {
                                    LogEntriesView()
                                }
                                .tabItem {
                                    Image(systemName: "book.closed")
                                    Text("Logs")
                                }
                                .tag(4)
                            }
                            .accentColor(Color.green)
            //}
            
            
            
            
            VStack {
                Spacer()
                HStack {
                    Spacer()

                    // NavigationLink and Button combo
                    // MARK: Logging button
                    NavigationLink("", destination: LogView(
                        exercises: selectedGymSessionExercises.map { $0.name },
                        defaultSets: "\(selectedGymSessionExercises.first?.Sets ?? 0)", // Convert Int to String
                        defaultReps: "\(selectedGymSessionExercises.first?.Reps ?? 0)"  // Convert Int to String
                    ), isActive: $navigateToLogView)
                        .opacity(0)
                        .buttonStyle(PlainButtonStyle())

                    // Conditional pencilButton
                    if !isWeightLogViewActive && !isGymMemberViewActive {
                        Button(action: {
                            self.navigateToLogView = true
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                                .padding(20)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 10)
                        }
                        .padding(.trailing, 25)
                        .padding(.bottom, 60)
                    }
                }
            }

        }
    }

    @ViewBuilder
    private var sessionContentView: some View {
        TabView(selection: $selectedIndex) {
            ForEach(0..<gymSessions.count, id: \.self) { index in
                sessionView(gymSession: gymSessions[index])
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }

    @ViewBuilder
    private func sessionView(gymSession: GymSession) -> some View {
        VStack {
            // Header VStack
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Weekday:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding([.top, .bottom], 2)
                    Spacer()
                    Text(gymSession.dayOfWeek)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding([.top, .bottom], 5)
                Divider()  // This provides a horizontal line separator
                HStack {
                    Text("Session:")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding([.top, .bottom], 2)
                    Spacer()
                    Text(gymSession.title)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                .padding([.top, .bottom], 5)
            }
            .padding(.horizontal)
            .background(Color(red: 0.8, green: 1.0, blue: 0.8, opacity: 0.2))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)


            // Custom Divider with shadow
            Rectangle()
                .fill(Color.gray.opacity(0.5))
                .frame(height: 1)
                .shadow(radius: 3)

            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Todays Exercises:")
                        .font(.headline)
                        .padding(.horizontal, 10)
                        .underline()
                    Spacer()

                    if let exercises = gymSession.exercises, !exercises.isEmpty {
                        ForEach(exercises, id: \.id) { exercise in
                            ExerciseView(exercise: exercise, binding: binding(for: exercise.id), exerciseData: exerciseData, showCheckboxes: showCheckBoxes, isLogViewActive: $showingLogView, isCalendarViewActive: $showingCalendarView)
                                .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
                            Divider()
                        }
                    } else {
                        EmptyStateInsideSession()
                            .border(Color.red, width: 2)

                    }
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
    }
    
    struct EmptyStateInsideSession: View {
        var body: some View {
            VStack(spacing: 20) {
                Image(systemName: "exclamationmark.triangle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)

                Text("No Exercises Today!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray.opacity(0.8))

                Text("Great job! Take a rest or consider adding an exercise for today.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()
            }
            .padding(.horizontal, 20)
            .padding(.top, 40) // Adjust padding as needed
        }
    }


    func binding(for id: UUID) -> Binding<Bool> {
        return .init(
            get: { exerciseData.exerciseSelectionStates[id, default: false] },
            set: { newValue in
                exerciseData.exerciseSelectionStates[id] = newValue
                exerciseData.saveCheckedExercises()
            }
        )
    }
}

struct ExerciseView: View {
    let exercise: Exercise
    var binding: Binding<Bool>
    var exerciseData: ExerciseData
    var showCheckboxes: Bool

    @Binding var isLogViewActive: Bool
    @Binding var isCalendarViewActive: Bool

    var body: some View {
        VStack {
            HStack(spacing: 10) {
                if showCheckboxes {
                    Toggle("", isOn: binding)
                        .toggleStyle(iOSCheckboxToggleStyle())
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(exercise.name)
                        .font(.headline)
                        .truncationMode(.middle)
                        .foregroundColor((exerciseData.exerciseSelectionStates[exercise.id, default: false] || isLogViewActive) ? .gray : .primary)
                    Text("Sets: \(exercise.Sets)")
                        .font(.subheadline)
                        .foregroundColor((exerciseData.exerciseSelectionStates[exercise.id, default: false] || isLogViewActive) ? .gray : .primary)
                    Text("Reps: \(exercise.Reps)")
                        .font(.subheadline)
                        .foregroundColor((exerciseData.exerciseSelectionStates[exercise.id, default: false] || isLogViewActive) ? .gray : .primary)
                }
                .fixedSize(horizontal: true, vertical: true)
            }
        }
        .background(
            GeometryReader { geometry in
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if showCheckboxes {
                            binding.wrappedValue.toggle()
                        }
                    }
            }
        )
    }
}


struct iOSCheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .renderingMode(.template)
                .font(.system(size: 25))
                .foregroundColor(configuration.isOn ? Color.green : .gray) // Change the color to green
            configuration.label
                .font(.subheadline)
        }
    }
}
