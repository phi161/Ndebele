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
    let webService = NdebeleWebService()
    let pollingService = PollingService()

    var previousRates: [Rate] = []
    var rates: [Rate] = []

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("MAIN_TITLE", comment: "The title of the main view")
        tableView.rowHeight = 120.0
        tableView.register(UINib.init(nibName: "RateTableViewCell", bundle: nil), forCellReuseIdentifier: RateTableViewCellIdentifier)

        fetchRates()
        pollingService.start()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification), name: pollingService.notificationName, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: pollingService.notificationName, object: nil)
    }

    // MARK: - Logic

    func fetchRates() {
        webService.rates { rates in
            self.previousRates = self.rates
            self.rates = rates
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Actions

    func handleNotification() {
        fetchRates()
    }

    @IBAction func refreshButtonTapped(_: Any) {
        fetchRates()
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
            if previousRates.isEmpty {
                cell.populate(rate: rates[indexPath.row])
            } else {
                // TODO: It will be safer to fetch the previous rate based on the currencyId instead of the indexPath
                cell.populate(rate: rates[indexPath.row], previous: previousRates[indexPath.row])
            }
        }
    }
}
