//
//  DetailViewController.swift
//  sample
//
//  Created by ᗧ•• Lee on 2/6/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import UIKit



class SchoolSATDetailViewController: UIViewController {
 
    @IBOutlet weak var textView: UITextView!
 
    
    var viewModel: SchoolSATDetailViewModel?
 
    override func viewDidLoad() {
        super.viewDidLoad()
 
          setupView()
    }
    
    private func setupView() {
        // display the title
        self.navigationItem.title = "SAT Info"
        
        
        // once the viewModel set,
        // sat score is displayed on the textview
        // format is handled in the viewModel
        if let viewModel = self.viewModel{
            
            textView.attributedText = viewModel.description
        }
       
    }
    
    
  
   
}

