//
//  Workout.swift
//  SlimMiniProjet
//
//  Created by ESPRIT on 12/01/2020.
//  Copyright © 2020 ESPRIT. All rights reserved.
//
import Foundation

struct SWTWorkout {
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    var totalEnergyBurned: Double {
        
        let prancerciseCaloriesPerHour: Double = 450
        
        let hours: Double = duration/3600
        
        let totalCalories = prancerciseCaloriesPerHour*hours
        
        return totalCalories
    }
}
