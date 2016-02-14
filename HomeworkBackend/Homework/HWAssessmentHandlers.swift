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
Filename:     HWAssessmentHandlers.swift
Description:  HWAssessment Handlers for REST endpoints 
Project:      Homework
Template: /PerfectSwift/server/entityHandlerClass.swift.vm
 */

import PerfectLib

class HWAssessmentListHandler: RequestHandler  {
  
  func handleRequest(request: WebRequest, response: WebResponse) {
  	let hWAssessments : [HWAssessment]  = PersistenceManagerMySQL.sharedInstance.hWAssessmentRepository.list()
  	print (NSJSONSerialization.isValidJSONObject (hWAssessments ))
  	do{
  	let dataFinal = try NSJSONSerialization.dataWithJSONObject (hWAssessments, options: NSJSONWritingOptions (rawValue: 0))
  	let string = NSString (data: dataFinal, encoding: NSUTF8StringEncoding)
  	let tee: String = string as String!
  	response.appendBodyString (tee)
  	}catch{
  	  response.setStatus (500, message: "Could not list HWAssessment data")
  	}
    //response.appendBodyString("Index handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWAssessmentCreateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
     let hWAssessment = HWAssessment() 
     do {
    	try hWAssessment.initFromJSONString(request.postBodyString);
    	let result = try PersistenceManagerMySQL.sharedInstance.hWAssessmentRepository.insert(hWAssessment)
    	response.appendBodyString("Created HWAssessment")
    }catch{
        response.appendBodyString("Error accessing data:  \(error)")
    }
    response.requestCompletedCallback()
  }
}

class HWAssessmentRetrieveHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWAssessmentUpdateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWAssessmentDeleteHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 21.75 minutes to type the 2175+ characters in this file.
 */


