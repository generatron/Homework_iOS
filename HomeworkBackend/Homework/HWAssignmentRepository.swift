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
Filename:     HWAssignmentRepository.swift
Description:  SQLite Persistence code for for HWAssignment
Project:      Homework
Template: /PerfectSwift/server/EntityRepository.swift.vm
 */


import PerfectLib
class HWAssignmentRepository : RepositoryMySQL {
func createTable() throws ->  Int {
   try db.query("CREATE TABLE IF NOT EXISTS hWAssignment (dateAssigned Date, dateDue Date, id Long, isCompleted Boolean, name String, type String)")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: HWAssignment) throws -> Int {
       	let sql = "INSERT INTO hWAssignment(dateAssigned,dateDue,id,isCompleted,name,type) VALUES ( :dateAssigned, :dateDue, :id, :isCompleted, :name, :type)"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":dateAssigned", entity.dateAssigned.SQLiteDateString)
	try stmt.bind(":dateDue", entity.dateDue.SQLiteDateString)
	try stmt.bind(":id", entity.id)
	try stmt.bind(":isCompleted", entity.isCompleted)
	try stmt.bind(":name", entity.name)
	try stmt.bind(":type", entity.type)
        }
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Insert(errorCode)
        }
        return db.changes()
    }
    
    func update(entity: HWAssignment) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWAssignment SET dateAssigned=:dateAssigned ,dateDue=:dateDue ,isCompleted=:isCompleted ,name=:name ,type=:type WHERE id = :id"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":dateAssigned", entity.dateAssigned.SQLiteDateString)
	try stmt.bind(":dateDue", entity.dateDue.SQLiteDateString)
	try stmt.bind(":id", entity.id)
	try stmt.bind(":isCompleted", entity.isCompleted)
	try stmt.bind(":name", entity.name)
	try stmt.bind(":type", entity.type)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Update(errorCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWAssignment) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWAssignment WHERE id = :id"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Delete(errorCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWAssignment? {
        let sql = "SELECT dateAssigned,dateDue,id,isCompleted,name,type FROM HWAssignment WHERE id = :id"
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnText(0))
			columns.append(stmt.columnText(1))
			columns.append(stmt.columnInt64(2))
			columns.append(stmt.columnText(3))
			columns.append(stmt.columnText(4))
			columns.append(stmt.columnInt64(5))
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Select(errorCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        let entity =  HWAssignment()
		entity.dateAssigned = columns[0] as? NSDate
		entity.dateDue = columns[1] as? NSDate
		entity.id = columns[2] as? Int64
		entity.isCompleted = columns[3] as? Bool
		entity.name = columns[4] as? String
		entity.type = columns[5] as? String
	    return entity;
    }
    
    func list() throws -> [HWAssignment] {
        let sql = "SELECT * FROM hWAssignment "
        var entities = [HWAssignment]()
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
                let entity =  HWAssignment()
		entity.dateAssigned = stmt.columnText(0)
		entity.dateDue = stmt.columnText(1)
		entity.id = stmt.columnInt64(2)
		entity.isCompleted = stmt.columnText(3)
		entity.name = stmt.columnText(4)
		entity.type = stmt.columnInt64(5)
        	    entities.append(entity)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 43.42 minutes to type the 4342+ characters in this file.
 */


