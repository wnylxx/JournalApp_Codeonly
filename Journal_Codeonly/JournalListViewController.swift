//
//  ViewController.swift
//  Journal_Codeonly
//
//  Created by wonyoul heo on 5/17/24.
//

import UIKit

class JournalListViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
        
        navigationItem.title = "Journal"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addJournal))
    }
    
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let navigationController = UINavigationController(rootViewController: addJournalViewController)
        present(navigationController, animated: true)
    }


}

