//
//  CreatePINViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 04/06/2022.
//

import UIKit

class CreatePINViewController: BaseViewController {
    @IBOutlet private weak var numberTextField: UITextField!
    @IBOutlet private weak var createPINButton: UIButton!
    @IBOutlet private weak var numberCollectionView: UICollectionView!
    @IBOutlet private weak var navigationBarView: CustomNavigationBarView!
    private var dataNumberTextField = ""
    private let spaceWidthCollectionCell:Double = 50
    private let spaceHeightCollectionCell:Double = 100
    private var dataCollectionViewCell = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", ""]
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupTextField()
        setupCollectionView()
        
        setupNavigationBarView(navigationBarView: navigationBarView,
                               title: .createPINButton,
                               notificationTitle: .securePIN)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = true
        }
    }
    func setupTextField(){
        numberTextField.borderStyle = .none
        numberTextField.layer.masksToBounds = true
        numberTextField.layer.cornerRadius = 10.scaleW
        numberTextField.backgroundColor = .hexStringUIColor(color: .borderTextFieldColor)
        numberTextField.delegate = self
    }
    func setupButton() {
        createPINButton.setUpButton(text: .createPIN,
                                    background: .black,
                                    textColor: .white)
        
        createPINButton.addTarget(self,
                                  action: #selector(createPINCoin),
                                  for: .touchUpInside)
    }

    func setupCollectionView() {
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        numberCollectionView.register(aClass: NumberCollectionViewCell.self)
    }

    
    //MARK: -- SAVE PIN IN KEYCHAIN
    @objc func createPINCoin() {
       
    }


}

extension CreatePINViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension CreatePINViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCollectionViewCell.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(aClass: NumberCollectionViewCell.self, indexPath: indexPath)
        if indexPath.item == dataCollectionViewCell.count - 1 {
            print("HOT : \(indexPath.row)")
            cell.setupImageButton()
        }
            cell.setupNumberbutton(text: dataCollectionViewCell[indexPath.item])
            
        return cell
    }
}

extension CreatePINViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == dataCollectionViewCell.count - 1 && dataNumberTextField.isNotEmpty {
            dataNumberTextField.removeLast()
        } else {
            dataNumberTextField.append(dataCollectionViewCell[indexPath.item])
        }
        numberTextField.text = dataNumberTextField
    }
}

extension CreatePINViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = ((numberCollectionView.frame.size.height - spaceHeightCollectionCell) / 4)
        let w = ((numberCollectionView.frame.size.width - spaceWidthCollectionCell) / 3)
        return CGSize(width: w, height: h)
    }
}

