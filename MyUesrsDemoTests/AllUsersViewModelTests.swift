//
//  AllUsersViewModelTests.swift
//  MyUesrsDemoTests
//
//  Created by C879403 on 08/06/22.
//

import XCTest
@testable import MyUesrsDemo

class AllUsersViewModelTests: XCTestCase {

    private var sut: AllUsersViewModel!
    private var mockFetch: MockFetchAPIData!
    private var mockOutput: MockFetchOutput!
    
    override func setUpWithError() throws {
        mockFetch = MockFetchAPIData()
        sut = AllUsersViewModel(fetchData: mockFetch)
        mockOutput = MockFetchOutput()
        sut.output = mockOutput
        try super.setUpWithError()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        mockFetch = nil
        sut = nil
        mockOutput = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAllUsersSuccessCase() {
        //given
        let model = [HomeUsersModelElement(name: "MS John", rollNo: 1, division: nil, city: "", dob: "")]
        mockFetch.mockResult = .success(model)
        
        //when
        sut.getDataFromAPI()
        
        //then
        XCTAssertEqual(mockOutput.userArray.count, 1)
        XCTAssertEqual(mockOutput.userArray[0].name, "MS John")
    }
    
    func testAllUserFailureCase() {
        //given
        mockFetch.mockResult = .failure(NSError(domain: "", code: 10, userInfo: nil))
        
        //when
        sut.getDataFromAPI()
        
        //then
        XCTAssertEqual(mockOutput.error.localizedDescription, "The operation couldn’t be completed. ( error 10.)")
        //XCTAssertEqual(mockOutput.userArray[0].name, "MS John")
    }
    
    func testModelMapping() {
        let objCsv1 = HomeUsersModelElement(name: "MS John", rollNo: 11, division: "7", city: "Bangalore", dob: "01/02/1978")
        let objCsv2 = HomeUsersModelElement(name: "IP Head", rollNo: 24, division: "8", city: "Pune", dob: "01/02/1982")
        let allUsers = [objCsv1, objCsv2]
        let allViewModel = sut.mapAllUsersModelToViewModel(allUsers)
        XCTAssertNotNil(allViewModel)
    }
}

class MockFetchAPIData: FetchAPIData {
    var path: String = ""
    var method: String = ""
    
    var mockResult:Result<HomeUsersModel, Error>?
    
    func getAPIData(_ completion: @escaping (Result<HomeUsersModel, Error>?) -> Void) {
        if let result = mockResult {
            completion(result)
        }
    }
}

class MockFetchOutput: AllUsersModelOutput {
    var userArray: [UsersViewModel] = []
    var error: Error = NSError()
    
    func updateUsersViewModel(_ usersVM: [UsersViewModel]?, err: Error?) {
        if let usersVM = usersVM {
            userArray = usersVM
        } else {
            error = err!
        }
    }
}
