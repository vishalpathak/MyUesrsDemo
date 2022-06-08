//
//  UserTableViewCell.swift
//  CSVWithDI
//
//  Created by C879403 on 29/04/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    fileprivate let  cellAutoLayoutConstant = 16.0
    
    fileprivate let userFullName: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.textColor = .label
        name.numberOfLines = 0
        name.adjustsFontForContentSizeCategory = true
        name.font = UIFont.preferredFont(forTextStyle: .headline)
        return name
    }()
    
    fileprivate let rollNo: UILabel = {
        let roll = UILabel()
        roll.translatesAutoresizingMaskIntoConstraints = false
        roll.textColor = .label
        roll.numberOfLines = 0
        roll.adjustsFontForContentSizeCategory = true
        roll.font = UIFont.preferredFont(forTextStyle: .body)
        return roll
    }()
    
    fileprivate let userDOB: UILabel = {
        let dob = UILabel()
        dob.translatesAutoresizingMaskIntoConstraints = false
        dob.textColor = .label
        dob.numberOfLines = 0
        dob.adjustsFontForContentSizeCategory = true
        dob.font = UIFont.preferredFont(forTextStyle: .body)
        return dob
    }()
    
    var userInfoViewModel: UsersViewModel? {
        didSet{
            userFullName.text = userInfoViewModel?.name
            rollNo.text = ("\(userInfoViewModel?.rollNo ?? "")")
            userDOB.text = userInfoViewModel?.dob
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(userFullName)
        addSubview(rollNo)
        addSubview(userDOB)
        setUpAutoLayOut()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpAutoLayOut() {
        let constraints = [userFullName.topAnchor.constraint(equalTo: topAnchor, constant: cellAutoLayoutConstant),
                           userFullName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           userFullName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           rollNo.topAnchor.constraint(equalTo: userFullName.bottomAnchor, constant: cellAutoLayoutConstant),
                           rollNo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           rollNo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           userDOB.topAnchor.constraint(equalTo: rollNo.bottomAnchor, constant: cellAutoLayoutConstant),
                           userDOB.leadingAnchor.constraint(equalTo: leadingAnchor, constant: cellAutoLayoutConstant),
                           userDOB.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -cellAutoLayoutConstant),
                           userDOB.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -cellAutoLayoutConstant)]
        NSLayoutConstraint.activate(constraints)
    }

}
