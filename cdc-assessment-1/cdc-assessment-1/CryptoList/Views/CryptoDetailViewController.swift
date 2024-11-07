//
//  CryptoDetailViewController.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import UIKit

class CryptoDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapGesture() {
        dismiss(animated: true, completion: nil)
    }
}
