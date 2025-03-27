////
////  CreateScheduleView.swift
////  The Process
////
////  Created by Adam El Soudi on 2023-04-26.
////
//
//import SwiftUI
//
//struct CreateScheduleView: View {
//    
//    @ObservedObject var scheduleStore: ScheduleStore
//    
//    @State private var numWeeks = 1
//    @State private var daysPerWeek: [Int] = []
//    @State private var selectedDays: [[Int]] = []
//    @State private var dayTitles: [Int: String] = [:]
//    @State private var exercises: [Int: [Exercise]] = [:]
//    @State private var exerciseName = ""
//    @State private var sets = ""
//    @State private var reps = ""
//    @State private var restTime = ""
//    @State private var selectedWeekdays: [[String]] = Array(repeating: Array(repeating: "Select day", count: 1), count: 1)
//    
//    @State private var schedules: [String: Schedule] = [:]
//    @State private var currentScheduleName = ""
//    
//    @State private var step: Steps = .weeks
//    @State private var currentWeekIndex = 0
//    @State private var currentDayIndex = 0
//    
//    private let daysOfWeek = ["Select day", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//    
//    struct Schedule: Identifiable, Codable {
//        var id = UUID()
//        var numWeeks: Int
//        var daysPerWeek: [Int]
//        var selectedDays: [[Int]]
//        var dayTitles: [Int: String]
//        var exercises: [Int: [Exercise]]
//        var selectedWeekdays: [[String]]
//    }
//
//    enum Steps {
//        case weeks
//        case days
//        case exercises
//        case sessions
//    }
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                switch step {
//                case .weeks:
//                    weeksStep
//                case .days:
//                    daysStep
//                case .exercises:
//                    exercisesStep
//                case .sessions:
//                    sessionsStep
//                }
//            }
//            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    NavigationLink(destination: CalendarView(gymSessions: week1GymSessions + week2GymSessions)) {
//                        Image(systemName: "calendar")
//                            .font(.system(size: 18, weight: .bold, design: .rounded))
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 10)
//                            .background(Color.green)
//                            .cornerRadius(10)
//                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
//                    }
//                    .padding(.top, 5)
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    NavigationLink(destination: CreatedScheduleView(scheduleStore: scheduleStore)) {
//                        Image(systemName: "list.bullet.rectangle.fill")
//                            .font(.system(size: 18, weight: .bold, design: .rounded))
//                            .foregroundColor(.white)
//                            .padding(.horizontal, 16)
//                            .padding(.vertical, 10)
//                            .background(Color.green)
//                            .cornerRadius(10)
//                            .shadow(color: Color.black.opacity(0.3), radius: 3, x: 0, y: 2)
//                    }
//                    .padding(.top, 5)
//                }
//            }
//        }
//    }
//    
//    // MARK: - Weeks Step
//    private var weeksStep: some View {
//        VStack {
//            VStack {
//                Section(header: Text("Schedule Duration")) {
//                    Picker("Number of weeks", selection: $numWeeks) {
//                        ForEach(1...2, id: \.self) { week in
//                            Text("\(week)")
//                        }
//                    }
//                }
//            }
//            .padding()
//
//            nextButton(action: {
//                daysPerWeek = Array(repeating: 1, count: numWeeks)
//                selectedWeekdays = Array(repeating: Array(repeating: "Select day", count: 1), count: numWeeks)
//                step = .days
//            })
//        }
//        .padding()
//    }
//
//    
//    // MARK: - Days Step
//    private var daysStep: some View {
//        VStack{
//            Form {
//                ForEach(0..<numWeeks, id: \.self) { weekIndex in
//                    Section(header: Text("Week \(weekIndex + 1) - Days")) {
//                        daysPicker(weekIndex: weekIndex)
//                        
//                        if selectedWeekdays.indices.contains(weekIndex) {
//                            daySelection(weekIndex: weekIndex)
//                        }
//                    }
//                }
//            }
//            
//            HStack{
//                
//                backButton(action: { step = .weeks })
//                
//                nextButton(action: {
//                    selectedDays = daysPerWeek.map { _ in [] }
//                    step = .exercises
//                })
//            }
//        }
//        .padding()
//    }
//    
//    // MARK: - Exercises Step
//    private var exercisesStep: some View {
//        VStack {
//            Text("Add exercises for Week \(currentWeekIndex + 1), \(selectedWeekdays[currentWeekIndex][currentDayIndex])")
//                .font(.title)
//                .padding()
//
//            exerciseFields
//
//            addExerciseButton
//
//            VStack(alignment: .leading, spacing: 10) {
//                let dayIndex = currentWeekIndex * 7 + currentDayIndex
//                if !exercises[dayIndex, default: []].isEmpty {
//                    Text("Added Exercises:")
//                        .font(.headline)
//                        .padding(.horizontal, 10)
//                    List {
//                        ForEach(exercises[dayIndex, default: []], id: \.id) { exercise in
//                            Text("\(exercise.name) - \(exercise.Sets) sets, \(exercise.Reps) reps, \(exercise.RestTime) min rest")
//                        }
//                        .onDelete(perform: { indexSet in
//                            exercises[dayIndex, default: []].remove(atOffsets: indexSet)
//                        })
//                    }
//                }
//            }
//            .padding(.top, 20)
//
//            Spacer()
//
//            HStack{
//                backButton(action: { goToPreviousExerciseStep() })
//
//                nextDayButton
//            }
//            .padding(.horizontal)
//        }
//    }
//
//    // MARK: - Sessions Step
//    private var sessionsStep: some View {
//        VStack {
//            Text("Create Schedule")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .padding(.top)
//
//            TextField("Schedule Name", text: $currentScheduleName)
//                .padding(.horizontal, 40)
//                .padding(.vertical, 5)
//                .background(Color(.systemGray6))
//                .cornerRadius(5)
//                .padding(.bottom)
//
//            Form {
//                sessionsForEach
//            }
//
//            Spacer()
//
//            HStack {
//                backButton(action: { step = .exercises })
//
//                finishButton(action: {
//                    // Implement the save or finish action
//                })
//            }
//            .padding()
//        }
//        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.bottom))
//    }
//
//
//    
//    // MARK: - Subviews
//    
//    private func daysPicker(weekIndex: Int) -> some View {
//        Picker("Number of days", selection: Binding(
//            get: { daysPerWeek[weekIndex] },
//            set: { newValue in
//                daysPerWeek[weekIndex] = newValue
//                selectedWeekdays[weekIndex] = Array(repeating: "Select day", count: newValue)
//            }
//        )) {
//            ForEach(1...7, id: \.self) { day in
//                Text("\(day)")
//            }
//        }
//        .onChange(of: daysPerWeek[weekIndex]) { newValue in
//            selectedWeekdays[weekIndex] = Array(repeating: "Select day", count: newValue)
//        }
//    }
//    
//    private func daySelection(weekIndex: Int) -> some View {
//        ForEach(0..<daysPerWeek[weekIndex], id: \.self) { dayIndex in
//            Picker("Day \(dayIndex + 1)", selection: Binding(
//                get: { selectedWeekdays[weekIndex][dayIndex] },
//                set: { newValue in
//                    if !selectedWeekdays[weekIndex].contains(newValue) {
//                        selectedWeekdays[weekIndex][dayIndex] = newValue
//                    }
//                }
//            )) {
//                ForEach(availableDays(weekIndex: weekIndex, dayIndex: dayIndex), id: \.self) { day in
//                    Text(day)
//                }
//            }
//        }
//    }
//    
//    private var exerciseFields: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            Text("Exercise Name:")
//                .font(.headline)
//            TextField("Exercise Name", text: $exerciseName)
//                .padding(.horizontal, 5)
//                .padding(.vertical, 5)
//                .background(Color(.systemGray6))
//                .cornerRadius(5)
//            
//            Text("Sets:")
//                .font(.headline)
//            TextField("Sets", text: $sets)
//                .keyboardType(.numberPad)
//                .padding(.horizontal, 5)
//                .padding(.vertical, 5)
//                .background(Color(.systemGray6))
//                .cornerRadius(5)
//            
//            Text("Reps:")
//                .font(.headline)
//            TextField("Reps", text: $reps)
//                .keyboardType(.numberPad)
//                .padding(.horizontal, 5)
//                .padding(.vertical, 5)
//                .background(Color(.systemGray6))
//                .cornerRadius(5)
//            
//            Text("Rest Time (in minutes):")
//                .font(.headline)
//            TextField("Rest Time (in minutes)", text: $restTime)
//                .keyboardType(.numberPad)
//                .padding(.horizontal, 5)
//                .padding(.vertical, 5)
//                .background(Color(.systemGray6))
//                .cornerRadius(5)
//        }
//        .padding(.horizontal)
//    }
//
//    
//    // MARK: - Buttons
//    
//    private func nextButton(action: @escaping () -> Void) -> some View {
//        Button("Next", action: action)
//            .padding(.vertical, 12)
//            .padding(.horizontal, 60)
//            .background(Color.green)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//    }
//    
//    private func backButton(action: @escaping () -> Void) -> some View {
//        Button("Back", action: action)
//            .padding(.vertical, 12)
//            .padding(.horizontal, 60)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//    }
//    
//    private var addExerciseButton: some View {
//        Button(action: {
//            if let sets = Int(sets), let reps = Int(reps), let restTime = Int(restTime) {
//                let exercise = Exercise(name: exerciseName, Sets: sets, Reps: reps, RestTime: restTime)
//                let dayIndex = currentWeekIndex * 7 + currentDayIndex
//                exercises[dayIndex, default: []].append(exercise)
//                
//                // Clear input fields after adding the exercise
//                exerciseName = ""
//                self.sets = ""
//                self.reps = ""
//                self.restTime = ""
//            }
//        }) {
//            Text("Add Exercise")
//                .fontWeight(.bold)
//                .padding(.vertical, 12)
//                .padding(.horizontal, 60)
//                .background(Color.green)
//                .foregroundColor(.white)
//                .cornerRadius(10)
//        }
//        .padding(.top)
//    }
//
//    
//    private var nextDayButton: some View {
//        Button("Next Day") {
//            if currentDayIndex + 1 < daysPerWeek[currentWeekIndex] {
//                currentDayIndex += 1
//            } else if currentWeekIndex + 1 < numWeeks {
//                currentWeekIndex += 1
//                currentDayIndex = 0
//            } else {
//                step = .sessions
//            }
//        }
//        .padding(.vertical, 12)
//        .padding(.horizontal, 60)
//        .background(Color.green)
//        .foregroundColor(.white)
//        .cornerRadius(10)
//    }
//    
//    private func finishButton(action: @escaping () -> Void) -> some View {
//        Button("Finish", action: {
//            // Save the current schedule
//            let schedule = Schedule(numWeeks: numWeeks, daysPerWeek: daysPerWeek, selectedDays: selectedDays, dayTitles: dayTitles, exercises: exercises, selectedWeekdays: selectedWeekdays)
//            scheduleStore.schedules[currentScheduleName] = schedule
//            
//            // Clear the current schedule's data
//            numWeeks = 1
//            daysPerWeek = []
//            selectedDays = []
//            dayTitles = [:]
//            exercises = [:]
//            currentScheduleName = ""
//            selectedWeekdays = Array(repeating: Array(repeating: "Select day", count: 1), count: 1)
//            
//            // Go back to the first step
//            step = .weeks
//        })
//            .padding(.vertical, 12)
//            .padding(.horizontal, 60)
//            .background(Color.green)
//            .foregroundColor(.white)
//            .cornerRadius(10)
//    }
//
//    
//    // MARK: - Helpers
//    
//    private var sessionsForEach: some View {
//        ForEach(0..<numWeeks, id: \.self) { weekIndex in
//            ForEach(0..<daysPerWeek[weekIndex], id: \.self) { dayIndex in
//                let totalDayIndex = weekIndex * 7 + dayIndex
//                Section(header: Text("Gym Session for Week \(weekIndex + 1), \(selectedWeekdays[weekIndex][dayIndex])")) {
//                    TextField("Title", text: Binding(
//                        get: { dayTitles[totalDayIndex] ?? "" },
//                        set: { dayTitles[totalDayIndex] = $0 }
//                    ))
//
//                    ForEach(exercises[totalDayIndex] ?? [], id: \.id) { exercise in
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text(exercise.name)
//                                .font(.headline)
//                                .fontWeight(.bold)
//                            Text("Sets: \(exercise.Sets)")
//                            Text("Reps: \(exercise.Reps)")
//                            Text("Rest Time: \(exercise.RestTime) Min")
//                        }
//                        .padding(.bottom, 5)
//                    }
//                }
//            }
//        }
//    }
//
//    
//    private func goToPreviousExerciseStep() {
//        if currentDayIndex > 0 {
//            currentDayIndex -= 1
//        } else if currentWeekIndex > 0 {
//            currentWeekIndex -= 1
//            currentDayIndex = daysPerWeek[currentWeekIndex] - 1
//        } else {
//            step = .days
//        }
//    }
//    
//    private func availableDays(weekIndex: Int, dayIndex: Int) -> [String] {
//        var remainingDays = daysOfWeek
//        for (index, day) in selectedWeekdays[weekIndex].enumerated() {
//            if index != dayIndex, let i = remainingDays.firstIndex(of: day) {
//                remainingDays.remove(at: i)
//            }
//        }
//        if !remainingDays.contains(selectedWeekdays[weekIndex][dayIndex]) {
//            remainingDays.append(selectedWeekdays[weekIndex][dayIndex])
//        }
//        return remainingDays.sorted(by: { daysOfWeek.firstIndex(of: $0)! < daysOfWeek.firstIndex(of: $1)! })
//    }
//    
//    private func deleteExercise(at offsets: IndexSet, dayIndex: Int) {
//        exercises[dayIndex, default: []].remove(atOffsets: offsets)
//    }
//}
//
//struct CreateScheduleView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateScheduleView(scheduleStore: ScheduleStore())
//    }
//}
