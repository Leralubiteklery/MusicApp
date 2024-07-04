//
//  MusicInteractor.swift
//  MusicApp
//
//  Created by Lera Savchenko on 4.07.24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MusicBusinessLogic {
  func makeRequest(request: Music.Model.Request.RequestType)
}

class MusicInteractor: MusicBusinessLogic {

  var presenter: MusicPresentationLogic?
  var service: MusicService?
  
  func makeRequest(request: Music.Model.Request.RequestType) {
    if service == nil {
      service = MusicService()
    }
  }
  
}
