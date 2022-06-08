//
//  AllUsersViewModel.swift
//  MyUesrsDemo
//
//  Created by C879403 on 08/06/22.
//

import Foundation

struct UsersViewModel {
    
    let name: String?
    let dob: String?
    let rollNo: String?
    
    init(data: HomeUsersModelElement) {
        self.name = data.name
        self.dob = data.dob?.convertDateFormat(strDT: data.dob, givenFormat: "dd/MM/yyyy", expectedFormat: "dd MMM yyyy")
        self.rollNo = "\(data.rollNo ?? 0)"
    }
    
}

protocol AllUsersModelOutput: AnyObject {
    func updateUsersViewModel(_ usersVM: [UsersViewModel]?, err: Error?)
}

class AllUsersViewModel {
    
    weak var output: AllUsersModelOutput?
    private let fetchData: FetchAPIData
    
    init(fetchData: FetchAPIData) {
        self.fetchData = fetchData
    }
    
    func getDataFromAPI() {
        fetchData.getAPIData { [weak self] result in
            switch result {
            case .success(let viewModel):
                let viewModelArray = self?.mapAllUsersModelToViewModel(viewModel)
                self?.output?.updateUsersViewModel(viewModelArray, err: nil)
            case .failure(let error):
                self?.output?.updateUsersViewModel(nil, err: error)
            default: break
            }
        }
    }
    
    func mapAllUsersModelToViewModel(_ model: HomeUsersModel) -> [UsersViewModel]? {
        let modelArray = model.map { (obj: HomeUsersModelElement) -> UsersViewModel in
            return UsersViewModel(data: obj)
        }
        return modelArray
    }
}
