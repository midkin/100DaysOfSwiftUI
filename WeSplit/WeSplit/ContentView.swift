//
//  ContentView.swift
//  WeSplit
//
//  Created by Nick Dimitrakopoulos on 30/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipAmountPercentage = 10
    
    @FocusState private var amountIsFocused: Bool
    
    private var total: Double {
        checkAmount * (1.0 + Double(tipAmountPercentage) / 100) / Double(numberOfPeople)
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "Euro"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("Tip amount percentage") {
                    Picker("Tip amount percentage", selection: $tipAmountPercentage) {
                        ForEach(0..<101, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Grand total inclouding tip") {
                    Text(total * Double(numberOfPeople), format: .currency(code: Locale.current.currency?.identifier ?? "Euro"))
                }
                Section("Amount per person") {
                    Text(total, format: .currency(code: Locale.current.currency?.identifier ?? "Euro"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
