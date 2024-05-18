//
//  ViewController.swift
//  Journal_Codeonly
//
//  Created by wonyoul heo on 5/17/24.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddAddJournalViewControllerDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    var sampleJournalEntryData = SampleJournalEntryData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sampleJournalEntryData.createSampleJournalEntryData()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell")
        
        
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
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sampleJournalEntryData.journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        cell.configureCell(journalEntry: journalEntry)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let jourNalEntry = sampleJournalEntryData.journalEntries[indexPath.row]
        let journalDetailViewController = JournalDetailViewController(journalEntry: jourNalEntry)
        show(journalDetailViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    // MARK: - Methods
    @objc private func addJournal() {
        let addJournalViewController = AddJournalViewController()
        let naviController = UINavigationController(rootViewController: addJournalViewController)
        addJournalViewController.delegate = self
        present(naviController, animated: true)
    }
    
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        sampleJournalEntryData.journalEntries.append(journalEntry)
        tableView.reloadData()
    }


}

