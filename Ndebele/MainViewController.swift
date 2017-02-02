//
//  MainViewController.swift
//  Ndebele
//
//  Created by phi on 02/02/2017.
//  Copyright © 2017 phi161. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    let RateTableViewCellIdentifier = "RateTableViewCellIdentifier"

    var previousRates: [Rate] = []
    var rates: [Rate] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("MAIN_TITLE", comment: "The title of the main view")
        tableView.rowHeight = 100.0
        tableView.register(UINib.init(nibName: "RateTableViewCell", bundle: nil), forCellReuseIdentifier: RateTableViewCellIdentifier)
    }

    // MARK: - Actions

    @IBAction func refreshButtonTapped(_: Any) {
        let service = NdebeleWebService()
        service.rates { rates in
            self.previousRates = self.rates
            self.rates = rates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: RateTableViewCellIdentifier, for: indexPath)
    }

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? RateTableViewCell {
            cell.populate(rate: rates[indexPath.row])
        }
    }
}
