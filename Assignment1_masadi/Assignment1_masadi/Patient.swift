//
//  Patient.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//
import Foundation

class Patient {
    // Static property for generating unique MedicalRecordNumbers
    private static var nextMedicalRecordNumber = 1
    
    // Instance properties
    let medicalRecordNumber: Int
    var firstName: String
    var lastName: String
    var dateOfBirth: Date
    var height: Double // in cm
    var weight: Double // in kg
    var bloodType: BloodType? // Blood type might not be known initially
    var medications: [Medication] = []
    
    // Initialization
    init(
        firstName: String,
        lastName: String,
        dateOfBirth: Date,
        height: Double,
        weight: Double,
        bloodType: BloodType? = nil
    ) {
        self.medicalRecordNumber = Patient.nextMedicalRecordNumber
        Patient.nextMedicalRecordNumber += 1 // Each time the nextMedicalRecordNumber in the Patient class itself (not the instance) increases by one to keep uniqueness.
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.height = height
        self.weight = weight
        self.bloodType = bloodType
    }
    
    // Private method to calculate the patient's age in years
    private func calculateAge() -> Int {
        let calendar = Calendar.current
        let now = Date() // current date
        let components = calendar.dateComponents([.year], from: dateOfBirth, to: now)
        // calculating difference between dateOfBirth and current date in years
        return components.year ?? 0 // Default value is 0 in case there was an unexpected problem in calculating the difference
    }
    
    // Method to return the patient’s full name and age
    func fullNameWithAge() -> String {
        let age = calculateAge()
        return "\(lastName), \(firstName) (\(age))"
    }
    
    // Method to return a list of current medications
    func currentMedications() -> [Medication] {
        medications.filter { !$0.isCompleted }.sorted { $0.datePrescribed > $1.datePrescribed }
        // Filtering by the isCompleted method of Medication defined in Medication struct and sorted by datePrescribed.
    }
    
    // Method to prescribe a new medication
    func prescribeMedication(_ newMedication: Medication) throws {
        // Check for duplicate medication by name, dose, and route
        if medications.contains(where: { $0.name == newMedication.name && $0.dose == newMedication.dose && $0.route == newMedication.route && !$0.isCompleted }) {
            throw MedicationError.duplicateMedication
        }
        medications.append(newMedication)
    }
    
    // Method to determine compatible donor blood types
    func compatibleDonorBloodTypes() -> [BloodType]? {
        guard let bloodType = bloodType else {
            return nil // Blood type not known
        }
        return bloodType.compatibleDonors()
    }
}

// Error type for medication issues
enum MedicationError: Error, CustomStringConvertible {
    case duplicateMedication
    
    var description: String {
        switch self {
        case .duplicateMedication:
            return "The medication is already prescribed and active."
        }
    }
}
