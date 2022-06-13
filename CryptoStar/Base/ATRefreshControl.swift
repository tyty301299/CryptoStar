//
//  ATRefresh.swift
//  CryptoStar
//
//  Created by Nguyen Ty on 09/06/2022.
//
import UIKit

final class ATRefreshControl: UIControl {
    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        activity.style = .large
        activity.color = .red
        activity.startAnimating()
        return activity

    }()

    fileprivate var isChanged = false {
        didSet {
            switch self.isChanged {
            case true:
                activityIndicator.startAnimating()
            case false:
                activityIndicator.stopAnimating()
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addTarget(self, action: #selector(changeState), for: .valueChanged)
        addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        let constaints = [
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.heightAnchor.constraint(equalTo: heightAnchor),
            activityIndicator.widthAnchor.constraint(equalTo: heightAnchor),
        ]
    
        NSLayoutConstraint.activate(constaints)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func changeState() {
        isChanged = !isChanged
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isChanged = false
        }
    }

    func containingScrollViewDidEndDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -80 {
            sendActions(for: .valueChanged)
        }
    }

    func showLoadMore(_ scrollView: UIScrollView) {
        isHidden = false
        UIView.animate(withDuration: 0.33) {
            scrollView.contentInset.bottom = self.frame.height
        }
    }

    func hideLoadMore(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.3) {
            scrollView.contentInset.bottom = 0
        } completion: { _ in
            self.isHidden = true
        }
    }

    func didScroll(_ scrollView: UIScrollView) {
        guard scrollView.contentOffset.y >= -100, isChanged else { return }
        scrollView.contentOffset.y = -80
    }

    func didScrollDown(_ scrollView: UIScrollView) {
        frame.origin.y = scrollView.contentSize.height
    }
}

extension ATRefreshControl {
    func beingRefreshing(in scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.33) {
            scrollView.contentOffset.y = -110.scaleW
        }
    }

    func endRefreshing(in scrollView: UIScrollView) {
        scrollView.scrollRectToVisible(scrollView.frame, animated: true)
    }
}
