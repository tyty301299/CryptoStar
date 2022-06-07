//
//  SettingCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 04/06/2022.
//

import UIKit

class SettingCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var settingSwitch: UISwitch!
    @IBOutlet var dataSettingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpLabel()
        containerView.setCornerRadius(cornerRadius: 3)
    }

    private func setUpLabel() {
        dataSettingLabel.font = .sfProDisplay(font: .regular, size: 13.scaleW)
    }

    func setupData(data: String, index: Int) {
        dataSettingLabel.text = data
        settingSwitch.isHidden = index == 0 ? false : true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
