//
//  ContentView.swift
//  WeConvert
//
//  Created by Kyle Warren on 6/6/22.
//

import SwiftUI



struct ContentView: View {
    @State private var userInput = 0.0
    @State private var originalUnit = "°F"
    @State private var convertedUnit = "°C"
    
    let unitsOfMeasurement = ["°F", "°C", "°K"]
    
    var cToF: Double {
        (userInput * 9 / 5 + 32)
    }
    var fToC: Double {
        ((userInput - 32) * 5) / 9
    }
    var fToK: Double {
        ((userInput - 32) * 5) / 9 + 273.15
    }
    
    var kToF: Double {
        (userInput - 273.15) * 9 / 5 + 32
    }
    
    var cToK: Double {
        userInput + 273.15
    }
    
    var kToC : Double {
        userInput - 273.15
    }
    
    var finalConvertedValue: Double {
        switch (originalUnit, convertedUnit) {
        case ("°F", "°C"):
            return fToC
        case ("°F", "°K"):
            return fToK
        case ("°F", "°F"):
            return userInput
        case ("°C", "°F"):
            return cToF
        case ("°C", "°K"):
            return cToK
        case ("°C", "°C"):
            return userInput
        case ("°K", "°F"):
            return kToF
        case ("°K", "°C"):
            return kToC
        case ("°K", "°K"):
            return userInput
        default:
            print("Uh-oh")
        }
        return 0.0
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Temperature", value: $userInput, format:
                    .number)
                    .keyboardType(.decimalPad)
                }
                
                Section {
                    Picker("Starting Unit Of Measurement", selection: $originalUnit) {
                        ForEach(unitsOfMeasurement, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Original Unit Of Measurement")
                }
                
                Section {
                    Picker("Converting Unit To", selection: $convertedUnit) {
                        ForEach(unitsOfMeasurement, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert Unit To")
                }
                
                Section {
                    Text(finalConvertedValue, format: .number)
                } header : {
                    Text("Converted Unit Of Measurement")
                }
            }
            .navigationTitle("WeConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
