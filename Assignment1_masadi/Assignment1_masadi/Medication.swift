//
//  Medication.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//
import Foundation

struct Medication {
    var datePrescribed: Date
    var name: String
    var dose: String
    var route: String
    var frequency: Int // Number of times per day
    var duration: Int // Duration in days
    
    // Computed property to check if the medication is completed
    var isCompleted: Bool { // Using Calendar.date I calculate the time spent since data prescribed to see whether the medication should be completed by now.
        let endDate = Calendar.current.date(byAdding: .day, value: duration, to: datePrescribed)
        return Date() > (endDate ?? Date()) // If for any reason endDate is not calculated properly, I'll use Date() as a default value which returns isCompleted = False to be safe.
    }
    
}

// Conforming to CustomStringConvertible protocol
extension Medication: CustomStringConvertible {
    var description: String {
        return "\(name) at \(dose) consumed via \(route), \(frequency) times per day for \(duration) days."
    }
}
