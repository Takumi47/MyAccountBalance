//
//  TabViewController.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class TabViewController: UIViewController {

    // MARK: - IBOutlets

    // MARK: - Public properties

    private var viewModel: TabViewModelProtocol

    // MARK: - Private properties

    // MARK: - View lifecycle

    init(viewModel: TabViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: TabViewController.self), bundle: nil)
    }

    private func bind(to viewModel: TabViewModelProtocol) {
//        viewModel.$observable.addObserver(id: "key") { [weak self] _ in
//            // do something with observed value
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.bind(to: viewModel)
        // viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // viewModel.viewWillAppear()
    }

    // MARK: - Display logic
    
    private func setupViews() {
      // TODO : setup views here
    }

    // MARK: - Actions

    // MARK: - Overrides

    // MARK: - Private functions
}
