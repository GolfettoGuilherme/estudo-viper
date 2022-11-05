//
//  View.swift
//  estudo-viper
//
//  Created by Guilherme Golfetto on 05/11/22.
//

import Foundation
import UIKit

// ViewController
// protocol
// reference presenter

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController, AnyView {
   
    //-----------------------------------------------------------------------
    // MARK: - Private properties
    //-----------------------------------------------------------------------
    
    var presenter: AnyPresenter?
    var users: [User] = []
    
    //-----------------------------------------------------------------------
    // MARK: - Subviews
    //-----------------------------------------------------------------------
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    //-----------------------------------------------------------------------
    // MARK: - View lifecycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .systemRed
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = view.center
    }
    
    //-----------------------------------------------------------------------
    // MARK: - Private methods
    //-----------------------------------------------------------------------
    
    func update(with users: [User]) {
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.users = []
            self.tableView.isHidden = true
            self.label.isHidden = false
            self.label.text = error
        }
    }
    
}

//-----------------------------------------------------------------------
// MARK: - Tableview delegates
//-----------------------------------------------------------------------

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
}
