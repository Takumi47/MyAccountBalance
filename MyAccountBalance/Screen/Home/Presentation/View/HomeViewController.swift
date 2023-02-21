//
//  HomeViewController.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    
    // MARK: - Public properties

    private var viewModel: HomeViewModelProtocol

    // MARK: - Private properties

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // viewModel.viewWillAppear()
    }

    // MARK: - Display logic
    
    private func setupViews() {
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "avatar"), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = .init(image: UIImage(named: "bell_normal"), style: .plain, target: self, action: #selector(checkNotificationList))
    }
    
    private func bind(to viewModel: HomeViewModelProtocol) {
    }

    // MARK: - Actions

    // MARK: - Overrides

    // MARK: - Private functions
    
    @objc private func checkNotificationList() {
    }
}
