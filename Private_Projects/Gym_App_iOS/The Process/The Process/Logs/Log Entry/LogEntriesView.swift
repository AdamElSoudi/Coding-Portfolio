//
//  LogEntriesView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-23.
//

import SwiftUI

enum SortOrder {
    case latest, earliest
}

struct LogEntriesView: View {
    @EnvironmentObject var logEntries: LogEntries
    @State private var showingLogEntriesView = false
    @State private var selectedLogEntry: LogEntry?
    @State private var sortOrder: SortOrder = .latest

    var groupedEntries: [Date: [LogEntry]] {
        Dictionary(grouping: logEntries.entries) { entry in
            Calendar.current.startOfDay(for: entry.date)
        }
    }

    var sortedDates: [Date] {
        let sortedKeys = groupedEntries.keys.sorted()
        return sortOrder == .latest ? sortedKeys.reversed() : sortedKeys
    }

    var body: some View {
        List {
            PersonalBestsView()
            ForEach(sortedDates, id: \.self) { date in
                Section(header: Text(dateString(from: date))) {
                    ForEach(groupedEntries[date]!) { logEntry in
                        VStack(alignment: .leading) {
                            HStack {
                                Text(logEntry.exercise)
                                    .font(.headline)

                                Spacer()

                                if let weight = logEntry.weight, let sets = logEntry.sets, let reps = logEntry.reps {
                                    Text(String(format: "%.2f kg x %d sets x %d reps", weight, sets, reps))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                } else if let distance = logEntry.distance, let time = logEntry.time {
                                    Text("\(distance) km in \(time) minutes")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedLogEntry = logEntry
                        }
                        .background(NavigationLink("", destination: EditLogEntryView(logEntries: logEntries, logEntry: logEntry), isActive: Binding(get: { selectedLogEntry?.id == logEntry.id }, set: { _ in selectedLogEntry = nil })).opacity(0))
                    }

                    .onDelete(perform: { indexSet in
                        deleteLogEntry(at: indexSet, for: date)
                    })
                }
            }
            .onTapGesture {
                self.endEditing()
            }
        }
        .navigationBarItems(trailing:
            Button(action: {
                sortOrder = sortOrder == .latest ? .earliest : .latest
            }, label: {
                Image(systemName: sortOrder == .latest ? "arrow.up.circle.fill" : "arrow.down.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            })
        )
    }

    private func deleteLogEntry(at offsets: IndexSet, for date: Date) {
        if let entriesForDate = groupedEntries[date] {
            let indices = offsets.map { entriesForDate[$0].id }
            logEntries.entries.removeAll { entry in
                indices.contains(entry.id)
            }
            logEntries.saveLogEntries()
        }
    }

    private func dateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

func endEditing() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

struct LogEntriesView_Previews: PreviewProvider {
    static var previews: some View {
        let logEntries = LogEntries()
        let sampleLogEntry = LogEntry(
            id: UUID(),
            exercise: "Squats",
            weight: 90,
            sets: 3,
            reps: 10,
            distance: nil,
            time: nil,
            date: Date(), notes: "Did 3 sets of 10 reps"
            // fill in any other fields here...
        )

        logEntries.entries.append(sampleLogEntry)
        return LogEntriesView()
            .environmentObject(logEntries)
    }
}
