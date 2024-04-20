//
//  TableViewController.swift
//  MAD_Ind04_Singamsetty_Bhavitha
//
//  Created by Singamsetty, Bhavitha on 4/20/24.
//

import UIKit

// Define a model for the state data
struct State {
    let name: String
    let nickname: String
}

// Define the Table View Controller class
class TableViewController: UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    // Array to hold the states data
    var states = [State]()
    // Activity Indicator property
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the activity indicator
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        // Start animating the activity indicator and fetch states
        activityIndicator.startAnimating()
        fetchStates()
    }

    // Fetch and parse JSON data from the server
    func fetchStates() {
        guard let url = URL(string: "https://cs.okstate.edu/~bsingam/Madstates.php") else {
            print("Invalid URL")
            activityIndicator.stopAnimating() // Stop animating if the URL is invalid
            return
        }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Ensure we stop the activity indicator and handle the data on the main thread
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
            }

            if let error = error {
                print("Error fetching data: \(error)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [[String: String]] {
                    self?.states = json.compactMap { dict in
                        guard let name = dict["name"], let nickname = dict["nickname"] else {
                            return nil
                        }
                        return State(name: name, nickname: nickname)
                    }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }

        task.resume()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return states.count
    }
  
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.nickname
        return cell
    }


    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
