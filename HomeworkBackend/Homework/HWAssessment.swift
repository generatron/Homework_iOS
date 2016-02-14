/* 
Copyright (c) 2016 NgeosOne LLC
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

Engineered using http://www.generatron.com/

[GENERATRON]
Generator :   System Templates
Filename:     HWAssessment.swift
Description:  Class that holds the data for HWAssessment
Project:      Homework
Template: /PerfectSwift/server/Entity.swift.vm
 */


import PerfectLib

class HWAssessment  {
    var dateAssigned : NSDate!
    var dateDue : NSDate!
    var id : Int64!
    var name : String!
    var type : Int!
    
    
    func toDictionary() -> [String: Any] {
                return [
    "dateAssigned" : dateAssigned
    ,"dateDue" : dateDue
    ,"id" : id
    ,"name" : name
    ,"type" : type
        ]
    }
    
    
    func initFromJSONString(jsonString : String) throws -> Void {
        let decoder = JSONDecoder()
        let payload = try decoder.decode(jsonString) as! JSONDictionaryType
		if(data["dateAssigned"] != nil){
     		dateAssigned =  payload["dateAssigned"] as! NSDate!
		}
		if(data["dateDue"] != nil){
     		dateDue =  payload["dateDue"] as! NSDate!
		}
		if(data["id"] != nil){
     		id =  payload["id"] as! Int64!
		}
		if(data["name"] != nil){
     		name =  payload["name"] as! String!
		}
		if(data["type"] != nil){
     		type =  payload["type"] as! Int!
		}
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 9.99 minutes to type the 999+ characters in this file.
 */


