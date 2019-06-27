//
//  DetailViewController.swift
//  UITestsDemo
//
//  Created by Russell Yeo on 11/06/2019.
//  Copyright © 2019 Russell Yeo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = detailDescriptionLabel {
                label.text = detail.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: Int? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

