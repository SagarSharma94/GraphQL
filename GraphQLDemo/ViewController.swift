//
//  ViewController.swift
//  GraphQLDemo
//
//  Created by Rohit Gupta on 19/02/20.
//  Copyright © 2020 Sahabe Alam. All rights reserved.
//

import UIKit
import Apollo


class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        
        Network.shared.apollo.fetch(query: AllCategoryListQuery()) { result in
            print(result)

          switch result {
          case .success(let graphQLResult):
            print("Success! Result: \(graphQLResult)")
          case .failure(let error):
            print("Failure! Error: \(error)")
          }
        }
        
        // Do any additional setup after loading the view.
    }


}

