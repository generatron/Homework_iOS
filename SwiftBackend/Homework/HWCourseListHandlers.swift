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
Filename:     HWCourseListHandlers.swift
Description:  HWCourseList Handlers for REST endpoints 
Project:      Homework
Template: /PerfectSwift/server/entityHandlerClass.swift.vm
 */


class HWCourseListListHandler: BaseRequestHandler  {
  
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Index handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWCourseListCreateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Create handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWCourseListRetrieveHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWCourseListUpdateHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

class HWCourseListDeleteHandler: RequestHandler {
  func handleRequest(request: WebRequest, response: WebResponse) {
    response.appendBodyString("Retrieve handler: You accessed path \(request.requestURI())")
    response.requestCompletedCallback()
  }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 13.23 minutes to type the 1323+ characters in this file.
 */

