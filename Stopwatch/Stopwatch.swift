//
//  Stopwatch.swift
//  Stopwatch
//
//  Created by Abdulaziz Al Mannai on 20/01/2025.
//

import Foundation

class Stopwatch {
    
    // The following function was fixed with assistance from ChatGPT.
    private var startTime: Date?

    func start() {
        startTime = Date()
    }

    func stop() {
        startTime = nil
    }

    var elapsedTime: TimeInterval {
        return startTime != nil ? -startTime!.timeIntervalSinceNow : 0
    }

    var elapsedTimeAsString: String {
        let time = elapsedTime
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time - Double(seconds)) * 10)
        return String(format: "%02d:%02d.%d", minutes, seconds, milliseconds)
    }

    var isRunning: Bool {
        return startTime != nil
    }
}
