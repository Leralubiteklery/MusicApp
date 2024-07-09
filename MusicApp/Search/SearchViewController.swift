//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Lera Savchenko on 4.07.24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
  func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {

  var interactor: SearchBusinessLogic?
  var router: (NSObjectProtocol & SearchRoutingLogic)?
    
    @IBOutlet var table: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    private var searchViewModel = SearchViewModel.init(cells: [])
    private var timer: Timer?

  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = SearchInteractor()
    let presenter             = SearchPresenter()
    let router                = SearchRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  

  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
      setupSearchBar()
      setupTableView()
      setup()
  }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
  
  func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
      switch viewModel {
          
      case .some:
          print("viewController .some")
      case .displayTracks(let searchViewModel):
          print("viewController .displayTracks")
          self.searchViewModel = searchViewModel
          table.reloadData()
      }
  }
  
}

// MARK: - UITableViewDelegate, UITableViewDiffableDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let cellViewModel = searchViewModel.cells[indexPath.row]
        cell.textLabel?.text = "\(cellViewModel.trackName)\n\(cellViewModel.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image =  #imageLiteral(resourceName: "nirvana_bleach")
        return cell
    }
    
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: .getTracks(searchTerm: searchText))
        })
    }
}
