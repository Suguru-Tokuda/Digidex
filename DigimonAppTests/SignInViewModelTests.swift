//
//  SignInViewModelTests.swift
//  DigimonAppTests
//
//  Created by Suguru Tokuda on 11/9/23.
//

import XCTest
@testable import DigimonApp

final class SignInViewModelTests: XCTestCase {
    var vm: SignInViewModel!

    override func setUpWithError() throws {
        vm = SignInViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_isValidCredentials_BothNilEmailAndPassword_ExpectFalse() throws {
        let result = vm.isValidCredentials(email: nil, password: nil)
        XCTAssertFalse(result)
    }
    
    func test_isValidCredentials_NiEmail_ExpectFalse() throws {
        let result = vm.isValidCredentials(email: nil, password: "ThisIsAValidPassword1234")
        XCTAssertFalse(result)
    }
    
    func test_isValidCredentials_NilPassword_ExpectFalse() throws {
        let result = vm.isValidCredentials(email: "myemail@gmail.com", password: nil)
        XCTAssertFalse(result)
    }
    
    func test_isValidCredentials_InValidEmail_ExpectFalse() throws {
        let result = vm.isValidCredentials(email: "sajgjaljfdajgja", password: "ThisIsAValidPassword1234")
        XCTAssertFalse(result)
    }
    
    func test_isValidCredentials_ValidInputs_ExpectTrue() throws {
        let result = vm.isValidCredentials(email: "thisismyemail@gmail.com", password: "ThisIsAValidPassword1234")
        XCTAssertTrue(result)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
