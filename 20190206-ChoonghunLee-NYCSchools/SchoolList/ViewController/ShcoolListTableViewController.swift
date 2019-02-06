//
//  MasterViewController.swift
//  sample
//
//  Created by ᗧ•• Lee on 2/6/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import UIKit

class ShcoolListViewController: UIViewController  {
 

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK : - data manager
     lazy var dataManager = {
        
        return DataManager(schoolListURL: API.SchoolListURL, schoolSATURL: API.SatScoreURL)
    }()
    
    var viewModel: SchoolListViewModel? {
        didSet {
            updateView()
        }
    }
    
 
    
    // MARK: - Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupView()
        fetchSchoolInfo ()
        
    }
 
     // set up the title and tableview
    private func setupView() {
        
        self.navigationItem.title = "School List"
        
        setupTableView()
    }
    

    
    // setup tableview
    private func setupTableView() {
        tableView.dataSource = self;
        
    }
    
        // MARK: - Fetch
    
    private func fetchSchoolInfo() {
        
       dataManager.fetchSchoolListData{ [unowned self] schoolData,  error in
         if let schoolData = schoolData{
            // after fetching school list & sat info data,
            // set the viewmodel
            self.viewModel = SchoolListViewModel(schoolData : schoolData)
            
         }else{
            
            // for some sever error, empty json etc,
            // popup the error message
            let alertController = UIAlertController(title: "Error", message: "server error Please, Try later", preferredStyle: UIAlertController.Style.alert)
 
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(alert :UIAlertAction!) in
                    print ("OK button tapped")
                })
                alertController.addAction(okAction)
                
            self.present(alertController, animated: true, completion: nil)
                
          
            
        }

       }
    }
    
    
      // MARK: - updateView
    
    private func updateView(){
        
        guard viewModel != nil else{ return }
        
        if(tableView != nil){
            tableView.reloadData()
        }

    }

   

 

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
  
             if let indexPath = tableView.indexPathForSelectedRow {

                let controller = (segue.destination as! SchoolSATDetailViewController)
                
                guard let schoolData = viewModel?.schoolData else{ return }
                
                
                // get the school info from the school list with indexrow
                var schoolInfo =  schoolData.nYCschoolList[indexPath.row]
                let schoolName = schoolInfo.schoolName
                
                
                // with school name, get the corresponding school sat score with filter function
                var satScoreData = schoolData.satScoreData.filter{ $0.schoolName.uppercased() == schoolName.uppercased() }
                
                
                if satScoreData.count == 0{
                // if the school is in the school list but not in the sat score list
                // then fill the school name only and other with "N.A"
                    if let viewModel = viewModel{
                        let (schoolListInfo, satData) = viewModel.emptySchoolData(schoolName : schoolName)
                            schoolInfo = schoolListInfo
                            satScoreData.append(satData)
                            
                        }
                    
                }
                
                
                // with the school infor and sat data, create viewModel for detail viewController
                controller.viewModel = SchoolSATDetailViewModel(schoolInfo: schoolInfo, satScoreData: satScoreData[0])
             
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true

            }
          }
        
        }
    
 


}



extension ShcoolListViewController : UITableViewDataSource{
    
    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSchool
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SchoolTableViewCell.reuseIdentifier, for: indexPath) as? SchoolTableViewCell else { fatalError("Unexpected Table View Cell") }
        
        if let viewModel = viewModel {
            
            cell.textLabel?.text = viewModel.name(for: indexPath.row)
            cell.textLabel?.lineBreakMode =  NSLineBreakMode.byWordWrapping
            cell.textLabel?.numberOfLines = 0
           
            
        }
        
        return cell
    }
    
    
}
