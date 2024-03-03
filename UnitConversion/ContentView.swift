//
//  ContentView.swift
//  UnitConversion
//
//  Created by Ramachandran Varadaraju on 01/03/24.
//

import SwiftUI

struct ContentView: View {
//    let lengthUnits = ["meter", "kilometer", "miles", "feets", "yards"]
    
    enum lengthUnits: String, CaseIterable {
        case meter, kilometer, mile, feet, yard
//        var id: String {self.rawValue}
    }
    
//    @State private var inputUnit = "meter"
    @State private var inputUnit: lengthUnits = .meter
    @State private var inputValue = 0.0
    @State private var outputUnit: lengthUnits = .feet
    @State private var outputValue = 0.0
    @FocusState private var isInputFocused: Bool
    
    var convertedUnit: Double{
        let enteredValue = inputValue
        
        var baseValue: Double = 0
        var outputValue: Double = 0
        
        let enteredUnit = inputUnit
        let outputUnit = outputUnit
        
        switch enteredUnit{
        case .feet:
            baseValue = enteredValue / 1
        case .kilometer:
            baseValue = enteredValue * 3280.84
        case .meter:
            baseValue = enteredValue * 3.28084
        case .mile:
            baseValue = enteredValue * 5280
        case .yard:
            baseValue = enteredValue * 3
        }
        
        switch outputUnit{
        case .feet:
            outputValue = baseValue * 1
        case .kilometer:
            outputValue = baseValue / 3280.84
        case .meter:
            outputValue = baseValue / 3.28084
        case .mile:
            outputValue = baseValue / 5280
        case .yard:
            outputValue = baseValue / 3
        }
        
        return outputValue
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Pick an input unit"){
                    Picker("Input unit", selection: $inputUnit){
                        ForEach(lengthUnits.allCases, id: \.self){
                            Text($0.rawValue)
                        }
                    }
                }
                .textCase(.none)
                Section("Pick an output unit"){
                    Picker("Output unit", selection: $outputUnit){
                        ForEach(lengthUnits.allCases, id: \.self){ unit in
                            Text(unit.rawValue)
                        }
                    }
                }
                .textCase(.none)
                Section("Enter the value you want to convert"){
                    TextField("Enter the length to convert", value: $inputValue, format: .number )
                        .keyboardType(.decimalPad)
                        .focused($isInputFocused)
                }
                .textCase(.none)
                Section("Here is the converted value"){
                    Text(convertedUnit, format: .number)
                }
                .textCase(.none)
            }
            .navigationTitle("Unit Conversion")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                if isInputFocused{
                    Button("Done"){
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
