//
//  HomeViewModel.swift
//  ARKitReference
//
//  Created by JOJI SAMUEL on 08/03/25.
//

import Foundation

protocol HomeViewModelProtocol {
    var homeItems: [String] { get set }
}

class HomeViewModel: HomeViewModelProtocol {
    
    var homeItems = ["Create 3D Object using SCNBox"]
    
}
