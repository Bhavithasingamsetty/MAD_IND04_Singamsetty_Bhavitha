//
//  ViewController.swift
//  MAD_Ind04_Singamsetty_Bhavitha
//
//  Created by Singamsetty, Bhavitha on 4/20/24.
//

import UIKit

class ViewController: UIViewController {
    
    let parser = Parser()
    var state = [StateDetail]()
    
    
    @IBOutlet var TableView: UITableView!
    var spinner: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Structure to fetch details from server.
        // Initialize the spinner
                spinner = UIActivityIndicatorView(style: .large)
                spinner.center = self.view.center // Position the spinner in the center of ViewController
                spinner.hidesWhenStopped = true
                self.view.addSubview(spinner) // Add the spinner to the view
                
                // Start the spinner
                spinner.startAnimating()
        
        
        parser.parse {
            data in
            self.state = data
            DispatchQueue.main.async {
                self.TableView.reloadData()
                // Stop the spinner once the data is loaded
                                self.spinner.stopAnimating()
            }
        }
        TableView.dataSource = self

        // Do any additional setup after loading the view.
        }
}

extension ViewController: UITableViewDataSource {
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int)-> Int {
        return state.count
    }
    //Function to get count of records in the Table.
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StateCell", for: indexPath)
        cell.textLabel?.text = state[indexPath.row].name
        cell.detailTextLabel?.text = state[indexPath.row].nickname

        return cell
        }
    }


