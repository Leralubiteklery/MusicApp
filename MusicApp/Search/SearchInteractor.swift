//
//  SearchInteractor.swift
//  MusicApp
//
//  Created by Lera Savchenko on 4.07.24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchBusinessLogic {
  func makeRequest(request: Search.Model.Request.RequestType)
}

class SearchInteractor: SearchBusinessLogic {

  var presenter: SearchPresentationLogic?
  var service: SearchService?
  
  func makeRequest(request: Search.Model.Request.RequestType) {
    if service == nil {
      service = SearchService()
    }
      
      switch request {
          
      case .some:
          print("interactor .some")
          presenter?.presentData(response: .presentTracks)
      case .getTracks:
          print("interactor .getTracks")
          presenter?.presentData(response: .presentTracks)
      }
      
  }
  
}
