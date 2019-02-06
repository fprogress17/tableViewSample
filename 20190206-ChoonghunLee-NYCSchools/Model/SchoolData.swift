//
//  CharacterData.swift
//  SimpsonsCharacterViewer
//
//  Created by ᗧ•• Lee on 2/6/19.
//  Copyright © 2019 ᗧ•• Lee. All rights reserved.
//

import Foundation
import UIKit


//// sat score data for detail page
///  it contains sat score and school name

struct SATScoreData {
    
    var reading : String
    var math : String
    var writing : String
    var schoolName : String
    
}


// school list infomation
// this data is from the school list url
// for simplicity, school name, website, email would be diplayed
// but later, it can be expandable
struct NYCSchoolInfo{
    
    var schoolName : String
    var schoolWebsite : String
    var schoolEmail : String
    
}


// main data structure
// it includes the school list from school list url
//  and sat info from sat score url
// but somehow some school info is in not sat socre list, then it diplayes "N.A"
// and other case, the school is not in the list but is in the satscore list, then it doesn't displayed in the list
//

struct SchoolData{
   
    var nYCschoolList : [NYCSchoolInfo] = []
    var satScoreData : [SATScoreData] = []
   
    
    
}
