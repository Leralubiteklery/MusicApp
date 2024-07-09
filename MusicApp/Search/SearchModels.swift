//
//  SearchModels.swift
//  MusicApp
//
//  Created by Lera Savchenko on 4.07.24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getTracks(searchTerm: String)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks(searchResponse: SearchResponse?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
            }
        }
    }
}

struct SearchViewModel {
    struct Cell {
        var iconUrlString: String?
        var trackName: String
        var collectionName: String
        var artistName: String
    }
    
    let cells: [Cell]
}


