//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Lera Savchenko on 18.06.24.
//

import UIKit
import Alamofire


class SearchViewController: UITableViewController {
    
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var trackList = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        trackList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let track = trackList[indexPath.row]
        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image =  #imageLiteral(resourceName: "nirvana_bleach")
        
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search"
            let parameters = ["term":"\(searchText)",
                              "limit":"10"]
            
            AF.request(url, method: .get, parameters: parameters, encoder: URLEncoding.default, headers: nil).responseData { (dataResponse) in
                if let error = dataResponse.error {
                    print("Error received during requesting data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    print("object = \(objects)")
                    self.trackList = objects.results
                    self.tableView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON: \(jsonError)")
                }
                let someString = String(data: data, encoding: .utf8)
                print(someString ?? "")
            }
            })
            
            
        
    }
    
}

