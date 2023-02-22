//
//  HomeViewController.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties

    var viewModel: HomeViewModelProtocol

    // MARK: - Private properties

    private var refreshControl: UIRefreshControl = .init()
    
    // MARK: - View lifecycle

    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: HomeViewController.self), bundle: nil)
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
        navigationController?.hidesBarsOnSwipe = true
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "avatar"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "bell_normal"), style: .plain, target: self, action: #selector(checkNotificationList))
        
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        viewModel.fetchEmptyNotificationList()
    }
    
    private func bind(to viewModel: HomeViewModelProtocol) {
        viewModel.isLoadingObservable.addObserver(id: "\(Self.self).isLoading") { [weak self] isLoading in
            isLoading ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
            self?.navigationController?.navigationBar.isUserInteractionEnabled = !isLoading
        }
        
        viewModel.notificationListObservable.addObserver(id: "\(Self.self).notificationList") { [weak self] list in
            self?.navigationItem.rightBarButtonItem?.isEnabled = !list.isEmpty
            
            let hasUnread = list.filter { $0.status == false }.count > 0
            if hasUnread {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(named: "bell_active")
            } else {
                self?.navigationItem.rightBarButtonItem?.image = UIImage(named: "bell_normal")
            }
        }
    }

    // MARK: - Actions

    @objc private func checkNotificationList() {
        viewModel.navigateToNotificationListView()
    }
    
    @objc private func loadData() {
        viewModel.fetchNotificationList()
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .init()
    }
}
