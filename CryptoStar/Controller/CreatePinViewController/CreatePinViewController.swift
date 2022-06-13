//
//  CreatePINViewController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 04/06/2022.
//

import FirebaseAuth
import UIKit
class CreatePinViewController: BaseViewController {
    @IBOutlet private var numberTextField: UITextField!
    @IBOutlet private var createPinButton: UIButton!
    @IBOutlet private var numberCollectionView: UICollectionView!
    @IBOutlet private var navigationBarView: CustomNavigationBarView!
    private var pinCode = ""
    private var numberPads = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "", "0", ""]
    var isNotEmptyPin: Bool {
        return KeyChainManager.shared.getPinCode() != nil
    }

    var isCheckFaceID = false
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupTextField()
        setupCollectionView()
        setupTitleNavigationBarView(isCheckPIN: isNotEmptyPin)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let tabbarController = tabBarController as? BaseTabBarController {
            tabbarController.tabBarView.isHidden = true
            tabbarController.containerTabBarView.isHidden = true
            tabbarController.shadowTabbarView.isHidden = true
        }
    }

    private func setupTitleNavigationBarView(isCheckPIN: Bool) {
        if isCheckPIN {
            setupNavigationBarView(navigationBarView: navigationBarView,
                                   title: .verifyPIN)
        } else {
            setupNavigationBarView(navigationBarView: navigationBarView,
                                   title: .createPIN,
                                   notificationTitle: .securePIN)
        }
    }

    private func setupTextField() {
        numberTextField.addPadding(.left(15.scaleW))
        numberTextField.borderStyle = .none
        numberTextField.layer.masksToBounds = true
        numberTextField.layer.cornerRadius = 10.scaleW
        numberTextField.backgroundColor = .hexStringUIColor(color: .borderTextFieldColor)
        numberTextField.delegate = self
    }

    private func setupButton() {
        let textButton = isNotEmptyPin ? TitleNavigationBar.verifiPINButton : TitleNavigationBar.createPINButton

        createPinButton.setUpButton(text: textButton,
                                    background: .black,
                                    textColor: .white)

        createPinButton.addTarget(self,
                                  action: #selector(actionCreatePinCoin),
                                  for: .touchUpInside)
    }

    private func setupCollectionView() {
        numberCollectionView.delegate = self
        numberCollectionView.dataSource = self
        numberCollectionView.register(aClass: NumberCollectionViewCell.self)
    }

    // MARK: - - SAVE PIN IN KEYCHAIN

    @objc func actionCreatePinCoin() {
        guard let text = numberTextField.text else {
            showAlert(title: .empty, message: "Not Data")
            return
        }
        if isNotEmptyPin, let pinCode = KeyChainManager.shared.getPinCode() {
            if pinCode == text {
                UserDefaultUtils.isFaceID = isCheckFaceID
                popViewController()
            } else {
                showAlert(title: .errorTextField, message: "Wrong password")
            }
        } else {
            KeyChainManager.shared.setPinCode(pinCode: text)
            UserDefaultUtils.isFaceID = true
            popViewController()
        }
    }



    @IBAction func createPinCoin(_ sender: Any) {
        guard let text = numberTextField.text else {
            showAlert(title: .empty, message: "Not Data")
            return
        }
        print("Pin : \(text)")
        if isNotEmptyPin, let pinCode = KeyChainManager.shared.getPinCode() {
            if pinCode == text {
                UserDefaultUtils.isFaceID = isCheckFaceID
                popViewController()
            } else {
                showAlert(title: .errorTextField, message: "Wrong password")
            }
        } else {
            KeyChainManager.shared.setPinCode(pinCode: text)
            UserDefaultUtils.isFaceID = true
            popViewController()
        }
    }
}

extension CreatePinViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}

extension CreatePinViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberPads.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(aClass: NumberCollectionViewCell.self, indexPath: indexPath)
        if indexPath.item == numberPads.count - 1 {
            print("HOT : \(indexPath.row)")
            cell.setupImageButton()
        }
        cell.setupNumberButton(text: numberPads[indexPath.item])
        
        return cell
    }
}

extension CreatePinViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == numberPads.count - 1 && pinCode.isNotEmpty {
            pinCode.removeLast()
        } else if pinCode.count < Limit.password {
            pinCode.append(numberPads[indexPath.item])
        }

        numberTextField.text = pinCode
    }
}

extension CreatePinViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ((numberCollectionView.frame.size.height ) / 4)
        let width = ((numberCollectionView.frame.size.width) / 3)
        return CGSize(width: width, height: height)
    }
}
