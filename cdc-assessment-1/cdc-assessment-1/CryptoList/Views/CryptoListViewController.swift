//
//  CryptoListViewController.swift
//  cdc-assessment-1
//
//  Created by Jacob Zhang on 2024/11/7.
//

import UIKit
import Combine

class CryptoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var tableView: UITableView!
    private var loadCryptoButton: UIButton!
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: CryptoListViewModel = CryptoListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        view.backgroundColor = .white

        loadCryptoButton = UIButton(type: .system)
        loadCryptoButton.setTitle(CDCStringConstants.loadCryptoTitle, for: .normal)
        loadCryptoButton.translatesAutoresizingMaskIntoConstraints = false
        loadCryptoButton.setTitleColor(.systemBlue, for: .normal)
        loadCryptoButton.addTarget(self, action: #selector(loadCrypto), for: .touchUpInside)

        view.addSubview(loadCryptoButton)
        NSLayoutConstraint.activate([
            loadCryptoButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CDCSpaceConstants.spaceXSmall),
            loadCryptoButton.heightAnchor.constraint(equalToConstant: CDCSpaceConstants.space100),
            loadCryptoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadCryptoButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])

        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.rowHeight = CDCSpaceConstants.cryptoCellHeight
        tableView.isHidden = false
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func bindViewModel() {
        viewModel.$cryptoList
            .sink { [weak self] cryptoList in
                DispatchQueue.main.async {
                    self?.tableView.isHidden = cryptoList.isEmpty
                    self?.tableView.reloadData()
                    self?.loadCryptoButton.isHidden = !cryptoList.isEmpty
                }
            }
            .store(in: &cancellables)

        viewModel.$hasError
            .filter { $0 }
            .sink { [weak self] _ in
                self?.showErrorAlert()
            }
            .store(in: &cancellables)
    }

    @objc private func loadCrypto() {
        viewModel.loadCryptoData()
    }

    private func showErrorAlert() {
        let alert = UIAlertController(title: CDCStringConstants.loadError, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CDCStringConstants.dismiss, style: .default, handler: nil))
        present(alert, animated: true)
    }

    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: viewModel.cryptoList[indexPath.row])
        return cell
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = CryptoDetailViewController()
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: true)
    }
}
