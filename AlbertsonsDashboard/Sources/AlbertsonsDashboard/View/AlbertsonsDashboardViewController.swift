//
//  AlbertsonsDashboardViewController.swift
//  
//
//  Created by Durgesh Lal on 1/25/23.
//

import Foundation

import UIKit
import Combine


final class AlbertsonsDashboardViewController: UIViewController {
    
    @IBOutlet weak var catImagevView: UIImageView!
    @IBOutlet weak var catFactTableView: UITableView!
    
    private let viewModel: AlbertsonsDashboardViewModel
    
    init?(_ viewModel: AlbertsonsDashboardViewModel, coder: NSCoder) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(viewModel:coder:)")     required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product list"
        catFactTableView.estimatedRowHeight = 44.0
        catFactTableView.rowHeight = UITableView.automaticDimension
        fetchCatFact()
    }
}

extension AlbertsonsDashboardViewController {
    private func fetchCatFact() {
        viewModel.fetchCatFact { [weak self] success in
            self?.catFactTableView.reloadData()
        }
    }
}

extension AlbertsonsDashboardViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.catFactAtIndex(indexPath.row)
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CatFactTableViewCell") as? CatFactTableViewCell {
            cell.updateCatFact(item)
            return cell
        }
        return UITableViewCell()
    }
}
