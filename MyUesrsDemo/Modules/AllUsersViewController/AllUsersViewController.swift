//
//  ViewController.swift
//  MyUesrsDemo
//
//  Created by C879403 on 08/06/22.
//

import UIKit

class AllUsersViewController: UIViewController {
    
    
    private let userCellIdentifier = "userCellIdentifier"
    private lazy var allUsersTableView: UITableView = {
        let tb = UITableView()
        tb.delegate = self
        tb.dataSource = self
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.backgroundColor = .systemBackground
        tb.register(UserTableViewCell.self, forCellReuseIdentifier: userCellIdentifier)
        return tb
    }()
    
    private var userDataArray: [UsersViewModel] = []
    private let homeViewModel: AllUsersViewModel
    
    init(homeViewModel: AllUsersViewModel) {
        self.homeViewModel = homeViewModel
        super.init(nibName: nil, bundle: nil)
        self.homeViewModel.output = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUIView()
        getDataFromViewModel()
    }
    
    func setUIView() {
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(getDataFromViewModel))
        self.navigationItem.rightBarButtonItem  = refresh
        self.navigationItem.title = "All Users"
        view.backgroundColor = .systemBackground
        view.addSubview(allUsersTableView)
        let views = ["table":self.allUsersTableView]
        var constraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[table]-0-|", options: NSLayoutConstraint.FormatOptions.alignAllTop, metrics: nil, views: views)
        self.view.addConstraints(constraints)
        let stringConstraint = "V:|-0-[table]-0-|"
        constraints = NSLayoutConstraint.constraints(withVisualFormat: stringConstraint, options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        self.view.addConstraints(constraints)
    }
    
    @objc func getDataFromViewModel() {
        homeViewModel.getDataFromAPI()
    }
}

extension AllUsersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allUsersTableView.dequeueReusableCell(withIdentifier: userCellIdentifier) as? UserTableViewCell  else {
            return UserTableViewCell()
        }
        let obj = userDataArray[indexPath.row]
        cell.userInfoViewModel = obj
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
extension AllUsersViewController: AllUsersModelOutput {
    func updateUsersViewModel(_ usersVM: [UsersViewModel]?, err: Error?) {
        if let userVM = usersVM {
            userDataArray = userVM
            DispatchQueue.main.async {
                self.allUsersTableView.reloadData()
            }
        } else {
            print(err!)
        }
    }
    
    
}

