//
//  ContentView.swift
//  DemoBluetooth
//
//  Created by Steven Prichard on 10/2/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject
    var bleManager = BLEManager()
    
    var body: some View {
        VStack(spacing: 10) {
            Text("Bluetooth Devices")
                .font(.largeTitle)
                .frame(maxWidth: .infinity,  alignment: .center)
            List(bleManager.peripherals) { peripheral in
                HStack {
                    Text(peripheral.name)
                    Spacer()
                    Text(peripheral.advertisedName)
                    Spacer()
                    Text(String(peripheral.rssi))
                }
            }.frame(height: 300)
            
            Spacer()
            
            VStack() {
                Text("STATUS")
                    .font(.headline)
                if bleManager.isSwitchedOn {
                    Text("Bluetooth is switched on!")
                        .foregroundColor(.green)
                } else {
                    Text("Bluetooth is NOT switched on.")
                        .foregroundColor(.red)
                }
                Spacer()
                HStack() {
                    Button(action: {
                        bleManager.clearDevices()
                    }, label: {
                        Text("Clear Devices")
                    })
                    Spacer()
                    Button(action: {
                        bleManager.removeUnknowns()
                    }, label: {
                        Text("Remove Unknown Devices")
                    })
                }.padding()
            }
            
            Spacer()
            
            HStack {
                VStack(spacing: 10) {
                    Button(action: {
                        bleManager.startScanning()
                    }, label: {
                        Text("Start Scanning")
                    })
                    Button(action: {
                        bleManager.stopScanning()
                    }, label: {
                        Text("Stop Scanning")
                    })
                }.padding()
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        print("Start Advertising")
                    }, label: {
                        Text("Start Advertising")
                    })
                    Button(action: {
                        print("Stop Advertising")
                    }, label: {
                        Text("Stop Advertising")
                    })
                }.padding()
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
