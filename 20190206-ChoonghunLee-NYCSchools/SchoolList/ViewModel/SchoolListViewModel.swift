//
//  CharacterViewModel.swift
//  sample
//
//  Created by ᗧ•• Lee on 1/24/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation

// this is view model for school list

struct SchoolListViewModel{
    
    // this school data has list of school and list of sat score
    var schoolData :  SchoolData
  
    // this NA is used for empty schoolInfo, sat data in case that shchool is in the school list
    // but not in the score data
    let NAStrig = "N.A."
    
    
    // this is called from tableview data source
    var numberOfSections: Int {
        return 1
    }
    
    // this is called from tableview data source
    var numberOfSchool : Int{
      
        return schoolData.nYCschoolList.count
      
    }
    
    // this is called from tableview data source
    func name(for index: Int) -> String {
        
        return schoolData.nYCschoolList[index].schoolName
       
    }
    
    
    func webSite(for index: Int) -> String {
        
         return schoolData.nYCschoolList[index].schoolWebsite
        
    }
    
    func email(for index : Int)->String{
        
          return schoolData.nYCschoolList[index].schoolEmail
        
    }
    
    
    // this   is used for empty schoolInfo, sat data in case that shchool is in the school list
    // but not in the score data
    func emptySchoolData(schoolName:String) -> (NYCSchoolInfo,SATScoreData) {
        
        let schoolInfo = NYCSchoolInfo(schoolName :schoolName, schoolWebsite :NAStrig, schoolEmail :NAStrig)
        let satData = SATScoreData(reading: NAStrig, math: NAStrig, writing: NAStrig, schoolName: schoolName)
        
        return (schoolInfo, satData)
       
    }
    
}
