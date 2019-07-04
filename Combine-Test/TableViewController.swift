//
//  ViewController.swift
//  Combine-Test
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 26/06/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit
import Combine

class TableViewController: UITableViewController {
    
    private let pastebinService: PastebinService = PastebinService()
    private var cancellable: AnyCancellable?
    private var objects: [PastebinObject] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchObjects()
    }
    
    private func fetchObjects() {
        cancellable = pastebinService
            .getData()
            .catch({ _ in Publishers.Just([]) })
            .assign(to: \.objects, on: self)
    }
    
    deinit {
        cancellable?.cancel()
    }

}

// MARK: - UITableView Data Source
extension TableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
}

// MARK: - UITableView Delegate
extension TableViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let object = objects[indexPath.row]
        
        cell.textLabel?.text = object.user.name
        cell.detailTextLabel?.text = "\(object.likes)"
    }
    
}
