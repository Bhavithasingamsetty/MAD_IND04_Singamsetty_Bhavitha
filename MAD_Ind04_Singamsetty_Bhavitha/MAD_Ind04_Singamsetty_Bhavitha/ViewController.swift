//
//  ViewController.swift
//  MAD_Ind04_Singamsetty_Bhavitha
//
//  Created by Singamsetty, Bhavitha on 4/20/24.
//

import UIKit

struct State: Codable {
    let name: String
    let nickname: String
}

class ViewController: UITableViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var states = [State]() // Array to store state data
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        fetchStates()
    }
    
    // Fetch states from the server
    func fetchStates() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
        
        guard let url = URL(string: "https://cs.okstate.edu/~bsingam/Madstates.php") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }
            
            guard let self = self, let data = data, error == nil else {
                print("Error fetching states: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                self.states = try JSONDecoder().decode([State].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData() // Reload table data on main thread
                }
            } catch let jsonError {
                print("Failed to decode JSON: \(jsonError)")
            }
        }
        
        task.resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.nickname
        return cell
    }
}
