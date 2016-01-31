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
class HWAssignmentRepository : Repository {
func createTable() throws -> {
   try db.execute("CREATE TABLE IF NOT EXISTS hWAssignment (dateAssigned TEXT, dateDue TEXT, id NUMBER, isCompleted NUMBER, name TEXT, type TEXT)")
   let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.CreateTable(errCode)
      }
}
func insert(entity: HWAssignment) throws -> Int {
       	let sql = "INSERT INTO hWAssignment(dateAssigned,dateDue,id,isCompleted,name,type) VALUES ( :dateAssigned, :dateDue, :id, :isCompleted, :name, :type)"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":dateAssigned", entity.dateAssigned)
			try stmt.bind(":dateDue", entity.dateDue)
			try stmt.bind(":id", entity.id)
			try stmt.bind(":isCompleted", entity.isCompleted)
			try stmt.bind(":name", entity.name)
			try stmt.bind(":type", entity.type)
        }
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Insert(errCode)
        }
        return db.changes()
    }
    
    func update(entity: HWAssignment) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWAssignment SET dateAssigned=:dateAssigned ,dateDue=:dateDue ,isCompleted=:isCompleted ,name=:name ,type=:type WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":dateAssigned", entity.dateAssigned)
			try stmt.bind(":dateDue", entity.dateDue)
			try stmt.bind(":id", entity.id)
			try stmt.bind(":isCompleted", entity.isCompleted)
			try stmt.bind(":name", entity.name)
			try stmt.bind(":type", entity.type)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Update(errCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWAssignment) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWAssignment WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Delete(errCode)
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
			columns.append(stmt.columnInt(2))
			columns.append(stmt.columnText(3))
			columns.append(stmt.columnText(4))
			columns.append(stmt.columnInt(5))
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Select(errCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        return HWAssignment(
		dateAssigned: columns[0] as? NSDate
		,dateDue: columns[1] as? NSDate
		,id: columns[2] as? Int64
		,isCompleted: columns[3] as? Bool
		,name: columns[4] as? String
		,type: columns[5] as? String
        )
    }
    
    func list() throws -> [HWAssignment] {
        let sql = "SELECT * FROM hWAssignment "
        var entities = [HWAssignment]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
        	entities.append(
        		HWAssignment(
				dateAssigned: columns[0] as? NSDate
				,dateDue: columns[1] as? NSDate
				,id: columns[2] as? Int64
				,isCompleted: columns[3] as? Bool
				,name: columns[4] as? String
				,type: columns[5] as? String
        		)
        	)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 41.15 minutes to type the 4115+ characters in this file.
 */

