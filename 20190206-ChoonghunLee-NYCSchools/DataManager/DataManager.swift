//
//  DataManager.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/24/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation
import Alamofire


 

final class DataManager {
    
    typealias SchoolListDataCompletion = (SchoolData?, Error?) -> ()
    
    // this N.A is saved in case of some infomation is not available in json
    let naString = "N.A."
    
    
    // MARK: - Properties
    // url for shcool list and sat score
    private let schoolListURL: URL
    private let schoolSATURL: URL
    
    // MARK: - Initialization
    
    init(schoolListURL: URL, schoolSATURL : URL) {
        self.schoolListURL = schoolListURL
        self.schoolSATURL = schoolSATURL
    }

    
//     MARK: - Requesting Data
    func fetchSchoolListData( completion: @escaping SchoolListDataCompletion){

        let URL = schoolListURL
 
        // fetch school list
        Alamofire.request(URL).responseJSON { response   in

            switch(response.result){

            case .success :
                if let result = response.result.value,
                
                   let    listOfSchoolInfo = result as? [[String:String]]{
                    
                        // extract the necessary infomation from json response
                        // here for simplicity, name, email, website are extracted
                        // for unavailable information, default value naString used

                        let schoolListData = listOfSchoolInfo.map{  (dic : Dictionary )  -> NYCSchoolInfo    in
                         
                            let schoolName = dic["school_name"]   ?? self.naString
                            let schoolEmail = dic["school_email"]   ?? self.naString
                            let schoolWebsite = dic["website"]     ?? self.naString
                        
                            let nycSchoolInfo = NYCSchoolInfo(schoolName:schoolName, schoolWebsite : schoolWebsite, schoolEmail:schoolEmail)
                            
                            return nycSchoolInfo
                        
                        }
   
                        // after successful fetching school list, sat score fetched.
                        self.fetchSchoolSATData{  satScoreData, error in
                            
                            if let satScoreData = satScoreData {
                                
                                // score extractedd and saved in SchoolData
                                let schoolData = SchoolData(nYCschoolList: schoolListData, satScoreData :  satScoreData)
                                
                                      completion(schoolData, nil)
                                
                                
                            }else{
                                
                                      completion(nil, error)
                            }
                            
                        }
                    
                }else{
                       completion(nil, nil)
                }
                
            case .failure  :
              
                completion(nil, response.error)
             
            }
        }
    }

    
    func fetchSchoolSATData (  completion : @escaping  ( [SATScoreData]? ,Error? ) -> Void) {
    
        let URL = schoolSATURL;
        
           Alamofire.request(URL).responseJSON { response in
            switch(response.result){
                
            case .success :
                if let result = response.result.value, let satInfoList = result as?  [[String:String]]  {
               
                        let satInfo = satInfoList.map{  (dic : Dictionary )  -> SATScoreData    in
                            
                            // score extractedd and saved in SATScoreData
                            let satReading = dic["sat_ciritcal_reading_avg_score"]   ?? self.naString
                            let satMath = dic["sat_math_avg_score"]   ?? self.naString
                            let satWritting = dic["sat_writing_avg_score"]     ?? self.naString
                            let schoolName = dic["school_name"]     ?? self.naString
                            
                            let satInfo = SATScoreData(reading:satReading, math : satMath, writing:satWritting, schoolName : schoolName)
                            
                            return satInfo
                            
                        }
                        
                        
                        completion(satInfo, nil)
                    
                }else{
                    completion(nil, nil)
                }
                    
              
                
            case .failure  :
                
                completion(nil, response.error)
                
            }
        }
    }
}
