//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by 山田隼也 on 2019/08/19.
//  Copyright © 2019 Yamada Shunya. All rights reserved.
//

import UIKit
import RxCocoa

final class SettingsViewController: BaseViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var viewModel: SettingsViewModel!
    
    private let cellTapRelay: PublishRelay<Setting> = .init()
    private let settings: [Settings] = [
        Settings(desc: "Location settings", items: [.nowLocation, .setLocation, .updateLocation]),
        Settings(desc: "About this application", items: [.version, .about])
    ]
    
    // MARK: - Lifecycle
    
    static func instance() -> SettingsViewController {
        let settingsVC = SettingsViewController.newInstance()
        settingsVC.viewModel = .init(wireframe: SettingsWireframeImpl(viewController: settingsVC))
        return settingsVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
}

// MARK: - UI

extension SettingsViewController {
    
    func setupUI() {
        // Navigation
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = SettingsTableViewCell.rowHeight
        tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
    }
    
    func bindViewModel() {
        let input = type(of: viewModel).Input(cellTap: cellTapRelay)
        _ = viewModel.transform(input: input)
    }
}

// MARK: - TableView dataSource, delegate

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return settings[section].desc
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as! SettingsTableViewCell
        
        switch settings[indexPath.section].items[indexPath.row] {
        case .nowLocation:
            cell.setupCell(title: "Now location", content: "Toyota.jp")
        case .setLocation:
            cell.setupCell(title: "Set special location", content: nil)
        case .updateLocation:
            cell.setupCell(title: "Update location", content: nil)
        case .version:
            cell.setupCell(title: "Version", content: "0.01(beta)")
        case .about:
            cell.setupCell(title: "About this app", content: nil)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        cellTapRelay.accept(settings[indexPath.section].items[indexPath.row])
    }
}
