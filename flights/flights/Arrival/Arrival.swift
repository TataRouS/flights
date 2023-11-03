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
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        title = "Прилет"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    
        tableView.register(ArrivalCell.self, forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getArrival()
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
        cell.setupTextFlightDetails(departure: model)
        return cell
        
    }
    
    
    func getArrival(){
        networkService.getArrival {[weak self] result in
            switch result {
            case .success(let departure):
                self?.models = departure
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
    
    
    @objc func update() {
        networkService.getArrival { [weak self] result in
            switch result {
            case .success(let departure):
                self?.models = departure
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




