//
//  Departure.swift
//  flights
//
//  Created by Nata Kuznetsova on 03.11.2023.
//


import UIKit

class GroupsViewController: UITableViewController {
    
    private let networkService = NetworkService()
    private var models: Schedule
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        title = "Вылет"
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    
        tableView.register(DepartuleCell.self, forCellReuseIdentifier: "Cell")
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(update), for: .valueChanged)
        getDeparture()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let cell = cell as? DepartuleCell else {
            return UITableViewCell()
        }
        let model = models[indexPath.row]
        cell.setupTextGroups(group: model)
        return cell
        
    }
    
    
    func getDeparture(){
        networkService.getDeparture {[weak self] result in
            switch result {
            case .success(let departure):
                self?.models = departure
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchGroups() ?? []
                DispatchQueue.main.async {
                    self?.showAlert()
                }
            }
            
        }
    }
    
    
    @objc func update() {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.models = groups.response.items
                self?.fileCache.addGroups(groups: groups.response.items)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                self?.models = self?.fileCache.fetchGroups() ?? []
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

private extension GroupsViewController {
    func showAlert(){
        let date = DateHelper.getDate(date: fileCache.fetchGroupDate())
        let alert = UIAlertController(title: "Не удалось получить данные",
                                      message: "Данные актуальны на \(date)",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}




