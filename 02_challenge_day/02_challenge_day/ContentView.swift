//
//  ContentView.swift
//  02_challenge_day
//
//  Created by Henry Chon on 12/9/22.
//
// https://www.hackingwithswift.com/100/swiftui/19
// https://www.hackingwithswift.com/example-code/system/how-to-convert-units-using-unit-and-measurement
// https://github.com/clarknt/100-days-of-swiftui/tree/main/02-ChallengeDay1

import SwiftUI
import Foundation

struct ContentView: View {
    enum Types: String {
        case Temperature = "Temperature"
        case Length = "Length"
        case Time = "Time"
        case Volume = "Volume"
    }
    
    enum TemperatureUnit: String {
        case Celsius = "Celsius"
        case Fahrenheit = "Fahrenheit"
        case Kelvin = "Kelvin"
    }
    
    @State private var selectedType = Types.Temperature.rawValue
    @State private var selectedOriginalUnit:String = TemperatureUnit.Celsius.rawValue
    @State private var selectedConvertedUnit:String = TemperatureUnit.Fahrenheit.rawValue
    @State private var value:Double = 0
    
    let type = [Types.Temperature.rawValue, Types.Length.rawValue, Types.Time.rawValue, Types.Volume.rawValue]
    
    let temperatureUnit: [String] = [TemperatureUnit.Celsius.rawValue, TemperatureUnit.Fahrenheit.rawValue, TemperatureUnit.Kelvin.rawValue]
    
    func converter() -> Double {
        let temperatureFormat = [
            TemperatureUnit.Celsius.rawValue: UnitTemperature.celsius,
            TemperatureUnit.Fahrenheit.rawValue: UnitTemperature.fahrenheit,
            TemperatureUnit.Kelvin.rawValue: UnitTemperature.kelvin,
        ]
        
        let original = Measurement(value: value, unit: temperatureFormat[selectedOriginalUnit]!)
        var converted:Double = 0
        
        if selectedConvertedUnit == TemperatureUnit.Celsius.rawValue {
            converted = original.converted(to: .celsius).value
        } else if selectedConvertedUnit == TemperatureUnit.Fahrenheit.rawValue {
            converted = original.converted(to: .fahrenheit).value
        } else if selectedConvertedUnit == TemperatureUnit.Kelvin.rawValue {
            converted = original.converted(to: .kelvin).value
        }
        
        return converted
    }
    
    var body: some View {
        NavigationView {
            Form {
//                Section {
//                    Picker("Type", selection: $selectedType) {
//                        ForEach(type, id: \.self) {
//                            Text($0)
//                        }
//                    }
//                }
                
                Section {
                    TextField("Temperature", value: $value, format: .number)
                    
                    Picker("", selection: $selectedOriginalUnit) {
                        ForEach(temperatureUnit, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section {
                    Text(String(format: "%.2f", converter()))
                    
                    Picker("", selection: $selectedConvertedUnit) {
                        ForEach(temperatureUnit, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("=")
                }
            }
            .navigationTitle("Temperature Converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

