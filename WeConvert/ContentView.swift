//
//  ContentView.swift
//  WeConvert
//
//  Created by Kyle Warren on 6/6/22.
//

import SwiftUI



struct ContentView: View {
    @State private var userInput = 0.0
    @State private var originalUnit = UnitTemperature.celsius
    @State private var convertedUnit = UnitTemperature.fahrenheit
    @FocusState private var userInputIsFocused: Bool
    
    let units: [UnitTemperature] = [.celsius, .fahrenheit, .kelvin]
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: userInput, unit: originalUnit)
        let outputMeasurement = inputMeasurement.converted(to: convertedUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $userInput, format:
                    .number)
                    .keyboardType(.decimalPad)
                    .focused($userInputIsFocused)
                } header: {
                    Text("Temperature to Convert")
                }
                
                Section {
                    Picker("Starting Unit Of Measurement", selection: $originalUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Original Unit Of Measurement")
                }
                
                Section {
                    Picker("Converting Unit To", selection: $convertedUnit) {
                        ForEach(units, id: \.self) {
                            Text(formatter.string(from: $0).capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert Unit To")
                }
                
                Section {
                    Text(result)
                } header : {
                    Text("Converted Unit Of Measurement")
                }
            }
            .navigationTitle("WeConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        userInputIsFocused = false
                    }
                }
            }
        }
    }
    // Create and config measurement formatter
    init() {
        formatter = MeasurementFormatter()
        // Use the one we're telling you to use
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .short
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
