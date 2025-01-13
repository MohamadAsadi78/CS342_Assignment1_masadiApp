//
//  BloodTypeTests.swift
//  Assignment1_masadi
//
//  Created by Mohammad Asadi on 1/12/25.
//

import XCTest
@testable import Assignment1_masadi

class BloodTypeTests: XCTestCase {
    func testCanReceive() {
        XCTAssertTrue(BloodType.Ap.canReceive(from: .Ap))
        XCTAssertTrue(BloodType.Ap.canReceive(from: .An))
        XCTAssertTrue(BloodType.Ap.canReceive(from: .Op))
        XCTAssertTrue(BloodType.Ap.canReceive(from: .On))
        XCTAssertFalse(BloodType.Ap.canReceive(from: .Bp))
        
        XCTAssertTrue(BloodType.On.canReceive(from: .On))
        XCTAssertFalse(BloodType.On.canReceive(from: .Ap))
        
        XCTAssertTrue(BloodType.ABp.canReceive(from: .Bp))
        XCTAssertTrue(BloodType.ABp.canReceive(from: .On))
        XCTAssertTrue(BloodType.ABp.canReceive(from: .ABp))
    }
    
    func testCompatibleDonors() {
        XCTAssertEqual(BloodType.Ap.compatibleDonors(), [.Ap, .An, .Op, .On])
        XCTAssertEqual(BloodType.On.compatibleDonors(), [.On])
        XCTAssertEqual(BloodType.ABp.compatibleDonors(), BloodType.allCases) // AB+ is universal recipient
        XCTAssertEqual(BloodType.An.compatibleDonors(), [.An, .On])
    }
}
