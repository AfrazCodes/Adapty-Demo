//
//  PayWallViewController.swift
//  PurchaseTest
//
//  Created by Afraz Siddiqui on 5/26/22.
//

import UIKit
import Adapty

/// Generic Pay Wall Controller
final class PayWallViewController: UIViewController, PayWallViewDelegate {

    /// Primary view instance
    private let primaryView = PayWallView()
    /// ViewModel instance
    private let viewModel: PayWallView.ViewModel

    // MARK: - Init

    /// Constructor
    /// - Parameter viewModel: ViewModel for view
    init(viewModel: PayWallView.ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(primaryView)
        primaryView.configure(with: viewModel)
        primaryView.delegate = self
        layout()
    }

    /// Adds constraints
    private func layout() {
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            primaryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    // MARK: - PayWallViewDelegate

    func payWallViewDidTapPurchase(_ paywall: PayWallView, product: ProductModel) {
        // TODO: Implement Adapty Purchase
        Adapty.makePurchase(product: product) { [weak self] purchaserInfo, receipt, appleValidationResult, product, error in

            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Purchased", message: "Welcome to VIP", preferredStyle: .alert)
                alert.addAction(.init(title: "Dismiss", style: .cancel) { [weak self] _ in
                    DispatchQueue.main.async {
                        self?.dismiss(animated: true)
                    }
                })
                self?.present(alert, animated: true)
            }
        }
    }
}
