//
//  HomeController.swift
//  AssesmentApp
//
//  Created by Irfan Saeed on 26/10/2022.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtPrice: UITextField!
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tableFooterView = UIView()
            tableView.register(UINib(nibName: EventsCell.className, bundle: nil), forCellReuseIdentifier: EventsCell.className)
        }
    }
    @IBOutlet weak var searchButton: UIButton!
    
    
    //MARK: - Properties
    let viewModel = HomeViewModel()
    var filterArray = [Events]()
    var searchActive = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Assesment"
        hideKeyboard()
        fetchEvents()
    }
    
    //MARK: - Custom
    func reload() {
        if searchActive {
            if filterArray.isEmpty {
                tableView.setEmptyMessage("No results found")
            } else {
                tableView.restore()
            }
        } else {
            if viewModel.eventsArray().isEmpty {
                tableView.setEmptyMessage("No results found")
            } else {
                tableView.restore()
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @IBAction func didTapRefresh(_ sender: Any) {
        searchActive = false
        txtCity.text = nil
        txtPrice.text = nil
        reload()
    }
    
    
    @IBAction func didTapSearch(_ sender: UIButton) {
        let city = txtCity.text ?? ""
        let price = Int(txtPrice.text ?? "0") ?? 0
        
        if city.count == 0 && price == 0 {
            return
        }
        
        filterArray.removeAll()
        searchActive = true
        for item in viewModel.eventsArray() {
            if city.count != 0 && price > 0 {
                if item.city!.lowercased().contains(city.lowercased()) && item.price! <= price {
                    filterArray.append(item)
                }
            } else {
                if item.city!.lowercased().contains(city.lowercased()) {
                    filterArray.append(item)
                } else if item.price! <= price {
                    filterArray.append(item)
                }
            }
        }
        reload()
    }
    
    
    //MARK: - Fetch Events
    func fetchEvents() {
        viewModel.getEvents { [weak self] result in
            switch result {
            case .success(_):
                self?.reload()
            case .failure(let error):
                self?.showAlert(title: "Error", msg: error.localizedDescription)
            }
        }
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchActive ? filterArray.count : viewModel.eventsArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsCell.className, for: indexPath) as! EventsCell
        
        if searchActive{
            cell.populateData(objData: filterArray[indexPath.row])
        } else {
            cell.populateData(objData: viewModel.eventsArray()[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
