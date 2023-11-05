//
//  Arrival.swift
//  flights
//
//  Created by Nata Kuznetsova on 03.11.2023.
//

import UIKit

final class Arrival: UITableViewController {
    
    private let networkService = NetworkService()
    private var models: [Flight] = []
    private var banner = Banner()
    private var bannerModel: Copyright = Copyright(text: "Нет данных", url: "Нет данных")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableView.reloadData()
        title = "Прилет"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    
        tableView.register(ArrivalCell.self, forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getArrival()
        getBanner()
    }
    
    private func setupViews() {
        self.view.addSubview(banner)
        setupConstraints()
    }

    private func setupConstraints() {
        banner.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([

            banner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            banner.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            banner.widthAnchor.constraint(equalToConstant: 340),
            banner.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? ArrivalCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.setupTextFlightDetails(arrival: model)
        return cell
        
    }
    
    
    func getArrival(){
        networkService.getArrival {[weak self] result in
            switch result {
            case .success(let arrival):
                self?.models = arrival
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            
        }
    }
    
    func getBanner(){
        networkService.getBanner{[weak self] result in
            switch result {
            case .success(let banner):
                self?.bannerModel = banner.copyright
                DispatchQueue.main.async {
                    self?.banner.setupTextBanner(banner: self?.bannerModel ?? Copyright(text: "Нет данных", url: "Нет данных"))
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            
        }
    }
    
    @objc func update() {
        networkService.getArrival { [weak self] result in
            switch result {
            case .success(let arrival):
                self?.models = arrival
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
            }
        }
    }
}

private extension Arrival {
    func showAlert(){
        let alert = UIAlertController(title: "Не удалось получить данные",
                                      message: "Данные актуальны на",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}




