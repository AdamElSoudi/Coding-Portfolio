//  GymMemberView.swift
//  The Process
//
//  Created by Adam El Soudi on 2023-10-16.

import SwiftUI
import CodeScanner
import CoreImage.CIFilterBuiltins
import UIKit

struct GymMemberView: View {
    
    @State var presentingScannerView = false
    @State var scannedBarcode: String? = nil
    @Binding var isGymMemberViewActive: Bool
    @State var deletedBarcodes: [String] = UserDefaults.standard.array(forKey: "deletedBarcodes") as? [String] ?? []
    @State private var originalBrightness: CGFloat = 0.0
    @State private var animateBarcodeAppearance = false
    
    var barcodeImage: Image? {
        guard let barcodeString = scannedBarcode else { return nil }
        
        let context = CIContext()
        let filter = CIFilter(name: "CICode128BarcodeGenerator")
        let data = barcodeString.data(using: .ascii)
        filter?.setValue(data, forKey: "inputMessage")
        
        guard let ciImage = filter?.outputImage else { return nil }
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return Image(uiImage: UIImage(cgImage: cgImage))
    }
    
    struct ScannerOverlay: View {
        var body: some View {
            ZStack {
                Rectangle().fill(Color.black.opacity(0.7))
                RoundedRectangle(cornerRadius: 8)
                    .frame(width: 250, height: 80)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color.clear))
                    .blendMode(.destinationOut)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct ButtonPressEffect: ViewModifier {
        func body(content: Content) -> some View {
            content
                .scaleEffect(0.9)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
        }
    }
    
    func generateHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    var scanner: some View {
        ZStack {
            CodeScannerView(codeTypes: [.qr, .code128, .code39, .ean13, .ean8, .upce], completion: { result in
                if case let .success(code) = result {
                    self.scannedBarcode = code.string
                    UserDefaults.standard.setValue(code.string, forKey: "savedBarcode")
                    self.presentingScannerView = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        generateHapticFeedback()
                    }
                }
            })
            ScannerOverlay()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.1), Color.green.opacity(0.3)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                if geometry.size.width > geometry.size.height { // Landscape mode
                    VStack {
                        Spacer()  // Push content to center vertically
                        HStack {
                            Spacer()  // Push content to center horizontally
                            if let barcodeImage = barcodeImage {
                                barcodeImage
                                    .interpolation(.none)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 220)
                                    .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray5)))
                                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                                    .shadow(radius: 5)
                                    .opacity(animateBarcodeAppearance ? 1 : 0)
                                    .animation(.easeIn(duration: 0.5))
                                    .onAppear {
                                        self.animateBarcodeAppearance = true
                                    }
                            } else {
                                Text("No barcode scanned yet.")
                                    .padding()
                                    .font(.headline)
                            }
                            Spacer()  // Push content to center horizontally
                        }
                        Spacer()  // Push content to center vertically
                    }
                } else { // Portrait mode
                    VStack(spacing: 30) {
                        Text("Gym Member Access")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .shadow(radius: 2)
                        
                        if let barcodeImage = barcodeImage {
                            
                            barcodeImage
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 160)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color(.systemGray5)))
                                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray, lineWidth: 1))
                                .shadow(radius: 5)
                                .opacity(animateBarcodeAppearance ? 1 : 0)
                                .animation(.easeIn(duration: 0.5))
                                .onAppear {
                                    self.animateBarcodeAppearance = true
                                }
                            
                            if scannedBarcode == "50810204076" {
                                Text("ID: Adam El Soudi")
                                    .font(Font.custom("AvenirNext-Medium", size: 24))
                                    .bold()
                                    .underline()
                            }
                            
                            else if scannedBarcode == "50810233219" {
                                Text("ID: Rami El Soudi")
                                    .font(Font.custom("AvenirNext-Medium", size: 24))
                                    .bold()
                                    .underline()
                            }
                            
                            Text("Barcode Data: \(scannedBarcode ?? "Unknown Barcode")")
                                .font(.subheadline)
                                .padding(.vertical, -15)
                            
                        } else {
                            Text("No barcode scanned yet.")
                                .padding()
                                .font(.headline)
                        }
                        
                        if scannedBarcode == nil {
                            Image(systemName: "qrcode.viewfinder")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .padding(10)
                                .background(Color.green)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                        }
                        
                        createButtons()
                    }
                    .padding(.horizontal, 20)
                }
            }
            .onAppear {
                self.isGymMemberViewActive = true
                self.scannedBarcode = UserDefaults.standard.string(forKey: "savedBarcode")
                originalBrightness = UIScreen.main.brightness
                UIScreen.main.brightness = 1.0
            }
            .onDisappear {
                self.isGymMemberViewActive = false
                UIScreen.main.brightness = originalBrightness
            }
            .sheet(isPresented: $presentingScannerView) {
                self.scanner
            }
        }
    }
    
    func createButtons() -> some View {
        Group {
            Button(action: {
                handleBarcodeActions()
            }) {
                HStack {
                    Image(systemName: scannedBarcode == nil ? "qrcode" : "xmark")
                        .padding(.trailing, 5)
                    Text(scannedBarcode == nil ? "Scan Barcode" : "Clear Barcode")
                }
                .fontWeight(.semibold)
                .padding()
                .background(scannedBarcode == nil ? Color.green : Color.red)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .modifier(ButtonPressEffect())
            }
            
            if !deletedBarcodes.isEmpty && scannedBarcode == nil {
                Button(action: {
                    restoreLastDeletedBarcode()
                }) {
                    HStack {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                            .padding(.trailing, 5)
                        Text("Restore Last Deleted Barcode")
                    }
                    .fontWeight(.semibold)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .modifier(ButtonPressEffect())
                }
            }
        }
    }
    
    func handleBarcodeActions() {
        if let barcode = self.scannedBarcode {
            self.deletedBarcodes.append(barcode)
            UserDefaults.standard.set(self.deletedBarcodes, forKey: "deletedBarcodes")
            self.scannedBarcode = nil
            UserDefaults.standard.removeObject(forKey: "savedBarcode")
            generateHapticFeedback()
            self.animateBarcodeAppearance = false
        } else {
            self.presentingScannerView = true
        }
    }
    
    func restoreLastDeletedBarcode() {
        if let lastBarcode = deletedBarcodes.last {
            scannedBarcode = lastBarcode
            UserDefaults.standard.setValue(lastBarcode, forKey: "savedBarcode")
            deletedBarcodes.removeLast()
            UserDefaults.standard.set(self.deletedBarcodes, forKey: "deletedBarcodes")
            self.animateBarcodeAppearance = false
        }
    }
}


struct GymMemberView_Previews: PreviewProvider {
    static var previews: some View {
        GymMemberView(isGymMemberViewActive: .constant(true))
    }
}
