//
//  OneRepMaxView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-04-24.
//

import SwiftUI
import Combine

struct EnhancedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

let percentages = [
    100, 97, 94, 92, 89, 86, 83, 81, 78, 75,
    73, 71, 70, 68, 67, 65, 64, 63, 61, 60
]

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct OneRepMaxView: View {
    @State private var weight = ""
    @State private var reps = ""
    @State private var oneRepMaxResult: Double? = nil
    @State private var tapOutside = PassthroughSubject<Void, Never>()

    private var isInputValid: Bool {
        return !weight.isEmpty && !reps.isEmpty
    }
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Image(systemName: "dumbbell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.green)
                        .padding()
                    
                    Text("1RM Calculator")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("Calculate your One Rep Max based on the weight you can lift and how many reps you can do. The list below will show the estimated weights for other rep ranges.")
                        .font(.caption)
                        .padding([.leading, .trailing], 16)
                        .foregroundColor(.secondary)
                    
                    VStack(spacing: 10) {
                        RepresentableTextField(text: $weight, placeholder: "Weight (kg)", keyboardType: .decimalPad)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
                        
                        RepresentableTextField(text: $reps, placeholder: "Reps", keyboardType: .numberPad)
                            .padding()
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(10)
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.green, lineWidth: 1))
                    }
                    .padding(.horizontal)
                    
                    Button("Calculate 1RM") {
                        if isInputValid {
                            oneRepMaxResult = calculateOneRepMax(weight: weight, reps: reps)
                            UIApplication.shared.endEditing()
                        } else {
                            let alertMessage = "Please enter a weight and the number of reps."
                            let alert = UIAlertController(title: "Invalid input", message: alertMessage, preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default))
                            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
                        }
                    }
                    .buttonStyle(EnhancedButtonStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    
                    if let oneRepMax = oneRepMaxResult {
                        Text("Your One Rep Max: \(oneRepMax, specifier: "%.1f") kg")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        // Table Headers
                        HStack {
                            Text("1RM %")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                            Text("Weight")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                            Text("Reps")
                                .frame(maxWidth: .infinity)
                                .fontWeight(.bold)
                        }
                        .padding([.top, .bottom], 8)
                        .background(Color.green.opacity(0.2))
                        .padding([.leading, .trailing], 16)
                        
                        ForEach(1...20, id: \.self) { rep in
                            let percentage = calculatePercentageForReps(rep: rep)
                            let weight = oneRepMax * (percentage / 100)
                            HStack {
                                Text("\(Int(percentage))%")
                                    .frame(maxWidth: .infinity)
                                Text("\(weight, specifier: "%.1f") kg")
                                    .frame(maxWidth: .infinity)
                                Text("\(rep)")
                                    .frame(maxWidth: .infinity)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                        }
                    }
                }
                .background(TapOutsideHandler { tapOutside.send() })
                .onReceive(tapOutside) { _ in
                    UIApplication.shared.endEditing()
                }
                .padding(.bottom, 20)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.2), colorScheme == .dark ? Color.black : Color.white]), startPoint: .top, endPoint: .bottom))
        }
    }
    
    private func calculateOneRepMax(weight: String, reps: String) -> Double? {
        var weightWithPeriod = weight
        if weight.contains(",") {
            weightWithPeriod = weight.replacingOccurrences(of: ",", with: ".")
        }
        guard let weight = Double(weightWithPeriod), let reps = Double(reps), reps > 0 else { return nil }
        return weight / ((1.0278) - (0.0278 * reps))
    }
    
    private func calculatePercentageForReps(rep: Int) -> Double {
        if rep > 0 && rep <= percentages.count {
            return Double(percentages[rep - 1])
        } else {
            return 100.0
        }
    }
}

struct RepresentableTextField: UIViewRepresentable {
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        textField.keyboardType = keyboardType
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: context.coordinator, action: #selector(context.coordinator.donePressed))
        doneButton.tintColor = UIColor.green
        toolbar.setItems([UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        uiView.placeholder = placeholder
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: RepresentableTextField

        init(parent: RepresentableTextField) {
            self.parent = parent
        }

        @objc func donePressed() {
            UIApplication.shared.endEditing()
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                parent.text = updatedText
            }
            return true
        }
    }
}

struct TapOutsideHandler: UIViewRepresentable {
    var action: () -> Void

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.tap))
        view.addGestureRecognizer(gesture)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(action: action)
    }

    class Coordinator: NSObject {
        var action: () -> Void

        init(action: @escaping () -> Void) {
            self.action = action
        }

        @objc func tap() {
            action()
        }
    }
}

struct OneRepMaxView_Previews: PreviewProvider {
    static var previews: some View {
        OneRepMaxView()
    }
}
