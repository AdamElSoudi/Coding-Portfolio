//
//  WeightLogView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-10-14.
//

import SwiftUI

struct WeightLogView: View {
    @State private var currentWeight: String = ""
    @ObservedObject var weightLogEntries = WeightLogEntries()
    @State private var editingDate: String?
    @Binding var isWeightLogViewActive: Bool
    @State private var viewMode: ViewMode = .daily
    @FocusState private var amountIsFocused: Bool
    @State private var selectedDate: Date = Date()
    @State private var showDatePicker: Bool = true
    
    var sortedLogs: [(key: String, value: Double)] {
        return weightLogEntries.logs.sorted(by: { $0.key > $1.key })
    }
    
    var reversedSortedLogsForGraph: [(key: String, value: Double)] {
        return weightLogEntries.logs.sorted(by: { $0.key < $1.key })
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: viewMode == .daily ? 20 : 0) {
                Text("Log Your Weight")
                    .font(Font.custom("AvenirNext-Medium", size: 24))
                    .padding(.bottom, 20)
                    .foregroundColor(.green)

                Picker("View Mode", selection: $viewMode) {
                    Text("Daily").tag(ViewMode.daily)
                    Text("Weekly").tag(ViewMode.weekly)
                }
                .pickerStyle(SegmentedPickerStyle())

                if viewMode == .daily {
                    LineGraph(data: reversedSortedLogsForGraph.map { $0.value }, dates: reversedSortedLogsForGraph.map { $0.key })
                        .frame(height: 200)
                        .padding(.bottom, 20)
                } else {
                    weeklyStatisticsView()
                        .frame(height: 200)
                        .padding(.bottom, 20)
                        .padding(.top, 20)
                }

                HStack {
                    HStack {
                        TextField("Enter weight", text: $currentWeight)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                            .padding(.vertical, 7)
                            .padding(.horizontal)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .frame(minHeight: 44) // Add fixed height
                        
                        if showDatePicker {
                            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .labelsHidden()  // hides the label for a cleaner look
                                .frame(minHeight: 44) // Add fixed height
                        }
                        
                        if editingDate == nil {
                            Button(action: {
                                if !currentWeight.isEmpty {
                                    if let weight = Double(sanitizeInput(currentWeight)) {
                                        let logDate = DateFormatter.localizedString(from: selectedDate, dateStyle: .short, timeStyle: .none)
                                        weightLogEntries.addOrUpdateLog(date: logDate, weight: weight)
                                        amountIsFocused = false
                                        currentWeight = ""
                                    }
                                }
                            }) {
                                Text("Log")
                            }
                            .buttonStyle(WeightButtonStyle(backgroundColor: currentWeight.isEmpty ? .gray : .green))
                            .frame(minHeight: 44) // Add fixed height

                        } else {
                            HStack {
                                Button(action: {
                                    if let weight = Double(sanitizeInput(currentWeight)), let date = editingDate {
                                        weightLogEntries.addOrUpdateLog(date: date, weight: weight)
                                        currentWeight = ""
                                        editingDate = nil
                                    }
                                    showDatePicker = true // show the date picker again
                                }) {
                                    Text("Update")
                                }
                                .buttonStyle(WeightButtonStyle(backgroundColor: currentWeight.isEmpty ? .gray : .green))
                                .frame(minHeight: 44) // Add fixed height
                                
                                Button(action: {
                                    currentWeight = ""
                                    editingDate = nil
                                    showDatePicker = true // show the date picker again
                                }) {
                                    Text("Cancel")
                                        .foregroundColor(.red)
                                }
                                .frame(minHeight: 44) // Add fixed height
                            }
                        }
                    }
                    .padding(.bottom, 10)
                }
                        
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
                // Use a switch to conditionally display logs based on the viewMode
                switch viewMode {
                case .daily:
                    dailyLogView()
                case .weekly:
                    weeklyLogView()
                }
            }
            .padding()
            // Use the overlay to dismiss the keyboard
            .overlay(
                Rectangle()
                    .opacity(0)
                    .onTapGesture {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
            )
        }
        .ignoresSafeArea(.keyboard)
    }

    
    private func weeklyStatisticsView() -> some View {
        let weeklyLogsData = getWeeklyLogs()
        let totalLogs = weeklyLogsData.values.flatMap { $0.values }.count
        let totalWeight = weeklyLogsData.values.flatMap { $0.values }.reduce(0, +)
        let averageWeight = totalWeight / Double(totalLogs)
        
        return VStack(spacing: 15) {
            Text("Weekly Statistics")
                .underline()
            
            let streak = calculateStreak(sortedLogs: sortedLogs)
            statisticRow(title: "Streak", value: "\(streak) days", icon: "streak")
            
            statisticRow(title: "Average Weight", value: String(format: "%.2f kg", averageWeight), icon: "weight")
        }
        .padding()
        .cornerRadius(10)
        .frame(width: 350, height: 200)
        .border(Color.gray.opacity(0.5), width: 0.5)
        
    }

    private func statisticRow(title: String, value: String, icon: String) -> some View {
        HStack {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 36, height: 36)
                .foregroundColor(.gray)
                .background(Color.clear)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                
                Text(value)
                    .font(.title2)
                    .fontWeight(.semibold)
            }
            Spacer()
        }
    }


    
    func dailyLogView() -> some View {
        List {
            ForEach(sortedLogs.indices, id: \.self) { index in
                let entry = sortedLogs[index]
                
                if index % 10 == 0 && index != 0 {
                    Divider() // Add a divider after every 10 logs except for the first one.
                }
                
                HStack {
                    Text("Day \(sortedLogs.count - index)")
                    
                    Text(entry.key)
                    Spacer()
                    Text("\(entry.value, specifier: "%.2f") kg")
                    
                    Button(action: {
                        currentWeight = "\(entry.value)"
                        editingDate = entry.key
                        showDatePicker = false // Hide the date picker
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.green)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .onDelete(perform: deleteEntry)
        }
    }

    // Function to extract the week number from the week key string
    func extractWeekNumber(from weekKey: String) -> Int {
        let components = weekKey.components(separatedBy: CharacterSet.decimalDigits.inverted)
        return components.compactMap { Int($0) }.first ?? 0
    }
    
    func weeklyLogView() -> some View {
        List {
            // Sorting the keys numerically in descending order so that the latest week is on top
            ForEach(Array(getWeeklyLogs().keys).sorted(by: { extractWeekNumber(from: $0) > extractWeekNumber(from: $1) }), id: \.self) { weekKey in
                let logsForWeek = getWeeklyLogs()[weekKey] ?? [:]
                let isFullWeekLogged = logsForWeek.count == 7
                let isCurrentWeek = weekKey == getCurrentWeekKey()
                
                DisclosureGroup("\(weekKey) - \(logsForWeek.count)/7") {
                    ForEach(Array(logsForWeek.sorted(by: { $0.key > $1.key })), id: \.key) { date, weight in
                        HStack {
                            Text(date)
                            Spacer()
                            Text("\(weight, specifier: "%.2f") kg")
                            
                            Button(action: {
                                currentWeight = "\(weight)"
                                editingDate = date
                                showDatePicker = false // Hide the date picker
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.green)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                    }
                    
                    if isFullWeekLogged {
                        Image(systemName: "crown")
                            .foregroundColor(.yellow)
                    }
                }
                .foregroundColor(isCurrentWeek ? .green : nil) // Set text color to green for the current week
            }
        }
    }

    // Helper function to get the current week key
    func getCurrentWeekKey() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Get the current date
        let currentDate = Date()
        
        // Calculate the week number for the current date
        let calendar = Calendar.current
        let weekNumber = calendar.component(.weekOfYear, from: currentDate)
        
        return "Week \(weekNumber)"
    }
    
    func deleteEntry(at offsets: IndexSet) {
        if let first = offsets.first {
            let keyToDelete = sortedLogs[first].key
            if keyToDelete == editingDate {
                editingDate = nil
                currentWeight = ""
            }
            weightLogEntries.deleteLog(date: keyToDelete)
        }
    }
    
    func getWeeklyLogs() -> [String: [String: Double]] {
        var weeklyLogs: [String: [String: Double]] = [:]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let oldestEntryDate = dateFormatter.date(from: sortedLogs.last?.key ?? "") else {
            return weeklyLogs
        }
        
        for entry in sortedLogs {
            if let date = dateFormatter.date(from: entry.key) {
                let weekNumber = Calendar.current.dateComponents([.weekOfYear], from: oldestEntryDate, to: date).weekOfYear ?? 0
                let weekKey = "Week \(weekNumber + 1)"
                
                if var existingLogs = weeklyLogs[weekKey] {
                    existingLogs[entry.key] = entry.value
                    weeklyLogs[weekKey] = existingLogs
                } else {
                    weeklyLogs[weekKey] = [entry.key: entry.value]
                }
            }
        }
        return weeklyLogs
    }
    
    enum ViewMode {
        case daily, weekly
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

struct LineGraph: View {
    let forestGreen = Color(red: 0.0, green: 0.5, blue: 0.0)
    @State private var selectedDataPoint: Int? = nil
    var data: [Double]
    var dates: [String]

    var latestData: [Double] {
        Array(data.suffix(60))
    }

    var latestDates: [String] {
        Array(dates.suffix(60))
    }

    var gradient: Gradient {
        Gradient(colors: [forestGreen, Color.green])
    }

    var fixedMin: Double {
        latestData.min() ?? 0
    }

    var fixedMax: Double {
        latestData.max() ?? 0
    }

    var normalizedData: [CGFloat] {
        if let min = latestData.min(), let max = latestData.max(), max - min != 0 {
            return latestData.map { 1 - CGFloat(($0 - min) / (max - min)) }
        } else {
            return latestData.map { _ in 0 }
        }
    }

    func trajectorySlope(data: [Double]) -> Double {
        let n = Double(data.count)
        let xSum = (n - 1) * n / 2 // Arithmetic series formula
        let ySum = data.reduce(0, +)

        let xMean = xSum / n
        let yMean = ySum / n

        var num = 0.0
        var den = 0.0

        for i in 0..<data.count {
            num += (Double(i) - xMean) * (data[i] - yMean)
            den += pow(Double(i) - xMean, 2)
        }

        return num / den
    }

    var trajectory: String {
        let slope = trajectorySlope(data: latestData)
        if slope > 0 {
            return String(format: "↑ %.2f kg/week", slope)
        } else if slope < 0 {
            return String(format: "↓ %.2f kg/week", -slope)
        } else {
            return "→ 0.00 kg/week"
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient shading under the graph
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geometry.size.height))
                    for index in latestData.indices {
                        path.addLine(to: CGPoint(x: geometry.size.width / CGFloat(latestData.count - 1) * CGFloat(index),
                                                 y: geometry.size.height * normalizedData[index]))
                    }
                    path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height))
                }
                .fill(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                
                // Graph Line
                Path { path in
                    if !normalizedData.isEmpty {
                        path.move(to: CGPoint(x: 0, y: geometry.size.height * normalizedData[0]))
                        for index in 1..<latestData.count {
                            path.addLine(to: CGPoint(x: geometry.size.width / CGFloat(latestData.count - 1) * CGFloat(index),
                                                     y: geometry.size.height * normalizedData[index]))
                        }
                    }
                }
                .stroke(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                
                // Dots on graph
                ForEach(Array(latestData.indices), id: \.self) { index in
                    let point = CGPoint(x: geometry.size.width / CGFloat(latestData.count - 1) * CGFloat(index),
                                        y: geometry.size.height * normalizedData[index])
                    Circle()
                        .fill(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
                        .frame(width: selectedDataPoint == index ? 10 : 6, height: selectedDataPoint == index ? 10 : 6)
                        .position(point)
                        .onTapGesture {
                            selectedDataPoint = index
                        }
                }
                
                // Arrow for trajectory
                Text(trajectory)
                    .foregroundColor(.primary)
                    .position(x: geometry.size.width - 120, y: 30)
                    .font(.system(size: 16))
                
                // Y-axis Labels (reversed order)
                ForEach((0..<6).reversed(), id: \.self) { index in
                    let weightStep = (fixedMax - fixedMin) / 5.0
                    let weight = fixedMax - weightStep * Double(index) // Invert the order
                    Text(String(format: "%.1f", weight))
                        .position(x: 10, y: geometry.size.height * CGFloat(index) / 5.0) // Adjust x position
                }
                
                // Horizontal lines
                ForEach(0..<6) { index in
                    let heightFraction = CGFloat(index) / 5.0
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: geometry.size.height * heightFraction))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: geometry.size.height * heightFraction))
                    }
                    .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                }
                
                // Data tooltip
                if let selectedPoint = selectedDataPoint {
                    let point = CGPoint(x: geometry.size.width / CGFloat(latestData.count - 1) * CGFloat(selectedPoint),
                                        y: geometry.size.height * normalizedData[selectedPoint])
                    VStack {
                        Text("\(latestDates[selectedPoint]): \(latestData[selectedPoint], specifier: "%.2f") kg")
                            .padding(6)
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        Triangle()
                            .fill(Color.black.opacity(0.7))
                            .frame(width: 10, height: 6)
                    }
                    .position(x: point.x, y: point.y - 20)
                }
            }
        }
        .padding(.leading, 40)
    }
}






func calculateStreak(sortedLogs: [(key: String, value: Double)]) -> Int {
    let sortedDates = sortedLogs.map { $0.key }
    var streak = 0
    
    guard let mostRecentDate = sortedDates.first else { return 0 }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    var date = dateFormatter.date(from: mostRecentDate)!
    
    for _ in sortedDates {
        if sortedDates.contains(dateFormatter.string(from: date)) {
            streak += 1
            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        } else {
            break
        }
    }
    return streak
}

struct WeightButtonStyle: ButtonStyle {
    var backgroundColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 7)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}


func sanitizeInput(_ input: String) -> String {
    return input.replacingOccurrences(of: ",", with: ".")
}


// Preview for the WeightLogView
struct WeightLogView_Previews: PreviewProvider {
    @State static var isWeightLogViewActive = false
    
    static var previews: some View {
        let weightLog = WeightLogEntries()
        //weightLog.addOrUpdateLog(date: "2023-10-24", weight: 72.0)
        weightLog.addOrUpdateLog(date: "2023-10-23", weight: 71.8)
        weightLog.addOrUpdateLog(date: "2023-10-22", weight: 71.6)
        weightLog.addOrUpdateLog(date: "2023-10-21", weight: 71.4)
        weightLog.addOrUpdateLog(date: "2023-10-20", weight: 71.2)
        weightLog.addOrUpdateLog(date: "2023-10-19", weight: 71.0)
        weightLog.addOrUpdateLog(date: "2023-10-18", weight: 70.8)
        weightLog.addOrUpdateLog(date: "2023-10-17", weight: 70.6)
        weightLog.addOrUpdateLog(date: "2023-10-16", weight: 70.4)
        weightLog.addOrUpdateLog(date: "2023-10-15", weight: 70.2)
        weightLog.addOrUpdateLog(date: "2023-10-14", weight: 70.0)
        weightLog.addOrUpdateLog(date: "2023-10-13", weight: 69.8)
        weightLog.addOrUpdateLog(date: "2023-10-12", weight: 69.6)
        weightLog.addOrUpdateLog(date: "2023-10-11", weight: 69.4)
        weightLog.addOrUpdateLog(date: "2023-10-10", weight: 69.2)
        weightLog.addOrUpdateLog(date: "2023-10-09", weight: 69.1)
        weightLog.addOrUpdateLog(date: "2023-10-08", weight: 69.0)
        weightLog.addOrUpdateLog(date: "2023-10-07", weight: 68.9)
        weightLog.addOrUpdateLog(date: "2023-10-06", weight: 68.8)
        weightLog.addOrUpdateLog(date: "2023-10-05", weight: 68.7)
        weightLog.addOrUpdateLog(date: "2023-10-04", weight: 68.6)
        weightLog.addOrUpdateLog(date: "2023-10-03", weight: 68.5)
        weightLog.addOrUpdateLog(date: "2023-10-02", weight: 68.4)
        weightLog.addOrUpdateLog(date: "2023-10-01", weight: 68.3)
        weightLog.addOrUpdateLog(date: "2023-09-30", weight: 68.2)
        weightLog.addOrUpdateLog(date: "2023-09-29", weight: 68.1)
        weightLog.addOrUpdateLog(date: "2023-09-28", weight: 68.0)
        weightLog.addOrUpdateLog(date: "2023-09-27", weight: 67.9)
        weightLog.addOrUpdateLog(date: "2023-09-26", weight: 67.8)
        weightLog.addOrUpdateLog(date: "2023-09-25", weight: 67.7)
        weightLog.addOrUpdateLog(date: "2023-09-24", weight: 67.6)
        weightLog.addOrUpdateLog(date: "2023-09-23", weight: 67.5)
        weightLog.addOrUpdateLog(date: "2023-09-22", weight: 67.4)
        weightLog.addOrUpdateLog(date: "2023-09-21", weight: 67.3)
        weightLog.addOrUpdateLog(date: "2023-09-20", weight: 67.2)
        weightLog.addOrUpdateLog(date: "2023-09-19", weight: 67.1)
        weightLog.addOrUpdateLog(date: "2023-09-18", weight: 67.0)
        weightLog.addOrUpdateLog(date: "2023-09-17", weight: 66.9)
        weightLog.addOrUpdateLog(date: "2023-09-16", weight: 66.8)
        weightLog.addOrUpdateLog(date: "2023-09-15", weight: 66.7)
        weightLog.addOrUpdateLog(date: "2023-09-14", weight: 66.6)
        weightLog.addOrUpdateLog(date: "2023-09-13", weight: 66.5)
        weightLog.addOrUpdateLog(date: "2023-09-12", weight: 66.4)
        weightLog.addOrUpdateLog(date: "2023-09-11", weight: 66.3)
        weightLog.addOrUpdateLog(date: "2023-09-10", weight: 66.2)
        weightLog.addOrUpdateLog(date: "2023-09-09", weight: 66.1)
        weightLog.addOrUpdateLog(date: "2023-09-08", weight: 66.0)
        weightLog.addOrUpdateLog(date: "2023-09-07", weight: 65.9)
        weightLog.addOrUpdateLog(date: "2023-09-06", weight: 65.8)
        weightLog.addOrUpdateLog(date: "2023-09-05", weight: 65.7)
        weightLog.addOrUpdateLog(date: "2023-09-04", weight: 65.6)
        weightLog.addOrUpdateLog(date: "2023-09-03", weight: 65.5)
        weightLog.addOrUpdateLog(date: "2023-09-02", weight: 65.4)
        weightLog.addOrUpdateLog(date: "2023-09-01", weight: 65.3)
        weightLog.addOrUpdateLog(date: "2023-08-31", weight: 65.2)
        weightLog.addOrUpdateLog(date: "2023-08-30", weight: 65.1)
        weightLog.addOrUpdateLog(date: "2023-08-29", weight: 65.0)
        weightLog.addOrUpdateLog(date: "2023-08-28", weight: 64.9)
        weightLog.addOrUpdateLog(date: "2023-08-27", weight: 64.8)
        weightLog.addOrUpdateLog(date: "2023-08-26", weight: 64.7)
        weightLog.addOrUpdateLog(date: "2023-08-25", weight: 64.6)
        weightLog.addOrUpdateLog(date: "2023-08-24", weight: 64.5)
        weightLog.addOrUpdateLog(date: "2023-08-23", weight: 64.4)
        weightLog.addOrUpdateLog(date: "2023-08-22", weight: 64.3)
        weightLog.addOrUpdateLog(date: "2023-08-21", weight: 64.2)
        weightLog.addOrUpdateLog(date: "2023-08-20", weight: 64.1)
        weightLog.addOrUpdateLog(date: "2023-08-19", weight: 64.0)
        weightLog.addOrUpdateLog(date: "2023-08-18", weight: 63.9)
        weightLog.addOrUpdateLog(date: "2023-08-17", weight: 63.8)
        weightLog.addOrUpdateLog(date: "2023-08-16", weight: 63.7)
        weightLog.addOrUpdateLog(date: "2023-08-15", weight: 63.6)
        weightLog.addOrUpdateLog(date: "2023-08-14", weight: 63.5)
        weightLog.addOrUpdateLog(date: "2023-08-13", weight: 63.4)
        weightLog.addOrUpdateLog(date: "2023-08-12", weight: 63.3)
        weightLog.addOrUpdateLog(date: "2023-08-11", weight: 63.2)
        weightLog.addOrUpdateLog(date: "2023-08-10", weight: 63.1)
        weightLog.addOrUpdateLog(date: "2023-08-09", weight: 63.0)
        weightLog.addOrUpdateLog(date: "2023-08-08", weight: 62.9)
        weightLog.addOrUpdateLog(date: "2023-08-07", weight: 62.8)
        weightLog.addOrUpdateLog(date: "2023-08-06", weight: 62.7)
        weightLog.addOrUpdateLog(date: "2023-08-05", weight: 62.6)

        

        
        return WeightLogView(weightLogEntries: weightLog, isWeightLogViewActive: $isWeightLogViewActive)
    }
}
