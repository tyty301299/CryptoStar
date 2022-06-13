//
//  SettingCell.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 04/06/2022.
//

import UIKit
protocol SettingCellDelegate: class {
    func faceIDSwitchChanged(sender: SettingCell, onChanged: Bool)
}

class SettingCell: UITableViewCell {
    weak var delegate: SettingCellDelegate?
    @IBOutlet var containerView: UIView!
    @IBOutlet var settingSwitch: UISwitch!
    @IBOutlet var dataSettingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLabel()
        settingSwitch.isHidden = true
        containerView.setCornerRadius(cornerRadius: 1)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    @IBAction func actionFaceIDChanged(_ sender: Any) {
        delegate?.faceIDSwitchChanged(sender: self,
                                      onChanged: settingSwitch.isOn)
    }

    private func setUpLabel() {
        dataSettingLabel.font = .sfProDisplay(font: .regular, size: 13.scaleW)
    }

    func setupData(data: String) {
        dataSettingLabel.text = data
        if data.contains("TouchID/FaceID") {
            settingSwitch.isHidden = false
            settingSwitch.isOn = UserDefaultUtils.isFaceID
        } else {
            settingSwitch.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
}
