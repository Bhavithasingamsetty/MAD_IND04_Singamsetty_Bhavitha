//
//  Model.swift
//  MAD_Ind04_Singamsetty_Bhavitha
//
//  Created by Singamsetty, Bhavitha on 4/21/24.
//

import Foundation
struct state: Codable {
    let Execution_Status: Bool
    let Fetched_state_details: [StateDetail]
}

// MARK: - StateDetail
struct StateDetail: Codable {
    let name, nickname: String
}
