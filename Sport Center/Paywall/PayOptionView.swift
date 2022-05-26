//
//  PayOptionView.swift
//  PurchaseTest
//
//  Created by Afraz Siddiqui on 5/26/22.
//

import Adapty
import UIKit

/// Interface for option view events delegate
protocol PayOptionViewDelegate: AnyObject {
    /// Notify delegate of selection
    /// - Parameters:
    ///   - optionView: View reference
    ///   - product: Product model
    func payOptionView(_ optionView: PayOptionView, didTapSelect product: ProductModel)
}

/// Single pay option view
final class PayOptionView: UIView {

    /// Delegate instance
    weak var delegate: PayOptionViewDelegate?

    /// Selection state
    public var isSelected: Bool = false {
        didSet {
            layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
        }
    }

    /// Related model
    private var product: ProductModel? {
        didSet {
            titleLabel.text = product?.localizedTitle
            subtitleLabel.text = product?.localizedDescription
            priceLabel.text = product?.localizedPrice
        }
    }

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUpTap()
        addSubviews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    /// Sets up interaction
    private func setUpTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
    }

    /// Adds all subviews
    private func addSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(priceLabel)
    }

    /// Sets up base config
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        backgroundColor = .clear
        isUserInteractionEnabled = true
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 2
    }

    /// Handle tap
    @objc private func didTap() {
        guard let product = product else {
            return
        }
        delegate?.payOptionView(self, didTapSelect: product)
    }

    /// Add constraints
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            subtitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor),

            priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            priceLabel.topAnchor.constraint(equalTo: topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    /// Configure view with Product
    /// - Parameters:
    ///   - product: Product
    ///   - theme: UI theme
    public func configure(with product: ProductModel, theme: PayWallView.ViewModel.Theme) {
        self.product = product
        switch theme {
        case .light:
            titleLabel.textColor = .black
            priceLabel.textColor = .black
            subtitleLabel.textColor = .black
        case .dark:
            titleLabel.textColor = .white
            priceLabel.textColor = .white
            subtitleLabel.textColor = .white
        }

    }
}
