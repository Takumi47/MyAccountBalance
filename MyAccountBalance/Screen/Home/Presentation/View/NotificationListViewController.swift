//
//  NotificationListViewController.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class NotificationListViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    private var viewModel: NotificationListViewModelProtocol
    private var notificationList: [DBMessage] = []
    
    // MARK: - View lifecycle

    init(viewModel: NotificationListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: NotificationListViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bind(to: viewModel)
    }

    // MARK: - Display logic
    
    private func setupViews() {
        title = "Notification"
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(navigateBack))
        tableView.register(UINib(nibName: "\(NotificationViewCell.self)", bundle: nil), forCellReuseIdentifier: NotificationViewCell.reuseId)
        
        viewModel.fetchLocalNotificationList()
    }

    private func bind(to viewModel: NotificationListViewModelProtocol) {
        viewModel.notificationListObservable.addObserver(id: "\(Self.self).notificationList") { [weak self] list in
            self?.notificationList = list
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Actions

    @objc private func navigateBack() {
        viewModel.navigateBack()
    }
}

// MARK: - UITableViewDataSource

extension NotificationListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationViewCell.reuseId, for: indexPath) as? NotificationViewCell
        let message = notificationList[indexPath.row]
        cell?.configure(isRead: message.status, dateTime: message.updateDateTime, title: message.title, message: message.message)
        return cell ?? UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension NotificationListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        128
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
