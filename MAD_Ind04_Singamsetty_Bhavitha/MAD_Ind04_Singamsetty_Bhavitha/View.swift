//
//  View.swift
//  MAD_Ind04_Singamsetty_Bhavitha
//
//  Created by Singamsetty, Bhavitha on 4/21/24.
//
import Foundation

struct Parser {
    func parse(comp: @escaping ([StateDetail])->()) {
        let api = URL(string: "https://cs.okstate.edu/~bsingam/Madstates.php")

        URLSession.shared.dataTask (with: api!) {
            data, response, error in
            if error != nil {
                print (error?.localizedDescription as Any)
                return
                }
            do {
                let result = try JSONDecoder ().decode(state.self, from: data!)
                comp (result.Fetched_state_details)
            } catch {
                
            }
        }.resume()
    }
}

