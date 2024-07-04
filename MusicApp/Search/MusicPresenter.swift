//
//  MusicPresenter.swift
//  MusicApp
//
//  Created by Lera Savchenko on 4.07.24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol MusicPresentationLogic {
  func presentData(response: Music.Model.Response.ResponseType)
}

class MusicPresenter: MusicPresentationLogic {
  weak var viewController: MusicDisplayLogic?
  
  func presentData(response: Music.Model.Response.ResponseType) {
  
  }
  
}
