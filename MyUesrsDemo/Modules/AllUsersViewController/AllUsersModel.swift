//
//  AllUsersModel.swift
//  MyUesrsDemo
//
//  Created by C879403 on 08/06/22.
//

import Foundation

// MARK: - HomeUsersModelElement
struct HomeUsersModelElement: Codable {
    let name: String?
    let rollNo: Int?
    let division, city, dob: String?
}

typealias HomeUsersModel = [HomeUsersModelElement]
