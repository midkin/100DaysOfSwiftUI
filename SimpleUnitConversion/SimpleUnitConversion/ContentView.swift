//
//  ContentView.swift
//  SimpleUnitConversion
//
//  Created by Nick Dimitrakopoulos on 2/4/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputUnitType = "meters"
    @State private var outputUnitType = "km"
    @State private var inputValue = 100.0
    
    @FocusState private var isInputFocused: Bool
    
    private var outputValue: Double {
        
        switch (inputUnitType, outputUnitType) {
        case ("meters", "km") : return inputValue * 0.001
        case ("meters", "feet") : return inputValue * 3.2808399
        case ("meters", "yards") : return inputValue * 1.0936133
        case ("meters", "miles") : return inputValue * 0.000621371192
        case ("km", "meters") : return inputValue * 1_000.0
        case ("km", "feet") : return inputValue * 3_280.8399
        case ("km", "yards") : return inputValue * 1_093.6133
        case ("km", "miles") : return inputValue * 0.621371192
        case ("feet", "meters") : return inputValue * 0.3048
        case ("feet", "km") : return inputValue * 0.0003048
        case ("feet", "yards") : return inputValue * 0.333333333
        case ("feet", "miles") : return inputValue * 0.000189393939
        case ("yards", "meters") : return inputValue * 0.9144
        case ("yards", "km") : return inputValue * 0.0009144
        case ("yards", "feet") : return inputValue * 3.0
        case ("yards", "miles") : return inputValue * 0.000568181818
        case ("miles", "meters") : return inputValue * 1_609.344
        case ("miles", "km") : return inputValue * 1.609344
        case ("miles", "feet") : return inputValue * 5280.0
        case ("miles", "yards") : return inputValue * 1760.0
        default: return inputValue
        }
    }
    
    private let units = ["meters", "km", "feet", "yards", "miles"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Input unit type") {
                    Picker("Select unit for input", selection: $inputUnitType) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Output unit type") {
                    Picker("Select unit for input", selection: $outputUnitType) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Input value") {
                    TextField("Input Value", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }
                Section("Converted value") {
                    Text(outputValue.formatted())
                }
            }
            .navigationTitle("SimpleUnitConversion")
            .toolbar {
                if isInputFocused == true {
                    Button("Done") {
                        isInputFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
