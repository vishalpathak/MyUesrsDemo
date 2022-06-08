//
//  Extensions.swift
//  MyUesrsDemo
//
//  Created by C879403 on 08/06/22.
//

import Foundation

extension String {
    func convertDateFormat(strDT: String?, givenFormat: String, expectedFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = givenFormat
        guard let dt = strDT else { return nil}
        guard let date = dateFormatter.date(from: dt) else { return nil }
        dateFormatter.dateFormat = expectedFormat
        return  dateFormatter.string(from: date)
    }
}
