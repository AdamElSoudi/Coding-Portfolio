//
//  PersonalBestsView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-05-23.
//

import SwiftUI

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PersonalBestsView: View {
    @EnvironmentObject var logEntries: LogEntries
    @AppStorage("displayInPounds") var displayInPounds: Bool = false
    @State private var showEditPBView: Bool = false
    @FocusState private var weightIsFocused: Bool
    
    var totalWeight: Double {
        let totalWeightInKg = logEntries.benchPressPB + logEntries.squatPB + logEntries.deadliftPB
        return displayInPounds ? totalWeightInKg * 2.20462 : totalWeightInKg
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                HStack {
                    Text("Personal Best (PB)")
                        .font(.system(size: 25))
                    
                    Spacer()
                    
                    Button(action: {
                        displayInPounds = false
                    }) {
                        Text("KG")
                            .fontWeight(displayInPounds ? .regular : .bold) // If KG is selected, text is bold. Otherwise, regular.
                            .foregroundColor(displayInPounds ? .gray : .green)
                            .padding()
                            .font(.system(size: 15))
                            .frame(width: 65, height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(displayInPounds ? Color.gray : Color.green, lineWidth: 2)
                            )
                    }

                    Button(action: {
                        displayInPounds = true
                    }) {
                        Text("LBS")
                            .fontWeight(displayInPounds ? .bold : .regular) // If LBS is selected, text is bold. Otherwise, regular.
                            .foregroundColor(displayInPounds ? .green : .gray)
                            .padding()
                            .font(.system(size: 15))
                            .frame(width: 65, height: 45)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(displayInPounds ? Color.green : Color.gray, lineWidth: 2)
                            )
                    }

                }
                .padding([.top, .bottom])
                
                ForEach(Lift.allCases, id: \.self) { lift in
                    HStack {
                        if lift == .benchPress {
                            Image(lift.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }
                        else if lift == .squat {
                            Image(lift.icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30)
                        }
                        else {
                            Image(systemName: lift.icon)
                                .font(.title2)
                                .foregroundColor(.green)
                                .frame(width: 30)
                        }
                        
                        
                        Text(lift.rawValue)
                            .font(.headline)
                        
                        Spacer()
                        
                        TextField("Enter PB", text: binding(for: lift))
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                            .focused($weightIsFocused)
                            .frame(width: 100, alignment: .center)
                        
                        Text(displayInPounds ? "lbs" : "kg")
                            .font(.headline)
                    }
                    .padding(.vertical, 10)
                }
//                Divider()
                
                
//
//                ForEach (Characteristic.allCases, id: \.self) { characteristic in
//                    HStack {
//                        if characteristic == .weight {
//                            Image(characteristic.icon)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 30)
//                        }
//                        else if characteristic == .height {
//                            Image(characteristic.icon)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 30)
//                        }
//                    }
//                }
                
                Text("Total of all lifts: \(String(format: "%.2f", totalWeight)) \(displayInPounds ? "lbs" : "kg")")
                    .font(.title)
                    .padding(.top)
            }
            .padding([.horizontal])
        }
        .onTapGesture {
            self.endEditing()
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                
                Button("Done") {
                    weightIsFocused = false
                }
            }
        }
    }
    
    private func binding(for lift: Lift) -> Binding<String> {
        let numberBinding: Binding<Double>
        switch lift {
        case .benchPress:
            numberBinding = $logEntries.benchPressPB
        case .squat:
            numberBinding = $logEntries.squatPB
        case .deadlift:
            numberBinding = $logEntries.deadliftPB
        }
        
        return Binding<String>(
            get: {
                let weight = numberBinding.wrappedValue
                if displayInPounds {
                    return String(format: "%.0f", weight * 2.20462)
                } else {
                    return String(format: "%.0f", weight)
                }
            },
            set: {
                if let weight = Double($0) {
                    numberBinding.wrappedValue = displayInPounds ? weight / 2.20462 : weight
                }
            }
        )
    }
    
    enum Lift: String, CaseIterable {
        case benchPress = "Bench Press"
        case squat = "Squat"
        case deadlift = "Deadlift"
        
        var icon: String {
            switch self {
            case .benchPress:
                return "benchPress"
            case .squat:
                return "squats"
            case .deadlift:
                return "figure.strengthtraining.traditional"
            }
        }
    }
    
    enum Characteristic: String, CaseIterable {
        case weight = "Weight"
        case height = "Height"
        
        var icon: String {
            switch self {
            case .weight:
                return "weight"
            case .height:
                return "height"
            }
        }
    }
    
    struct PersonalBestsView_Previews: PreviewProvider {
        static var previews: some View {
            let logEntries = LogEntries()
            logEntries.benchPressPB = 100
            logEntries.squatPB = 200
            logEntries.deadliftPB = 300
            return Group {
                PersonalBestsView().environmentObject(logEntries)
                PersonalBestsView().environmentObject(logEntries)
            }
        }
    }
}
