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
Filename:     HWAssessmentRepository.swift
Description:  SQLite Persistence code for for HWAssessment
Project:      Homework
Template: /PerfectSwift/server/EntityRepository.swift.vm
 */


import PerfectLib
class HWAssessmentRepository : RepositoryMySQL {
func createTable() throws ->  Int {
   let rs = try db.query("CREATE TABLE IF NOT EXISTS hWAssessment (dateAssigned Date, dateDue Date, id BIGINT(20), name VARCHAR(255), type VARCHAR(255))")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: HWAssessment) throws -> Int {
       	let sql = "INSERT INTO hWAssessment(dateAssigned,dateDue,id,name,type) VALUES ( ?, ?, ?, ?, ?)"
       	
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
	println "\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())"
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
        
        let sql = "UPDATE hWAssessment SET dateAssigned=:dateAssigned ,dateDue=:dateDue ,name=:name ,type=:type WHERE id = :id"

let statement = MySQLStmt(db)
		defer {
			statement.close()
		}
		let prepRes = statement.prepare(sql)
		
		let prepRes = statement.prepare(sql)
		if(prepRes){		
	statement.bindParam(entity.dateAssigned.SQLiteDateString)
	statement.bindParam(entity.dateDue.SQLiteDateString)
	statement.bindParam(entity.id)
	statement.bindParam(entity.name)
	statement.bindParam(entity.type)

let execRes = statement.execute()
if(!execRes){
	println "\(statement.errorCode()) \(statement.errorMessage()) - \(db.errorCode()) \(db.errorMessage())"
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
        
        let sql = "DELETE FROM hWAssessment WHERE id = :id"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Delete(errorCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWAssessment? {
        let sql = "SELECT dateAssigned,dateDue,id,name,type FROM HWAssessment WHERE id = :id"
        var columns = [Any]()
        let rs =  try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnText(0))
			columns.append(stmt.columnText(1))
			columns.append(stmt.columnInt64(2))
			columns.append(stmt.columnText(3))
			columns.append(stmt.columnInt64(4))
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Select(errorCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        let entity =  HWAssessment()
		entity.dateAssigned = columns[0] as? NSDate
		entity.dateDue = columns[1] as? NSDate
		entity.id = columns[2] as? Int64
		entity.name = columns[3] as? String
		entity.type = columns[4] as? String
	    return entity;
    }
    
    func list() throws -> [HWAssessment] {
        let sql = "SELECT * FROM hWAssessment "
        var entities = [HWAssessment]()
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
                let entity =  HWAssessment()
		entity.dateAssigned = stmt.columnText(0)
		entity.dateDue = stmt.columnText(1)
		entity.id = stmt.columnInt64(2)
		entity.name = stmt.columnText(3)
		entity.type = stmt.columnInt64(4)
        	    entities.append(entity)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 44.48 minutes to type the 4448+ characters in this file.
 */


