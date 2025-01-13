//
//  PatientTests.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import XCTest
@testable import Assignment1_masadi

class PatientTests: XCTestCase {
    func testFullNameWithAge() {
        let patient = Patient(
            firstName: "John",
            lastName: "Doe",
            dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!,
            height: 180,
            weight: 75
        )
        XCTAssertEqual(patient.fullNameWithAge(), "Doe, John (30)")
    }
    
    func testCurrentMedications() {
        let patient = Patient(
            firstName: "Alice",
            lastName: "Smith",
            dateOfBirth: Date(),
            height: 165,
            weight: 60
        )
        let oldMedication = Medication(
            datePrescribed: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            name: "Paracetamol",
            dose: "500mg",
            route: "oral",
            frequency: 3,
            duration: 7
        )
        let newMedication = Medication(
            datePrescribed: Date(),
            name: "Ibuprofen",
            dose: "200mg",
            route: "oral",
            frequency: 2,
            duration: 5
        )
        
        patient.medications = [oldMedication, newMedication]
        let currentMedications = patient.currentMedications()
        XCTAssertEqual(currentMedications.count, 1)
        XCTAssertEqual(currentMedications.first?.name, "Ibuprofen")
    }
    
    func testPrescribeMedication() throws {
        let patient = Patient(
            firstName: "Bob",
            lastName: "Johnson",
            dateOfBirth: Date(),
            height: 170,
            weight: 80
        )
        let medication = Medication(
            datePrescribed: Date(),
            name: "Amoxicillin",
            dose: "250mg",
            route: "oral",
            frequency: 3,
            duration: 10
        )
        
        try patient.prescribeMedication(medication)
        XCTAssertEqual(patient.medications.count, 1)
        
        XCTAssertThrowsError(try patient.prescribeMedication(medication)) { error in
            XCTAssertEqual(error as? MedicationError, MedicationError.duplicateMedication)
        }
    }
    
    func testCompatibleDonorBloodTypes() {
        let patient = Patient(
            firstName: "Charlie",
            lastName: "Brown",
            dateOfBirth: Date(),
            height: 160,
            weight: 55,
            bloodType: .Ap
        )
        
        XCTAssertEqual(patient.compatibleDonorBloodTypes(), [.Ap, .An, .Op, .On])
    }
}
