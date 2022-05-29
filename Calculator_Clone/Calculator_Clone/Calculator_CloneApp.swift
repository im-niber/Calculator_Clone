//
//  Calculator_CloneApp.swift
//  Calculator_Clone
//
//  Created by rbwo on 2022/05/29.
//

import SwiftUI

@main
struct Calculator_CloneApp: App {
    @StateObject private var numberData = NumberModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(numberData)
        }
    }
}
