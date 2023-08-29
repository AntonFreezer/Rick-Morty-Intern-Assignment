//
//  GenericViewController.swift
//  Rick&Morty Intern Assessment
//
//  Created by Anton Kholodkov on 29.08.2023.
//

import UIKit

class GenericViewController<T: UIView>: UIViewController {

  public var rootView: T { return view as! T }
    
  override open func loadView() {
     self.view = T()
  }

}
