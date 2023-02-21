//
//  AccountViewController.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/21.
//

import UIKit

class AccountViewController: UIViewController {

    // MARK: - View lifecycle

    init() {
        super.init(nibName: String(describing: AccountViewController.self), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
    }

    // MARK: - Display logic
    
    private func setupViews() {
    }
}
