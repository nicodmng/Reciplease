//
//  NetworkError.swift
//  Reciplease
//
//  Created by Nicolas Demange on 05/05/2022.
//

import Foundation

enum NetworkError: Error {
    case noData, invalidResponse, undecodableData
}

extension NetworkError: CustomStringConvertible {
    var description: String {
        switch self {
        case .noData:
            return "Service momentanément indisponible : no data"
        case .invalidResponse:
            return "Service momentanément indisponible : invalid response"
        case .undecodableData:
            return "Service momentanément indisponible : undecodable data"
        }
    }
}
