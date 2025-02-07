//
//  Data.swift
//  FitnessApp
//
//  Created by Luan Nguyen on 24/12/2020.
//

import SwiftUI

// MARK: - DASHBOARD MENU DATA
let menus: [Models.DashboardMenu] = [
    Models.DashboardMenu(title: "Heart Rate", name: "bolt.heart.fill", unit: "bpm", currentValue: "120"),
    Models.DashboardMenu(title: "Disatance", name: "bolt", unit: "meter", currentValue: "290"),
    Models.DashboardMenu(title: "Water Intake", name: "drop", unit: "millilitre", currentValue: "480"),
    Models.DashboardMenu(title: "Temparature", name: "thermometer", unit: "degree", currentValue: "98.7")
]

// MARK: - BPM DATA
let bpms: [Models.BPM] = [
    Models.BPM(value: 86, time: "2 pm"),
    Models.BPM(value: 91, time: "3 pm"),
    Models.BPM(value: 84, time: "4 pm"),
    Models.BPM(value: 124, time: "5 pm"),
    Models.BPM(value: 148, time: "6 pm"),
    Models.BPM(value: 116, time: "7 pm")
]

// MARK: - HEART RATE MENU DATA
let heartRateMenus: [Models.HeartRateMenu] = [
    Models.HeartRateMenu(id: 0, name: "Resting", currentValue: 80),
    Models.HeartRateMenu(id: 1, name: "Gym", currentValue: 140)
]
