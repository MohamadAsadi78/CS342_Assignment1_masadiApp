//
//  MedicationTests.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import XCTest
@testable import Assignment1_masadi

class MedicationTests: XCTestCase {
    func testIsCompleted() {
        let datePrescribed = Calendar.current.date(byAdding: .day, value: -10, to: Date())!
        let medication = Medication(datePrescribed: datePrescribed, name: "Paracetamol", dose: "500mg", route: "oral", frequency: 3, duration: 7)
        
        XCTAssertTrue(medication.isCompleted, "Medication should be completed after the duration.")
        
        let futureDate = Calendar.current.date(byAdding: .day, value: 2, to: Date())!
        let futureMedication = Medication(datePrescribed: futureDate, name: "Ibuprofen", dose: "200mg", route: "oral", frequency: 2, duration: 5)
        
        XCTAssertFalse(futureMedication.isCompleted, "Medication should not be completed before the duration.")
    }
    
    func testDescription() {
        let medication = Medication(datePrescribed: Date(), name: "Paracetamol", dose: "500mg", route: "oral", frequency: 3, duration: 7)
        
        let expectedDescription = "Paracetamol at 500mg consumed via oral, 3 times per day for 7 days."
        XCTAssertEqual(medication.description, expectedDescription, "Description does not match expected format.")
    }
}
