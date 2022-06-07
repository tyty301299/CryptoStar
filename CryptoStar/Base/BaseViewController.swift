//
//  BaseController.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 19/05/2022.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("[HOT] \(className) init")

        
        let originFrame = self.view.frame
        dump(originFrame, name: "[ORIGIN_FRAME]")
        self.view.frame = CGRect(x: originFrame.minX, y: -125, width: originFrame.width, height: originFrame.height)

    }

    deinit {
        print("[HOT] \(self.className) deinit")
    }

    func setupNavigationBarView(navigationBarView: CustomNavigationBarView,
                                title: TitleNavigationBar,
                                notificationTitle: TitleNavigationBar = .isEmptyData) {

        navigationBarView.setupNavigationBarButton()
        navigationBarView.setupStyleNavigaitonBarLabel()
        navigationBarView.titleLabel.setTitle(title)
        navigationBarView.notificationLabel.isHidden = false
        navigationBarView.notificationLabel.setTitle(notificationTitle)
        navigationBarView.backButton.addTarget(self,
                                               action: #selector(actionBackViewController),
                                               for: .touchUpInside)
    }

    @objc func actionBackViewController() {
        popViewController()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

