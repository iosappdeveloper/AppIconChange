//
//  ViewController.swift
//  AppIconChange
//
//  Created by Matoria, Ashok on 02/10/19.
//  Copyright © 2019 Matoria, Ashok. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    private var appIconButtons: [UIButton] = [
        UIButton(type: .system),
        UIButton(type: .system),
        UIButton(type: .system)
    ]
    private var buttonTitles = [
        "SuccessFactors",
        "CocaCola",
        "HSBC"
    ]
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        let label = UILabel()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.text = "Tap and select the app icon"
        let subViews: [UIView] = [label] + appIconButtons + [UIView()] // spacer view
        setupSubviews(subViews)
    }
    
    private func setupSubviews(_ subViews: [UIView]) {
        let stackView = UIStackView(arrangedSubviews: subViews)
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20).isActive = true
        
        setupAppIconButtons()
    }
    
    private func setupAppIconButtons() {
        let currentAppIcon = UIApplication.shared.alternateIconName
        for (index, title) in buttonTitles.enumerated() {
            var font = UIFont.preferredFont(forTextStyle: .title1)
            if currentAppIcon == title {
                font = UIFont.boldSystemFont(ofSize: font.pointSize)
            }
            appIconButtons[index].titleLabel?.font = font
            
            appIconButtons[index].setTitle(title, for: .normal)
            appIconButtons[index].addTarget(self, action: #selector(didTap(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func didTap(_ button: UIButton) {
        guard UIApplication.shared.supportsAlternateIcons else { return }
        if let title = button.title(for: .normal)?.split(separator: " ").first {
            UIApplication.shared.setAlternateIconName(String(title)) { (error) in
                print(error ?? "")
                self.setupAppIconButtons()
            }
        }
    }
}
