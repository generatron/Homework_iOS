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
Filename:     HWAssessmentRepositoryMySQL.swift
Description:  Persistence code for for HWAssessment
Project:      Homework
Template: /PerfectSwift/server/EntityRepositoryMySQL.swift.vm
 */


import MySQL
class HWAssessmentRepositoryMySQL : RepositoryMySQL {
func createTable() throws ->  Int {
   let rs = try db.query("CREATE TABLE IF NOT EXISTS HWAssessment (dateAssigned Date, dateDue Date, id BIGINT(20) NOT NULL AUTO_INCREMENT, name VARCHAR(255), type INT(10), PRIMARY KEY (id))")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: HWAssessment) throws -> Int {
       	let sql = "INSERT INTO hWAssessment(dateAssigned,dateDue,name,type) VALUES ( ?, ?, ?, ?)"
       	
       	let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		if(prepRes){
	statement.bindParam(entity.dateAssigned.SQLiteDateString)
	statement.bindParam(entity.dateDue.SQLiteDateString)
	statement.bindParam(entity.id)
	statement.bindParam(entity.name)
	statement.bindParam(entity.type)


let execRes = statement.execute()
if(!execRes){
	print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
	let errorCode = db.errorCode()
	if errorCode > 0 {
	    throw RepositoryError.Insert(errorCode)
	}
}
	
statement.close()
}        
 return 0
}
    
    func update(entity: HWAssessment) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWAssessment SET dateAssigned= ? ,dateDue= ? ,name= ? ,type= ? WHERE id = ?"

let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){		
	statement.bindParam(entity.dateAssigned.SQLiteDateString)
	statement.bindParam(entity.dateDue.SQLiteDateString)
	statement.bindParam(entity.name)
	statement.bindParam(entity.type)
statement.bindParam(entity.id)
let execRes = statement.execute()
if(!execRes){
	print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
	let errorCode = db.errorCode()
	if errorCode > 0 {
	    throw RepositoryError.Update(errorCode)
	}
}
	
statement.close()
		}
        
		return 0
    }
    
	func delete(entity: HWAssessment) throws -> Int {
	    guard let id = entity.id else {
	        return 0
	    }
	    
	    let sql = "DELETE FROM hWAssessment WHERE id = ?"
	    let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		if(prepRes){
			//HARDCODED might not exist, assuming it does, need to retrieve PK
			statement.bindParam(entity.id)
			
			let execRes = statement.execute()
	        if(!execRes){
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
	    			throw RepositoryError.Delete(errorCode)
				}
				statement.close()
			}
				
		}
		return 0
	}
    
    func retrieve(id: Int) throws -> HWAssessment? {
        let sql = "SELECT dateAssigned,dateDue,id,name,type FROM HWAssessment WHERE id = ?"
       	let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		let entity = HWAssessment()
		if(prepRes){
			//HARDCODED might not exist, assuming it does, need to retrieve PK
			statement.bindParam(id)
			
			let execRes = statement.execute()
            if(!execRes){
            	let results = statement.results()
            	
            	let ok = results.forEachRow { e in
            		print(e.flatMap({ (a:Any?) -> Any? in
                    return a!
                	}))
                	
                	print("Another sentence")
				}
			
				print("\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())")
				let errorCode = db.errorCode()
				if errorCode > 0 {
	    			throw RepositoryError.Delete(errorCode)
				}
				statement.close()
			}
				
		}
	    return entity;
    }
    
    func list() -> [HWAssessment] {
        let sql = "SELECT * FROM hWAssessment "
        var entities = [HWAssessment]()
        
        let queryResult = db.query(sql)
        let results = db.storeResults()!
  
        while let row = results.next() {
        	let hWAssessment = HWAssessment()
	hWAssessment.dateAssigned = NSDate(string: row[0]);
	hWAssessment.dateDue = NSDate(string: row[1]);
	hWAssessment.id = Int64(row[2]);
	hWAssessment.name = String(row[3]);
	hWAssessment.type = Int(row[4]);
entities.append(hWAssessment)
            print(row)
        }
        results.close()
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 46.89 minutes to type the 4689+ characters in this file.
 */


