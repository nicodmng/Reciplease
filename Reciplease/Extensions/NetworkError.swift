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

//extension NetworkError: CustomStringConvertible {
//    var description: String {
//        switch self {
//        case .noData:
//            return "Service momentanément indisponible"
//        case .invalidResponse:
//            return "Service momentanément indisponible"
//        case .undecodableData:
//            return "Service momentanément indisponible"
//        }
//    }
//}
