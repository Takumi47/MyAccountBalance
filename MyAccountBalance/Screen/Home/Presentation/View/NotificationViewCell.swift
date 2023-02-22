//
//  NotificationViewCell.swift
//  MyAccountBalance
//
//  Created by xander on 2023/2/22.
//

import UIKit

class NotificationViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let reuseId = "\(NotificationViewCell.self)"
    
    @IBOutlet weak var statusImageView: UIImageView!
    @IBOutlet weak var updateDateTimeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUI()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clear()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUI()
    }
    
    // MARK: - Private Implementation
    
    private func initUI() {
    }
    
    private func setUI() {
    }
    
    private func clear() {
        statusImageView.isHidden = true
        updateDateTimeLabel.text = ""
        titleLabel.text = ""
        messageLabel.text = ""
    }
}

// MARK: - Methods

extension NotificationViewCell {
    func configure(isRead: Bool, dateTime: String, title: String, message: String) {
        statusImageView.isHidden = isRead
        updateDateTimeLabel.text = dateTime
        titleLabel.text = title
        messageLabel.text = message
    }
}
